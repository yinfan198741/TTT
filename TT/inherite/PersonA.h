//
//  PersonA.h
//  TT
//
//  Created by fanyin on 2019/11/24.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "buyGoods.h"
NS_ASSUME_NONNULL_BEGIN

@interface PersonA : NSObject

//{
//	buyGoods* good;
//}

@property (nonatomic ,strong) NSString* name;

@property (nonatomic ,assign) NSInteger age;

@property (nonatomic ,strong) NSString* birthPlace;

@property (nonatomic ,strong, readonly) buyGoods* good;

- (void)callName;

@end

NS_ASSUME_NONNULL_END
