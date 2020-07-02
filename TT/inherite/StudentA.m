//
//  StudentA.m
//  TT
//
//  Created by fanyin on 2019/11/24.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "StudentA.h"
#import "ReactiveObjC.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation StudentA

//feature/0514_open_deal_yf

@synthesize name = _name;

- (void)setName:(NSString *)name
{
	_name = name;
	self->bbs = name;
	NSLog(@"self->bbs = %@",self->bbs);
}



-(void)testBlockSuper
{
	
//	@weakify(self)
	__weak typeof(self) weakself = self;
	self.myBlock = ^{
		__strong typeof(weakself) self = weakself;
		
//		@strongify(self)
//		_schoolName = @"123";
//		[super callName];
		
//		self.schoolName = @"123";
		
		struct	objc_super superInfo = {
            .receiver = self,
            .super_class = class_getSuperclass(NSClassFromString(@"StudentA")),
        };
		
		void (*msgSendSuperFunction)(struct objc_super *, SEL) = (__typeof__(msgSendSuperFunction))objc_msgSendSuper;
		msgSendSuperFunction(&superInfo, @selector(callName));
		
//        ((Class(*)(struct objc_super *, @selector(callName)))objc_msgSendSuper)(&superInfo,@selector(class));
		
	};
	
}


- (void)callTT
{
	[self testBlockSuper];
	self.myBlock();
}

- (void)dealloc
{
	NSLog(@"dealloc");
}

//- (void)setbb
//{
//
//}

@end
