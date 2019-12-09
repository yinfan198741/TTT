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

@end
