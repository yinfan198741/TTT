//
//  DynamicSysTest.h
//  TT
//
//  Created by 尹凡 on 2019/9/29.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface DynamicSysTest : NSObject <MYProperty>
{
    NSString *testAge;
    NSString *testName;
}

@property (nonatomic , strong) NSString* name;

@property  NSString *testAge;

- (NSString*)getAdd;

- (NSString*)testAgeME;

@end

NS_ASSUME_NONNULL_END
