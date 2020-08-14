//
//  PersonA.m
//  TT
//
//  Created by fanyin on 2019/11/24.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "PersonA.h"




@implementation PersonA


@synthesize good = _good;

-(buyGoods*)good
{
	if (_good == nil) {
		_good = [[buyGoods alloc] init];
		_good.goodName = @"buyGoods123";
		_good.goodPrice = 123;
	}
	return _good;
}

- (NSInteger)getAge
{
    return _age;
}



//- (void)callName
//{
//    NSLog(@"callName PersonA");
//}

- (void)callName
{
	NSLog(@"PersonA callName");
}

- (void)abcttt:(NSInteger)tt
{
    
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    Method method = class_getInstanceMethod([self class], @selector(abcttt:));
    return [NSMethodSignature signatureWithObjCTypes:method_getTypeEncoding(method)];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    int aaa;
//    [anInvocation getArgument:&aaa atIndex:0];
     [anInvocation getArgument:&aaa atIndex:2];
    
    NSLog(@"%d", aaa);
    kill(getpid(), 9);
}


-(void)pp
{
    NSLog(@"ppp %s",__func__);
}


@end
