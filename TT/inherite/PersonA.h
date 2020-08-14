//
//  PersonA.h
//  TT
//
//  Created by fanyin on 2019/11/24.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "buyGoods.h"
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface PersonA : NSObject

{
	@public
	NSString* bbs;
}

@property (nonatomic ,strong) NSString* name;

@property (nonatomic ,assign) NSInteger age;

@property (nonatomic ,strong) NSString* birthPlace;

@property (nonatomic ,strong, readonly) buyGoods* good;



- (void)callName;


- (void)abc:(NSInteger)tt;



- (void)abcttt:(NSInteger)tt;


-(void)pp;

@end

NS_ASSUME_NONNULL_END
