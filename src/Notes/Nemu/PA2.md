# PA2
## 2023.8.6
1. 应用程序的运行都需要运行时环境的支持
2. 通过库，运行程序所需的公共要素被抽象成API，不同的架构通过实现这些API，实现了支持程序运行的运行时环境
3. 抽象计算机AM(Abstract Machine)是代表程序运行对计算机的需求的一组API。
4. **AM = TRM + IOE + CTE + VME + MPE**
   1. **TRM(Turing Machine)**：提供基本的计算能力
   2. **IOE(I/O Extension)**：提供输入输出能力
   3. **CTE(Context EXtension)**：提供上下文管理能力
   4. **VME(Virtual Memory Extension)**：提供虚存管理能力
   5. **MPE(Multi-Processor EXtension)**：提供多处理器通信能力
5. NEMU(模拟硬件提供硬件功能)->AM(提供运行时环境)->APP(运行程序)

## 2023.8.10
1. 利用计算机**硬件的功能**实现AM
2. 如何搭建硬件NEMU和软件AM之间的桥梁？
3. 架构相关的运行时环境 -> AM； 架构无关的运行时环境 -> klib
4. 在AM之上运行的代码(包括klib都是架构无关的)
5. ARCH=native and !define(\_\_NATIVE\_USE\_KLIB\_\_) -> test on glibc & real machine; ARCH=native and define(\_\_NATIVE\_USE\_KLIB\_\_) -> test on klib & real machine; ARCH=riscv64-nemu  -> test on NEMU

## 2023.8.11
1. 访问设备 = 读出数据 + 写入数据 + 获取修改控制状态
2. 把设备的寄存器作为接口 输入输出数据 -> CPU读取写入**数据寄存器**；获取修改控制状态 -> CPU读取写入**命令寄存器**
3. 端口映射I/O(port-mapped I/O)：CPU使用专门的I/O指令对设备进行访问，并把设备的地址称作**端口号**
4. 内存映射I/O(memory-mapped I/O)：将部分物理内存重定向到I/O地址空间内
5. volatile关键字阻止编译器对相应代码进行优化
6. ```
   状态机模型        |     状态机模型外
   S = <R,M>              D
   计算机/程序  <-I/O指令-> 设备 <- 模拟电路 -> 物理世界```
- 执行普通指令：状态机按照TMR状态转移
- 执行设备输出相关指令：状态机只更新PC，设备状态和物理世界变化
- 执行设备输入相关指令：状态机将要转移的状态取决于**执行这条指令时设备的状态**