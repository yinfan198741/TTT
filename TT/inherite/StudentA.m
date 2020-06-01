//
//  StudentA.m
//  TT
//
//  Created by fanyin on 2019/11/24.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "StudentA.h"

@implementation StudentA

//feature/0514_open_deal_yf

@synthesize name = _name;

- (void)setName:(NSString *)name
{
	_name = name;
	self->bbs = name;
	NSLog(@"self->bbs = %@",self->bbs);
}




//- (void)setbb
//{
//
//}

@end
