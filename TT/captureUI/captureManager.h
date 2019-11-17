//
//  captureManager.h
//  TT
//
//  Created by fanyin on 2019/11/17.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#define campWindowLeve 1000000000

NS_ASSUME_NONNULL_BEGIN

@interface captureManager : NSObject

+ (instancetype)shareSingleObjc;

- (void)setupWindow;

@end

NS_ASSUME_NONNULL_END
