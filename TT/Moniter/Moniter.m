//
//  Moniter.m
//  TT
//
//  Created by 尹凡 on 8/31/18.
//  Copyright © 2018 fanyin. All rights reserved.
//

#import "Moniter.h"

@implementation Moniter


static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
        Moniter *object = (__bridge Moniter*)info;
    
        // 记录状态值
        object.activity = activity;
        NSLog(@"moniter runLoopObserverCallBack  activity =  %d\n",activity);
        //发送信号
        dispatch_semaphore_t semaphore = object.semaphore;
        dispatch_semaphore_signal(semaphore);
}

- (void)registerObserver
{
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                                            kCFRunLoopAllActivities,
                                                            YES,
                                                            0,
                                                            &runLoopObserverCallBack,
                                                            &context);
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    
    // 创建信号
    self.semaphore = dispatch_semaphore_create(0);
   
    // 在子线程监控时长
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (YES)
        {
            // 假定连续5次超时50ms认为卡顿(当然也包含了单次超时250ms)
            long st = dispatch_semaphore_wait(self.semaphore, dispatch_time(DISPATCH_TIME_NOW, 50*NSEC_PER_MSEC));
            NSLog(@"moniter waiter =  %ld\n",st);
            if (st != 0)
            {
               NSLog(@"moniter  activity =  %d\n",_activity);
                if (_activity==kCFRunLoopBeforeSources || _activity==kCFRunLoopAfterWaiting)
                {
                    NSLog(@"_timeoutCount = %d",_timeoutCount);
                    if (++_timeoutCount < 5)
                        continue;
                    
                    NSLog(@"好像有点儿卡哦");
                }
            }
            _timeoutCount = 0;
        }
    });
}

@end
