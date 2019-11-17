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

- (id)copyWithZone:(nullable NSZone *)zone {
//    return [[self class] mj_objectWithKeyValues:[self mj_JSONObject]];
     MJDishSpuEntity* t = [[MJDishSpuEntity alloc] init];
    return t;
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:@(self.canWeigh) forKey:@"canWeigh"];
    [aCoder encodeObject:self.code forKey:@"code"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    self.canWeigh = [aDecoder decodeObjectForKey:@"canWeigh"];
    self.code = [aDecoder decodeObjectForKey:@"code"];
    return self;
}

@end
