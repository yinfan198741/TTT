//
//  HookBird.m
//  TT
//
//  Created by 尹凡 on 2020/8/14.
//  Copyright © 2020 fanyin. All rights reserved.
//

#import "HookBird.h"

@implementation HookBird


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"123";
    }
    return self;
}

- (void)fly:(NSInteger)ageshi
{
    
    NSLog(@"self = %@ selector = %@ HookBird fly", self, NSStringFromSelector(_cmd));
    
    NSLog(@"123");
    
   if([self respondsToSelector:@selector(name)])
   {
       NSLog(@"%@",self.name);
   }
    
    
}

@end
