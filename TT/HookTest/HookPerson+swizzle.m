//
//  HookPerson+swizzle.m
//  TT
//
//  Created by fanyin on 2020/5/3.
//  Copyright © 2020 fanyin. All rights reserved.
//

#import "HookPerson+swizzle.h"
#import "JRSwizzle.h"

@implementation HookPerson (swizzle)

+ (void)load {
	[self jr_swizzleMethod:@selector(p_sayHello) withMethod:@selector(sayHello) error:nil];
}

- (void)p_sayHello {
	[self p_sayHello];
	
	NSLog(@"Person + swizzle say hello");
}

@end
