#pragma once
#include <string>
#include <string_view>
#include <unordered_map>
#include <vector>
#include <charconv> 

namespace sketchybar { 
namespace AppMonitor {

struct AppStatus {
    bool logged_in = false;
    std::string message_count = "0";
    bool updated = false;

    std::string cmd_hide_all;     // drawing=off
    std::string cmd_show_no_msg;  // drawing=on icon.drawing=on label.drawing=off
    std::string cmd_show_with_msg;// drawing=on icon.drawing=on label="  " label.drawing=on

    AppStatus(const std::string& name) {
        cmd_hide_all     = " --set " + name + " drawing=off";
        cmd_show_no_msg  = " --set " + name + " drawing=on icon.drawing=on label.drawing=off";
        cmd_show_with_msg = " --set " + name + " drawing=on icon.drawing=on label.drawing=on label=\"";
    }

    // return the command accord current status
    const std::string get_command() {
        if (!logged_in) {
            return cmd_hide_all;
        }
        int message_number = 0;
        std::from_chars(message_count.data(), message_count.data() + message_count.size(), message_number);
        if (message_number > 0) {
            // 替换前两个空格为消息数量
            return cmd_show_with_msg + message_count + "\"";
        } else {
            return cmd_show_no_msg;
        }
    }
};

class AppMonitor{
public:
  AppMonitor();
  ~AppMonitor() = default;

  // initialize applist and statuslist
  bool init(int argc, char *argv[]) noexcept;

  // main loop, exec
  void start_loop(const int interval) noexcept; 

private:
  // lsappinfo -all list -> all apps
  void update_apps_status() noexcept;

  // accord the status to generate the "-m" command
  void generate_update_command() noexcept;

  // send command to sketchybar
  void send_update_command() noexcept;

  std::string run_command(const std::string& cmd) const noexcept;

private:
  std::vector<std::string> m_appList;
  std::unordered_map<std::string_view, AppStatus> m_statusList;
  bool m_isUpdated;
  std::string m_command; // "sketchybar -m" + any others
};

} }