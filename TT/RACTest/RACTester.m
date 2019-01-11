//
//  RACTester.m
//  TT
//
//  Created by 尹凡 on 1/8/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "RACTester.h"
#import "Service.h"

@implementation RACTester

-(void)Test {
  Service* ser = [[Service alloc] init];
  
//  [ser getUserInfo:@"yinfan" comlpete:^(id data, NSError *error) {
//    NSLog(@"%@",data);
//  }];
//
//  RetBlock bloc = [ser getUserInfoRetBlock:@"yinfan"];
//  if (bloc != nil) {
//     bloc(@"yinfan123",nil);
//  }
//
  RetBBComplete bbloc = [ser getUserInfoRetBBlock:@"yinfan"];
  if (bbloc != nil) {
    RetBlock bloc = ^(id data, NSError* error) {
      NSLog(@"1= %@",data);
    };
    bbloc(bloc);
  }
  
  [ser getUserInfoRetBBlock:@"yinfan"](^(id data, NSError* error){
    NSLog(@"2= %@",data);
  });
  
  
  Swear* sw = [ser getUserInfoBySwear:@"yinfan"];
  [sw subscribe:^(id data, NSError *err) {
     NSLog(@"3= %@",data);
  }];
  [sw send];
  
  Swear* sswear = [Swear swearWithBlock:^(SwearPublisherBlock sender) {}];
  [sswear newSubscribe:^(id data, NSError *error) {
    NSLog(@"4= %@",data);
  }];

  [[ser getUserInfoNew:@"yinfan"] newSubscribe:^(id data, NSError *error) {
    NSLog(@"5= %@",data);
  }];
  
//  [sw subscribe:^(RetBlock b) {
//
//  }];
//  [sw ]
//  [sw subscribe:<#(NSString *)#>]
//  [ser getUserInfoRetBBlock:@"yinfan"];
//  bloc(da)
}

@end
