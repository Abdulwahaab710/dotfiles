#include "app_status.hpp"


int main(int argc, char* argv[]) {
    sketchybar::AppMonitor::AppMonitor app_monitor;
    if (app_monitor.init(argc, argv) == false) {
        return -1;
    }
    
    app_monitor.start_loop(5);
    return 0;
}