//
//  Swear.m
//  TT
//
//  Created by 尹凡 on 1/8/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "Swear.h"
#import "Service.h"

@interface Swear()

@property (nonatomic, copy) SwearBlock defineBlock;

@end

@implementation Swear

+ (instancetype) swearWithBlock:(SwearBlock)block {
  Swear* sw = [[Swear alloc] init];
  sw.defineBlock = block;
  return sw;
}

- (void)newSubscribe:(SwearPublisherBlock)completeBlock {
  self.defineBlock(^(id data, NSError *error) {
    NSString* data2 = @"yinfan123newSubscribe";
    completeBlock(data2, error);
  });
}

- (void)subscribe:(RetBlock)completeBlock {
  self.completeBlock = completeBlock;
}

- (void)send {
  self.completeBlock(@"yinfan_Swear", nil);
}
@end
