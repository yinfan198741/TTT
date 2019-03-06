//
//  Moniter.h
//  TT
//
//  Created by 尹凡 on 8/31/18.
//  Copyright © 2018 fanyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Moniter : NSObject

@property(nonatomic ,assign) CFRunLoopActivity activity;
@property(nonatomic , strong )dispatch_semaphore_t semaphore;
@property(nonatomic , assign )int timeoutCount;
- (void)registerObserver;
@end
