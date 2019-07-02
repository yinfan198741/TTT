//
//  RACSignalTest.h
//  TT
//
//  Created by 尹凡 on 5/15/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"

NS_ASSUME_NONNULL_BEGIN

@interface RACSignalTest : NSObject


+(RACSignal*)signalOne:(NSString*)data;

+(RACSignal*)signalTow:(NSString*)data;

+(RACSignal*)signalThree:(NSString*)data;

+(RACSignal*)signalFour:(NSString*)data;



@end

NS_ASSUME_NONNULL_END
