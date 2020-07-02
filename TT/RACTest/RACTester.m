//
//  RACTester.m
//  TT
//
//  Created by 尹凡 on 1/8/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "RACTester.h"
#import "Service.h"
#import "RACSignalTest.h"

@implementation RACTester

-(void)Test {
    
//    [self Test3];
    [self bind];
    return;
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

-(void)Test2
{
    NSString* one = @"1";
    
    RACSignal* sig = [[RACSignalTest signalOne:@"1"]
     flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value)
    {
        NSLog(@"signalOne = %@",value);
        NSString* tow = [NSString stringWithFormat:@"%@ + 2",value];
        return [[RACSignalTest signalTow:tow] flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value)
        {
              NSLog(@"signalTwo = %@",value);
            NSString* three = [NSString stringWithFormat:@"%@ + 3",value];
            return [[RACSignalTest signalThree:three] flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
                NSLog(@"signalfour = %@",value);
                NSString* four = [NSString stringWithFormat:@"%@ + 4",value];
                return [RACSignalTest signalFour:four];
            }];
        }];
    }];
    
//    [sig subscribeOn:(nonnull RACScheduler *]
    
    [sig subscribeNext:^(id  _Nullable x) {
       
        NSLog(@"%@",x);
    }];
    
    [sig subscribeError:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
}

-(void)Test3
{
    
    RACSignal* sig = [RACSignal return:@"123"];
    
    [sig doCompleted:^{
         NSLog(@"sig doCompleted");
    }];
    
    [[sig doNext:^(id  _Nullable x) {
        NSLog(@"doNext1 = x",x);
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"subscribeNext1 = x",x);
    }];

    [sig subscribeNext:^(id  _Nullable x) {
        NSLog(@"subscribeNext2 = x",x);
    }];

    
    
//    [[RACSignal return:@"123"] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
//
    [[[RACSignal return:@"123"] doNext:^(id  _Nullable x) {
        NSLog(@"doNext %@",x);
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    
//    NSString* one = @"1";
//    RACSignal* sig = [RACSignalTest signalOne:one];
//    RACSignal* sig2 = [sig flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
//
//        NSLog(@"%@",value);
//
//        return [RACSignalTest signalTow:@"123"];
//    }];
//
//    [sig2 subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
//
//    [sig2 subscribeError:^(NSError * _Nullable error) {
//        NSLog(@"%@",error);
//    }];
}

- (void)bind
{
	@weakify(self)
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
		@strongify(self)
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendNext:@3];
        [subscriber sendNext:@4];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSubject* sub = [[RACSubject alloc] init];
    
    
    
    
    [sub subscribeNext:^(NSString*   x) {
        NSLog(@"subscribeNext = %@",x);
    }];
    
    
    [sub sendNext:@"123"];
    [sub sendNext:@"456"];
    
    [signal subscribe:sub];
    [signal subscribe:sub];
   
    
    
//    [sub subscribeNext:@"123"];
    
    
//
//    RACSignal *bindSignal = [signal bind:^RACSignalBindBlock _Nonnull{
//        return ^(NSNumber *value, BOOL *stop) {
//            value = @(value.integerValue * value.integerValue);
////            if (value.intValue == 4) {
////                *stop = YES;
////            }
//            return [RACSignal return:value];
//        };
//    }];
////    [signal subscribeNext:^(id  _Nullable x) {
////        NSLog(@"signal: %@", x);
////    }];
//    [bindSignal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"bindSignal: %@", x);
//    }];
//
    
    
    
}

- (void)Test4
{
    
//    RAC(self, A) = [RACObserve(self, B)
//                    flattenMap:^(id param) {
//                        return [[self
//                                 doSomthingToGetA:param]; // this may throw an error
//                                catch:^(NSError *error){
//                                    //do some other things
//                                    return [RACSignal return:nil];
//                                }];
//                    }];
    
    
//    RACSignal* t = nil;
//    [t flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
//        RACSignal * b ;
//        return  [b catch:^RACSignal * _Nonnull(NSError * _Nonnull error) {
//            return [RACSignal return:nil];
//        }];
////        return b;
//    }];
    
//     RACSignal* t2= nil;
//    [t2 flattenMap:^id(id param) {
//        return [self doSomthingToGetA:param];// this may throw an error
//    }] catch:^RACSignal *(NSError *error){
//
//        //do some other things
//        return [RACSignal return:nil];
//    }
    
}

@end
