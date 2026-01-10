#include <algorithm>
#include <cstdlib>
#include <ctime>
#include <iomanip>
#include <iostream>
#include <vector>

// 电梯调度算法(SCAN算法)
// 磁头从当前位置沿指定方向移动，服务沿途所有请求，到达边界后反向
class ElevatorScheduler {
  private:
    int totalTracks;        // 磁道总数
    int currentPosition;    // 当前磁头位置
    bool movingUp;          // 移动方向：true-向磁道号增加方向，false-向减少方向
    std::vector<int> queue; // 磁道请求队列

  public:
    ElevatorScheduler(int tracks, int initial, bool upward)
        : totalTracks(tracks), currentPosition(initial), movingUp(upward) {}
    // 添加磁道请求到队列
    void addRequest(int track) {
        if (track >= 0 && track < totalTracks) {
            queue.push_back(track);
        }
    }
    // 生成随机磁道请求序列
    void generateRandomRequests(int count) {
        srand(static_cast<unsigned>(time(0)));
        for (int i = 0; i < count; ++i) {
            int track = rand() % totalTracks;
            queue.push_back(track);
        }
    }
    // 显示请求队列
    void displayQueue() const {
        std::cout << "磁道请求序列: ";
        for (size_t i = 0; i < queue.size(); ++i) {
            std::cout << queue[i];
            if (i < queue.size() - 1)
                std::cout << ", ";
        }
        std::cout << "\n";
    }
    // 执行电梯调度算法
    void schedule() {
        if (queue.empty()) {
            std::cout << "请求队列为空，无需调度。\n";
            return;
        }
        std::vector<int> upperRequests; // 当前位置之上的请求
        std::vector<int> lowerRequests; // 当前位置之下的请求
        std::vector<int> serviceOrder;  // 服务顺序
        int totalSeek = 0;              // 总寻道长度
        // 分类请求：大于等于当前位置的为上，小于的为下
        for (int track : queue) {
            if (track >= currentPosition) {
                upperRequests.push_back(track);
            } else {
                lowerRequests.push_back(track);
            }
        }
        // 排序
        std::sort(upperRequests.begin(), upperRequests.end());
        std::sort(lowerRequests.begin(), lowerRequests.end(),
                  std::greater<int>());
        std::cout << "\n========== 电梯调度过程 ==========\n";
        std::cout << "初始磁头位置: " << currentPosition << " 号磁道\n";
        std::cout << "初始移动方向: "
                  << (movingUp ? "向磁道号增加方向" : "向磁道号减少方向")
                  << "\n\n";
        std::cout << std::left << std::setw(8) << "步骤" << std::setw(12)
                  << "服务磁道" << std::setw(15) << "移动距离" << std::setw(15)
                  << "当前总寻道" << "\n";
        std::cout << std::string(50, '-') << "\n";
        int step = 1;
        // 根据初始方向决定服务顺序
        if (movingUp) {
            // 先向上服务所有请求
            for (int track : upperRequests) {
                int seek = abs(track - currentPosition);
                totalSeek += seek;
                serviceOrder.push_back(track);
                std::cout << std::left << std::setw(8) << step++
                          << std::setw(12) << track << std::setw(15) << seek
                          << std::setw(15) << totalSeek << "\n";
                currentPosition = track;
            }
            // 到达上边界后反向，服务下方请求
            if (!lowerRequests.empty()) {
                std::cout << "--- 到达边界，调转方向 ---\n";
                for (int track : lowerRequests) {
                    int seek = abs(track - currentPosition);
                    totalSeek += seek;
                    serviceOrder.push_back(track);
                    std::cout << std::left << std::setw(8) << step++
                              << std::setw(12) << track << std::setw(15) << seek
                              << std::setw(15) << totalSeek << "\n";
                    currentPosition = track;
                }
            }
        } else {
            // 先向下服务所有请求
            for (int track : lowerRequests) {
                int seek = abs(track - currentPosition);
                totalSeek += seek;
                serviceOrder.push_back(track);
                std::cout << std::left << std::setw(8) << step++
                          << std::setw(12) << track << std::setw(15) << seek
                          << std::setw(15) << totalSeek << "\n";
                currentPosition = track;
            }
            // 到达下边界后反向，服务上方请求
            if (!upperRequests.empty()) {
                std::cout << "--- 到达边界，调转方向 ---\n";
                for (int track : upperRequests) {
                    int seek = abs(track - currentPosition);
                    totalSeek += seek;
                    serviceOrder.push_back(track);
                    std::cout << std::left << std::setw(8) << step++
                              << std::setw(12) << track << std::setw(15) << seek
                              << std::setw(15) << totalSeek << "\n";
                    currentPosition = track;
                }
            }
        }
        double avgSeek = static_cast<double>(totalSeek) / queue.size();
        std::cout << "\n========== 调度统计 ==========\n";
        std::cout << "服务顺序: ";
        for (size_t i = 0; i < serviceOrder.size(); ++i) {
            std::cout << serviceOrder[i];
            if (i < serviceOrder.size() - 1)
                std::cout << " -> ";
        }
        std::cout << "\n";
        std::cout << "总寻道长度: " << totalSeek << " 个磁道\n";
        std::cout << "请求总数: " << queue.size() << " 个\n";
        std::cout << "平均寻道长度: " << std::fixed << std::setprecision(2)
                  << avgSeek << " 个磁道\n";
    }
};

int main() {
    const int TOTAL_TRACKS = 200;     // 磁盘总磁道数
    const int INITIAL_POSITION = 100; // 初始磁头位置
    const bool MOVING_UP = true;      // 初始移动方向：向磁道号增加方向
    const int REQUEST_COUNT = 15;     // 随机生成的请求数量

    ElevatorScheduler scheduler(TOTAL_TRACKS, INITIAL_POSITION, MOVING_UP);

    std::cout << "========== 磁盘调度模拟 - 电梯调度算法(SCAN) ==========\n";
    std::cout << "磁盘总磁道数: " << TOTAL_TRACKS << "\n";
    std::cout << "初始磁头位置: " << INITIAL_POSITION << " 号磁道\n";
    std::cout << "初始移动方向: 向磁道号增加方向\n\n";

    // 生成随机请求
    scheduler.generateRandomRequests(REQUEST_COUNT);
    scheduler.displayQueue();

    // 执行调度
    scheduler.schedule();

    std::cout << "\n程序结束。\n";
    return 0;
}
