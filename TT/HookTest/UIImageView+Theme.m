//
//  UIImageView+Theme.m
//  TestInitHook
//
//  Created by ZhongXiaoLong on 2019/3/4.
//  Copyright © 2019 zhongxiaolong. All rights reserved.
//

#import "UIImageView+Theme.h"
#import <objc/runtime.h>

@implementation UIImageView (Theme)

- (instancetype)initWithFrame:(CGRect)frame
{
    id (*initXXX)(id, SEL, CGRect);
    unsigned int outCount = 0;
    Method *methodList = class_copyMethodList([self class], &outCount);
    BOOL isMyMethod = YES;

    for (int i = 0; i < outCount; i++)
    {
        Method method = methodList[i];
        SEL sel = method_getName(method);
        const char *curNameChar = sel_getName(_cmd);
        const char *name = sel_getName(sel);
        NSLog(@"%s", name);
        NSString *methodName = [[NSString alloc] initWithUTF8String:name];
        NSString *curName = [[NSString alloc] initWithUTF8String:curNameChar];

        if ([methodName isEqualToString:curName])
        {
            if (!isMyMethod)
            {
                initXXX = (id (*)(id, SEL, CGRect))method_getImplementation(method);
                initXXX(self, sel, frame);
                NSLog(@"");

                [[NSNotificationCenter defaultCenter] addObserver:self
                                                         selector:@selector(dadada:)
                                                             name:@"xxxx"
                                                           object:nil];
            }

            isMyMethod = NO;
        }
    }

    return self;
}






@end
