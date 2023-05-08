# Data Structure

### Linux List

```C
struct list_head {
  struct list_head *next;
    struct list_head *prev;
    
}
`````

需要把list_head嵌入原有的数据结构中进行使用，关键是利用container_of()宏获取包含list_head结构体的父类型结构体

```C
struct fox {
  int color;
    bool is_fantastic;
      struct list_head list;
      
}

static LIST_HEAD(fox_list) // 初始化一个fox_list链表例程
`````

### Linux 链表的 API

```C
list_add(struct list_head *new, struct list_head *head) // 给链表添加一个节点,位置在head的next
list_add_tail(struct list_head *new, struct list_head *head) // 位置在head的prev

list_del(struct list_head *entry) //从链表中移除entry项，需要手动释放entry项
list_del_init(struct list_head *entry) // 从链表中移除entry项并对entry项初始化

list_move(struct list_head *list, struct list_head *head) // 从链表中移除list项，并加入head节点next
list_move_tail(struct list_head *list, struct list_head *head) // 位置在head的prev

list_empty(struct list_head *head) // 判断链表是否为空，空则返回非0,否则返回0

list_splice(struct list_head *list, struct list_head *head) // 两链表合并
list_splice_init(struct list_head *list, struct list_head *head) // 合并并初始化list列表
`````

### 遍历链表

```C
struct list_head *p;
struct fox *f;
list_for_each(p,list)
{
  // 每次循环p都会指向list_head结构体
    f = lilst_entry(p, struct fox, list)
      // 每次循环f都会指向fox结构体
      
}

struct fox *f
list_for_each_entry(f, &fox_list, list)
{
  // 每次循环f都指向fox结构体
  
}

list_for_each(pos,head) // pos是list_head指针的临时变量，head是需要遍历的结构体的链表头
list_for_each_entry(pos,head,member) // pos是需要遍历的结构体的指针的临时变量，
// head是需要遍历的结构体的链表头，member为需要遍历的结构体中链表的名称
list_for_each_entry_reverse() // 反向遍历
`````



## Kernel Queue

kfifo提供enqueue(入队列)和dequeue(出队列)两个操作，两个偏移量 入口偏移 & 出口偏移。

入口偏移：队尾偏移，指向下一次入队列时的位置

出口偏移：队首偏移，指向下一次出队列的位置

永远满足出口偏移小于入口偏移，出口偏移等于入口偏移说明队列为空，入口偏移等于队列长度说明队列为满

```C
int kfifo_alloc(struct kfifo *fifo, unsigned int size, gfp_t gfp_mask)
// 创建大小为size的kfifo,内核使用gfp_mask标识分配队列，成功返回0,否则返回非负数错误码

void kfifo_init(struct kfifo *fifo, void *buffer, unsigned int size)
// 在指定的缓冲区buffer上创建大小为size的kfifo

// size都必须是2的幂
unsigned int kfifo_in(struct kfifo *fifo, const void *from, unsigned int len)
// 把from指针所指的len字节的数据拷贝到fifo所指的队列中，返回推入数据的字节大小

unsigned int kfifo_out(struct kfifo *fifo, void *to, unsigned int len)
// 从fifo所指的队列中，拷贝出长度为len字节的数据到to所指的缓冲中，返回拷贝的数据大小

unsigned int kfifo_out_peek(struct kfifo *fifo, void *to, unsigned int len, unsigned offset)
// 从fifo所指的队列，并做offset的偏移后，拷贝长度为len字节的数据到to所指的缓冲区中，返回拷贝数据的大小，但fifo
// 的出口偏移不变

static inline unsigned int kfifo_size(struct kfifo *fifo)
// 返回kfifo队列空间的总体大小（以字节为单位）

static inline unsigned int kfifo_len(struct kfifo *fifo)
// 返回kfifo队列中已经堆入的数据大小

static inline unsigned int kfifo_avail(struct kfifo *fifo)
// 返回kfifo队列中的可用空间

static inline int kfifo_is_empty(struct kfifo *fifo)
static inline int kfifo_is_full(struct kfifo *fifo)

static inline void kfifo_reset(struct kfifo *fifo) // 抛弃队列中的所有内容
void kfifo_free(struct kfifo *fifo) // 释放分配的队列
`````



## Kernel Map

由唯一键组成的集合，每个键关联一个特定的值，支持Add(key, value) Remove(key) Lookup(key)三种操作

idr数据结构用于映射用户空间的UID，映射唯一的标识数(UID)到一个指针

```C
void idr_init(struct idr *idp) // 初始化一个idr结构

int idr_pre_get(struct idr* idp, gfp_t gfp_mask) // 调整idp指向的idr的大小
// 成功返回1,失败返回0
int idr_get_new(struct idr* idp, void *ptr, int *id) // 获取新的uid
// 成功时返回0，ptr映射到UID上，并将新UID保存于id中；失败则返回非0的错误码，-EAGAIN表示需要再次idr_pre_get()
int idr_get_new_above(struct idr* idp, void *ptr, int starting_id, int *id) // 获取新的uid
// 与idr_get_new()相同，但是保证获取的UID大于starting_id指定的大小

void *idr_find(struct idr *idp, int id)
// 调用成功则返回id关联的指针，否则返回空指针

void idr_remove(struct *idr idp, int id)
// 从idp中删除UID,无法提示任何错误

void idr_destory(struct idr* idp) // 释放idr中未使用的内存
void idr_remove_all(struct idr* idp) // 强制删除所有的UID
`````



## Kernel rbTree

```C
struct rb_root root = RB_ROOT; // 创建红黑树
`````
