#include <linux/module.h>     //included for all kernel modules
#include <linux/kernel.h>     //included for KERN_INFO
#include <linux/init.h>       //included for __init and __exit macros

static int __init hello_world_init(void)
{
       
    printk(KERN_INFO "Q_sh : %s() : called\n", __FUNCTION__);
    return 0;
}

static void __exit hello_world_finish(void)
{
    printk(KERN_INFO "Q_sh : %s() : Bye.\n", __FUNCTION__);
}

module_init(hello_world_init);
module_exit(hello_world_finish);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("sehoon<weed700@gmail.com>");
MODULE_DESCRIPTION("Hello world for Linux Kernel module");


