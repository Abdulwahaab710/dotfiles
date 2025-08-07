#include "app_status.hpp"
#include <iostream>
#include <sstream>
#include <string>
#include <thread>
#include <chrono>
#include <cctype>
#include <cstdlib>
#include <unordered_set>


namespace sketchybar{
namespace AppMonitor {

AppMonitor::AppMonitor() : m_isUpdated(false), m_command("sketchybar -m") {}

bool AppMonitor::init(int argc, char* argv[]) noexcept {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " app1 app2 ..." << std::endl;
        return false;
    }

    m_appList.reserve(argc - 1);
    for (int i = 1; i < argc; ++i) {
        m_appList.emplace_back(argv[i]);
    }

    for (const auto& app : m_appList) {
        m_statusList.emplace(app, AppStatus(app));
    }

    return true;
}

void AppMonitor::start_loop(const int interval) noexcept {
    while (true) {
        update_apps_status();
        generate_update_command();
        send_update_command();
        std::this_thread::sleep_for(std::chrono::seconds(interval));
    }
}

std::string AppMonitor::run_command(const std::string& cmd) const noexcept{
    std::string result;
    char buffer[4096];
    FILE* pipe = popen(cmd.c_str(), "r");
    if (!pipe) return "";
    while (fgets(buffer, sizeof(buffer), pipe) != nullptr) {
        result += buffer;
    }
    pclose(pipe);
    return result;
}


static std::string extract_status_label(const std::string& line) {
    const std::string key = "\"StatusLabel\"={ \"label\"=\"";
    auto start = line.find(key);
    if (start == std::string::npos) return "0";
    start += key.length();
    auto end = line.find("\"", start);
    if (end == std::string::npos || start == end) return "0";
    return line.substr(start, end - start);
}

void AppMonitor::update_apps_status() noexcept {
    std::string output = run_command("lsappinfo -all list");
    std::istringstream stream(output);
    std::string line;

    std::unordered_set<std::string_view> visited;
    while (std::getline(stream, line)) {
        for (auto& [name, status] : m_statusList) {
            if (visited.contains(name)) continue;
            if (line.find(name) != std::string::npos) {
                visited.insert(name);
                bool prev_logged_in = status.logged_in;
                const std::string prev_message_count = std::move(status.message_count);
                
                status.message_count = extract_status_label(line);
                status.logged_in = true;
                
                //std::cout << name << "->" << "[" << prev_logged_in << "-1], [" << prev_message_count << "-" << status.message_count << "]\n\n\n";
                
                status.updated = (status.logged_in != prev_logged_in || status.message_count != prev_message_count);
                m_isUpdated = m_isUpdated || status.updated;
                break;
            }
        }
    }
}

void AppMonitor::generate_update_command() noexcept {
    for (auto& [_, status] : m_statusList) {
        if (status.updated) {
            m_command += status.get_command();
        }
    }
}

void AppMonitor::send_update_command() noexcept {
    if (m_isUpdated) {
        std::cout << "command:" << m_command <<'\n';
        system(m_command.c_str());
        m_command = "sketchybar -m";
        m_isUpdated = false;
    }
}

} // namespace AppMonitor
} // namespace sketchybar