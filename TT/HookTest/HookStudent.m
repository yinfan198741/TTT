//
//  HookStudent.m
//  TT
//
//  Created by fanyin on 2020/5/3.
//  Copyright © 2020 fanyin. All rights reserved.
//

#import "HookStudent.h"
#import <objc/runtime.h>
#import "HookBird.h"

@implementation HookStudent

//+ (void)load
//{
//    NSLog(@"HookStudentload");
//    Method runM =  class_getInstanceMethod([self class], @selector(run));
//    Method eatM =  class_getInstanceMethod([self class], @selector(eat));
//    
//    
/////先加，看看能不能加上，能加上就，不要去改变父类的运行状态，直接交换，父亲也交换了。
////    class_replaceMethod(class,
////    swizzledSelector,
////    method_getImplementation(originalMethod),
////    method_getTypeEncoding(originalMethod));
//    
//    BOOL didAddRunMethod = class_addMethod([self class],
//                                              @selector(run),
//                                              method_getImplementation(runM),
//                                              method_getTypeEncoding(runM));
//    
//    BOOL didAddEatMethod = class_addMethod([self class],
//                                                 @selector(eat),
//                                                 method_getImplementation(eatM),
//                                                 method_getTypeEncoding(eatM));
//    
//    
//
//    
//    Method runMs =  class_getInstanceMethod([self superclass], @selector(run));
//    Method eatMs =  class_getInstanceMethod([self superclass], @selector(eat));
//    
//    NSLog(@"123");
//
//    
//    Method runM3 =  class_getInstanceMethod([self class], @selector(run));
//    Method eatM3 =  class_getInstanceMethod([self class], @selector(eat));
//    
//    
//    method_exchangeImplementations(runM3, eatM3);
//    
//     NSLog(@"123");
//}



+(void)load
{
    Method study =  class_getInstanceMethod([self class], @selector(study));
    Method fly =  class_getInstanceMethod([HookBird class], @selector(fly:));
    
    IMP s = method_getImplementation(study);
    IMP f = method_getImplementation(fly);
    
    
    
    
    typedef struct _sss
    {
        long a;
        long b;
    }sss;
    
    
    char* ss = "123";
    
    sss *sf = malloc(sizeof(sss));
    sf->a = 0x12345678;
    sf->b = 0x78563412;
    
//    void (*tt)(sss*, char*) = s;
//    tt(sf,"1");
    
    
    method_exchangeImplementations(study, fly);
}


- (void)study
{
//    NSLog(@"123");
      NSLog(@"self = %p selector = %@ HookStudent study", self, NSStringFromSelector(_cmd));
}

//- (void)run
//{
////    NSLog(@"student run");
//     NSLog(@"selector = %@ HookStudent run", NSStringFromSelector(_cmd));
//}

- (void)eat
{
//     NSLog(@"student eat");
     NSLog(@"selector = %@ HookStudent eat", NSStringFromSelector(_cmd));
}


@end
