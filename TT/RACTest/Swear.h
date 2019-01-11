//
//  Swear.h
//  TT
//
//  Created by 尹凡 on 1/8/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Service.h"

typedef void (^RetBlock)(id data, NSError *err);
typedef void (^RetBBComplete)(RetBlock);

typedef void (^SwearPublisherBlock)(id data, NSError* error); // 提供给 swear 对象的创建者，用来向观察者发布内容
typedef void (^SwearBlock)(SwearPublisherBlock sender); // 创建 swear 对象的block



////发誓 会给你一个结果
//@interface Swear : NSObject
//
//@property (nonatomic, copy) RetBlock completeBlock;
//
//- (void)subscribe:(RetBlock) completeBlock;
//
//- (void)send;
//
//@end

@interface Swear : NSObject

// 用一个 block 创建swear对象
+ (instancetype) swearWithBlock:(SwearBlock)block;

@property (nonatomic, copy) RetBlock completeBlock;

- (void)newSubscribe:(SwearPublisherBlock)completeBlock;

- (void)subscribe:(RetBlock) completeBlock;

- (void)send;

@end


