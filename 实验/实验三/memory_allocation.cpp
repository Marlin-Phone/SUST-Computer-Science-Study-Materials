#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

// 表示内存中的一个分区（可空闲或已分配）
struct Block {
    int start;       // 起始地址（K）
    int size;        // 长度（K）
    bool free;       // 是否空闲（true: 空闲, false: 已分配）
    std::string job; // 占用该分区的作业名，空闲时为空串
};

// 合并相邻空闲分区
// 遍历分区表，将相邻且均为空闲的区合并为一个更大的空闲区，保持表紧凑
void mergeFree(std::vector<Block> &blocks) {
    for (size_t i = 0; i + 1 < blocks.size();) {
        if (blocks[i].free && blocks[i + 1].free) {
            blocks[i].size += blocks[i + 1].size;
            blocks.erase(blocks.begin() + static_cast<long long>(i + 1));
        } else {
            ++i;
        }
    }
}

// 最先适应分配（First-Fit）
// 顺序查找第一个空闲区使其满足所需大小：
// - 若大小等于需求：直接标记为已分配并记录作业
// - 若大于需求：切分为已分配前段和剩余空闲后段
// 返回是否分配成功
bool allocateFirstFit(std::vector<Block> &blocks, const std::string &job,
                      int size) {
    for (size_t i = 0; i < blocks.size(); ++i) {
        Block &b = blocks[i];
        if (!b.free || b.size < size)
            continue;

        if (b.size == size) {
            b.free = false;
            b.job = job;
        } else {
            Block allocated{b.start, size, false, job};
            b.start += size;
            b.size -= size;
            blocks.insert(blocks.begin() + static_cast<long long>(i),
                          allocated);
        }
        return true;
    }
    return false;
}

// 释放指定作业占用的分区
// 根据作业名查找分区并标记为空闲，随后尝试合并相邻空闲区
// 返回是否成功释放（找到并释放）
bool releaseJob(std::vector<Block> &blocks, const std::string &job) {
    for (auto &b : blocks) {
        if (!b.free && b.job == job) {
            b.free = true;
            b.job.clear();
            mergeFree(blocks);
            return true;
        }
    }
    return false;
}

// 检查可分配性
// 若存在任一空闲分区大小 >= size 则返回 true（仅用于判断）
bool canAllocate(const std::vector<Block> &blocks, int size) {
    for (const auto &b : blocks) {
        if (b.free && b.size >= size)
            return true;
    }
    return false;
}

// 输出当前分区表（表格形式）
// 包含序号、起址、长度和状态（未分配或作业名）
void printTable(const std::vector<Block> &blocks, const std::string &title) {
    std::cout << "\n" << title << "\n";
    std::cout << std::left << std::setw(8) << "序号" << std::setw(12)
              << "起址(K)" << std::setw(12) << "长度(K)" << std::setw(12)
              << "状态" << "\n";
    std::cout << std::string(44, '-') << "\n";
    for (size_t i = 0; i < blocks.size(); ++i) {
        const auto &b = blocks[i];
        std::string state = b.free ? "未分配" : ("作业" + b.job);
        std::cout << std::left << std::setw(8) << i << std::setw(12) << b.start
                  << std::setw(12) << b.size << std::setw(12) << state << "\n";
    }
}

int main() {
    const int totalMemory = 640;                           // 设定主存总量 640K
    std::vector<Block> blocks{{0, totalMemory, true, ""}}; // 初始只有一个空闲区

    printTable(blocks, "初始空闲区说明表");

    struct Step {
        std::string action;
        std::string job;
        int size;
    };
    std::vector<Step> steps = {{"alloc", "1", 300}, {"alloc", "2", 100},
                               {"free", "1", 0},    {"alloc", "3", 150},
                               {"alloc", "4", 30},  {"alloc", "5", 40},
                               {"alloc", "6", 60},  {"free", "4", 0}};

    for (size_t i = 0; i < steps.size(); ++i) {
        const auto &s = steps[i];
        bool ok = false;
        if (s.action == "alloc") {
            ok = allocateFirstFit(blocks, s.job, s.size);
            std::cout << "\n步骤" << (i + 1) << ": 作业" << s.job << " 申请 "
                      << s.size << "K -> " << (ok ? "成功" : "失败") << "\n";
        } else {
            ok = releaseJob(blocks, s.job);
            std::cout << "\n步骤" << (i + 1) << ": 作业" << s.job << " 释放 -> "
                      << (ok ? "完成" : "未找到") << "\n";
        }
        mergeFree(blocks);
        printTable(blocks, "当前主存分区");
    }

    std::cout << "\n额外检查：若再申请 100K 作业空间，"
              << (canAllocate(blocks, 100) ? "可以满足" : "无法满足") << "。\n";

    return 0;
}
