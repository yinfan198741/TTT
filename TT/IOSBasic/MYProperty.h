//
//  MYProperty.h
//  TT
//
//  Created by 尹凡 on 2019/9/29.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MYProperty <NSObject>

- (NSString*)myPropertyMethod;

@property (nonatomic, strong) NSString* propertyName;

- (NSString*)myPPName;

- (void)setmyPPName:(NSString*)ppname;

@end

NS_ASSUME_NONNULL_END
