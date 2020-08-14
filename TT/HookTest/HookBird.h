//
//  HookBird.h
//  TT
//
//  Created by 尹凡 on 2020/8/14.
//  Copyright © 2020 fanyin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HookBird : NSObject


@property(nonatomic , copy) NSString* name ;


- (void)fly:(NSInteger)age;

@end

NS_ASSUME_NONNULL_END
