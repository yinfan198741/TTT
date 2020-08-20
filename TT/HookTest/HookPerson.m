//
//  HookPerson.m
//  TT
//
//  Created by fanyin on 2020/5/3.
//  Copyright © 2020 fanyin. All rights reserved.
//

#import "HookPerson.h"
#import <objc/runtime.h>

@implementation HookPerson


- (void)sayHello {
	NSLog(@"person say hello");
}

//+ (void)load
//{
//    NSLog(@"HookPersonload");
//    Method runM =  class_getInstanceMethod([self class], @selector(run));
//    Method eatM =  class_getInstanceMethod([self class], @selector(eat));
////    method_exchangeImplementations(runM, eatM);
//}


- (void)run
{
    NSLog(@"self = %@ selector = %@ person run", self, NSStringFromSelector(_cmd));
}

- (void)eat
{
    NSLog(@"selector = %@ person eat", NSStringFromSelector(_cmd));
}


-(void)dealloc
{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
         [self TTTS];
    });
   
}

- (void)TTTS
{
    
    NSLog(@"123");
    
    __weak __typeof(self)weak_self = self;
    
     NSLog(@"%@", weak_self);
}


@end
