//
//  NSObject+PPrint.h
//  TT
//
//  Created by 尹凡 on 1/30/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (PPrint)

+ (instancetype)getProperties:(Class)cls;

@end

NS_ASSUME_NONNULL_END
