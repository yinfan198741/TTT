//
//  Service.m
//  TT
//
//  Created by 尹凡 on 1/8/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "Service.h"

@implementation Service

-(void)getUserInfo:(NSString *)userId comlpete:(void (^)(id, NSError *))complete {
  if([userId  isEqual: @"yinfan"]) {
    complete(@"true", nil);
  }else {
     complete(@"false", nil);
  }
}

//-(void)getUserInfoRetBlock() {
//
//}

- (RetBlock)getUserInfoRetBlock:(NSString *)userId {
  if([userId  isEqual: @"yinfan"]) {
    RetBlock b = ^(id data, NSError* err) {
      NSLog(@"%@",data);
    };
  return b;
  }
  else {
    return nil;
  }
}

- (RetBBComplete)getUserInfoRetBBlock:(NSString *)userId {
  
//  RetBlock b = ^(id data, NSError* err) {
//    data = @"yinfan";
//    NSLog(@"%s",data);
//  };
  
  RetBBComplete bb = ^(RetBlock b) {
    NSString* data = @"yinfan RET";
    b(data,nil);
  };
  return bb;
}


- (Swear*)getUserInfoBySwear:(NSString*)userId {
  Swear* sw = [[Swear alloc] init];
  return sw;
}

- (Swear*) getUserInfoNew:(NSString*)userId {
  return [Swear swearWithBlock:^(SwearPublisherBlock publisher) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      publisher(@"data", nil);
    });
  }];
}


@end
