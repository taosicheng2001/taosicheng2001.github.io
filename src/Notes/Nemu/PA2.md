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