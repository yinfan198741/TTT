//
//  MJUser.h
//  TT
//
//  Created by 尹凡 on 3/27/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    SexMale,
    SexFemale
} Sex;

@interface MJUser : NSObject

@property (copy, nonatomic) NSString *name;/* 姓名 */
@property (copy, nonatomic) NSString *icon;/* 头像 */
@property (assign, nonatomic) unsigned int age;/* 年龄 */
@property (copy, nonatomic) NSString *height;/* 身高 */
@property (strong, nonatomic) NSNumber *money;/* 资产 */
@property (assign, nonatomic) Sex sex;/* 性别 */
@property (assign, nonatomic, getter=isGay) BOOL gay;/* 是否是同性恋 */

@end


@interface MJStatus : NSObject
@property (copy, nonatomic) NSString *text;
@property (strong, nonatomic) MJUser *user;/* 其他模型类型 */
@property (strong, nonatomic) MJStatus *retweetedStatus;/* 自我模型类型 */
@end


@interface MJDishSpuEntity: NSObject

@property (nonatomic, assign) NSInteger minCount; // 起售份数

@property (nonatomic, assign) BOOL haveSideDish;
@property (nonatomic, assign) BOOL showLimit;
//@property (nonatomic, assign) BOOL sideDish;//2.8版本没有此字段
@property (nonatomic, assign) BOOL canWeigh;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *no;
@property (nonatomic, assign) NSInteger status; // DishStatus

@end
NS_ASSUME_NONNULL_END
