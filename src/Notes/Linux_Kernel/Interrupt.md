# Interrupt

## Interrupt
Hardware send notification to processor, interrupt signal doesn't sync with processor timer, and can be gernerated at any time.

Interrupt signal made by different device differs from each other and is identified by an unique number. These interrupt value are called IRQ.

## Interrupt Handler Program
Kernel will exec a program to deal with the specific interrupt, which is called interrupt handler or interrupt service routine(ISR).

The interrupt handler program is part of its driver program. Device driver program is the kernel codes which manage the device.

## top half and bottom half
1. top half: running interrupt program, only finish the work that has strict time limitation. All these work are accomplished under interrupt-disable environment.
2. bottom half: finish the work which can be dalayed from top half. All these work are accomplished under interrupt-enable environment.

## register ISR
Driver regist interrupt serive routine for device, using function named `request_irq`
```
// return 0 if success, return non-zero with error code
int request_irq(unsigned int irq, 
            irq_handler_t handler, 
            unsigned long flags, 
            const char *name,
            void *dev
            )

// prototype of handler func
typedef irqreturn_t (* irq_handler_t)(int, void *);

```
`irq` is pre-defined or dynamic detected 

`handler` point to the exact ISR

`flag` can be zero or bitmask,
IRQF_DISABLED means the program disable all other interrupt when this handler program running,
IRQF_SAMPLE_RANDOM means this interrupt will influence the entropy pool,
IRQF_TIMER is prepared for interrupt from system timers,
IRQF_SHARD means more than one interrupt handle program can share the same IRQ number,

`name` is the ASCII txt representation of interrupt device

`dev` is used for IRQ sharing,
if the IRQ isn't shared, the dev field can be NULL. if IRQ is shared, the dev field must specify the device

return zero if success, return error code(not zero) if failed

### Warning
request_irq() may sleep, thus we shouldn't use this function in interrupt context or other codes that shouldn't be blocked.
We must finish initiation of the hardware before register the interrupt handle program

## free ISR

```
    void free_irq(unsigned int irq, void *dev)
```
delete the ISA and invaliadate irq when irq is not shared, otherwise only delete the ISR of dev

## code a ISR
