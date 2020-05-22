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



// 分类在 HOOKPerson 之前
//2020-05-07 22:38:44.604186+0800 TT[68411:436593] #HookStudent start call sayHello
//2020-05-07 22:38:44.604380+0800 TT[68411:436593] Student + swizzle say hello 1 sayHello
//2020-05-07 22:38:44.606564+0800 TT[68411:436593] person say hello
//2020-05-07 22:38:44.606748+0800 TT[68411:436593] Student + swizzle say hello 2



// 分类在 HOOKPerson 之后
//2020-05-07 22:39:36.673463+0800 TT[68519:437813] #HookStudent start call sayHello
//2020-05-07 22:39:36.673613+0800 TT[68519:437813] Student + swizzle say hello 1 sayHello
//2020-05-07 22:39:36.673708+0800 TT[68519:437813] Person + swizzle say hello 1
//2020-05-07 22:39:36.675727+0800 TT[68519:437813] person say hello
//2020-05-07 22:39:36.675874+0800 TT[68519:437813] Person + swizzle say hello 2
//2020-05-07 22:39:36.675950+0800 TT[68519:437813] Student + swizzle say hello 2

///注意编译顺序
- (void)s_sayHello {
	SEL s = _cmd;
	NSLog(@"Student + swizzle say hello 1 %@",[NSString stringWithUTF8String:s]);
	[self s_sayHello];
	
	NSLog(@"Student + swizzle say hello 2");
}

@end
