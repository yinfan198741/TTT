//
//  SOUnsafeObject.h
//  TT
//
//  Created by fanyin on 2020/1/12.
//  Copyright © 2020 fanyin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SOUnsafeObject : NSObject

@property (strong) NSString *title;

- (void)reloadDataInBackground;

@end

NS_ASSUME_NONNULL_END
