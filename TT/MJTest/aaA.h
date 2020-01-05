//
//  aaA.h
//  TT
//
//  Created by 尹凡 on 2019/12/6.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface aaAArray : NSObject

@property (nonatomic, strong) NSMutableArray* printInfo;

@end

@interface aaA : NSObject
/**商品UUID*/
@property (nonatomic, copy) NSString* dishNO;
/**是否打印厨房制作单 1：是 2：否*/
@property (nonatomic, strong) NSNumber* printOrderKitchen;

/**创建对象*/
+ (instancetype)createInstance:(NSString*)no;


@end




NS_ASSUME_NONNULL_END
