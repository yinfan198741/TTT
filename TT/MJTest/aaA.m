//
//  aaA.m
//  TT
//
//  Created by 尹凡 on 2019/12/6.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "aaA.h"


@implementation aaAArray


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.printInfo = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
        @"printInfo":
                 aaA.class};
}

@end

@implementation aaA

+ (instancetype)createInstance:(NSString*)no {
    aaA* printInfo = [[aaA alloc] init];
    printInfo.dishNO = no;
    printInfo.printOrderKitchen = @(2);
    return printInfo;
}

@end
