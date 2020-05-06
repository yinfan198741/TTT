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

- (void)s_sayHello {
	[self s_sayHello];
	
	NSLog(@"Student + swizzle say hello");
}

@end
