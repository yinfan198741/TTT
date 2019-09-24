//
//  MJUser.m
//  TT
//
//  Created by 尹凡 on 3/27/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "MJUser.h"

@implementation MJUser

@end


@implementation MJStatus

- (id)copyWithZone:(NSZone *)zone
{
	return [[self class] mj_objectWithKeyValues:[self mj_JSONObject]];
}

+ (NSDictionary *)mj_objectClassInArray {
	return @{
			 @"users":@"MJUser",
			 };
}




@end

@implementation MJDishSpuEntity

@end
