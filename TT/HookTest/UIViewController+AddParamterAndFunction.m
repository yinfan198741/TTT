//
//  UIViewController+AddParamterAndFunction.m
//  TT
//
//  Created by fanyin on 2020/5/3.
//  Copyright © 2020 fanyin. All rights reserved.
//

#import "UIViewController+AddParamterAndFunction.h"
#import <objc/runtime.h>

@implementation UIViewController (AddParamterAndFunction)



- (NSString*)meSetcontrollerName
{
	SEL a = @selector(meSetcontrollerName);
	if (@selector(meSetcontrollerName) == 	_cmd)
	{
		NSLog(@"123");
	}
	return objc_getAssociatedObject(self, _cmd);
}

- (void)setMeSetcontrollerName:(NSString *)meSetcontrollerName
{
	
	objc_setAssociatedObject(self, _cmd, meSetcontrollerName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
