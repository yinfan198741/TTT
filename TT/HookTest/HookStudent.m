//
//  HookStudent.m
//  TT
//
//  Created by fanyin on 2020/5/3.
//  Copyright © 2020 fanyin. All rights reserved.
//

#import "HookStudent.h"
#import <objc/runtime.h>

@implementation HookStudent

+ (void)load
{
    NSLog(@"HookStudentload");
    Method runM =  class_getInstanceMethod([self class], @selector(run));
    Method eatM =  class_getInstanceMethod([self class], @selector(eat));
    
    
///先加，看看能不能加上，能加上就，不要去改变父类的运行状态，直接交换，父亲也交换了。
//    class_replaceMethod(class,
//    swizzledSelector,
//    method_getImplementation(originalMethod),
//    method_getTypeEncoding(originalMethod));
    
    BOOL didAddRunMethod = class_addMethod([self class],
                                              @selector(run),
                                              method_getImplementation(runM),
                                              method_getTypeEncoding(runM));
    
    BOOL didAddEatMethod = class_addMethod([self class],
                                                 @selector(eat),
                                                 method_getImplementation(eatM),
                                                 method_getTypeEncoding(eatM));
    
    

    
    Method runMs =  class_getInstanceMethod([self superclass], @selector(run));
    Method eatMs =  class_getInstanceMethod([self superclass], @selector(eat));
    
    NSLog(@"123");

    
    Method runM3 =  class_getInstanceMethod([self class], @selector(run));
    Method eatM3 =  class_getInstanceMethod([self class], @selector(eat));
    
    
    method_exchangeImplementations(runM3, eatM3);
    
     NSLog(@"123");
}


- (void)run
{
//    NSLog(@"student run");
     NSLog(@"selector = %@ HookStudent run", NSStringFromSelector(_cmd));
}

- (void)eat
{
//     NSLog(@"student eat");
     NSLog(@"selector = %@ HookStudent eat", NSStringFromSelector(_cmd));
}


@end
