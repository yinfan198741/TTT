//
//  HookStudent+swizzle.m
//  TT
//
//  Created by fanyin on 2020/5/3.
//  Copyright © 2020 fanyin. All rights reserved.
//

#import "HookStudent+swizzle.h"
#import "JRSwizzle.h"

@implementation HookStudent (swizzle)

+ (void)load {
	[self jr_swizzleMethod:@selector(s_sayHello) withMethod:@selector(sayHello) error:nil];
}

///注意编译顺序
- (void)s_sayHello {
	SEL s = _cmd;
	NSLog(@"Student + swizzle say hello 1 %@",[NSString stringWithUTF8String:s]);
	[self s_sayHello];
	
	NSLog(@"Student + swizzle say hello 2");
}

@end
