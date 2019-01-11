//
//  Service.h
//  TT
//
//  Created by 尹凡 on 1/8/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Swear.h"

typedef void (^RetBlock)(id data, NSError *err);
typedef void (^RetBBComplete)(RetBlock);

@class Swear;

@interface Service : NSObject

// 获取用户信息
- (void) getUserInfo:(NSString*)userId comlpete:(void (^)(id data, NSError *error))complete;

- (RetBlock) getUserInfoRetBlock:(NSString*)userId;

- (RetBBComplete) getUserInfoRetBBlock:(NSString*)userId;

- (Swear*) getUserInfoBySwear:(NSString*)userId;

- (Swear*) getUserInfoNew:(NSString*)userId;

// 获取一篇文章的评论详情
- (void) getCommentDetailWithCommentId:(NSString*)commentId forPostId:(NSString*)postId comlpete:(void (^)(id data, NSError *error))complete;

@end


