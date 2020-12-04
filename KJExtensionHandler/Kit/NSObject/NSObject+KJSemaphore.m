//
//  NSObject+KJSemaphore.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/15.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSObject+KJSemaphore.h"
#import <objc/runtime.h>
@implementation NSObject (KJSemaphore)
/// 发送消息处理
- (id)kj_sendSemaphoreWithKey:(NSString*)key Message:(id)message Parameter:(id _Nullable)parameter{
#ifdef DEBUG
    NSLog(@"🍒🍒 发送信号消息 🍒🍒\nSenderKey:%@\n目标:%@\n发送者:%@\n携带参数:%@",key,message,self,parameter);
#endif
    return self.semaphoreblock?self.semaphoreblock(key,message,parameter):nil;
}
/// 接收消息处理
- (void)kj_receivedSemaphoreBlock:(KJSemaphoreBlock)block{
    if (block) self.semaphoreblock = block;
}
#pragma mark - associated
- (KJSemaphoreBlock)semaphoreblock{
    return objc_getAssociatedObject(self, @selector(semaphoreblock));
}
- (void)setSemaphoreblock:(KJSemaphoreBlock)semaphoreblock{
    objc_setAssociatedObject(self, @selector(semaphoreblock), semaphoreblock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
