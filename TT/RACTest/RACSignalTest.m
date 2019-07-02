//
//  RACSignalTest.m
//  TT
//
//  Created by 尹凡 on 5/15/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "RACSignalTest.h"


@implementation RACSignalTest

+(RACSignal*)signalOne:(NSString*)data
{
    return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:data];
        
//            [subscriber sendNext:@"123"];
//         [subscriber sendNext:@"a"];
//        [subscriber sendNext:@"b"];
//        [subscriber sendNext:@"c"];
//            [subscriber sendCompleted];
        
        
//        NSError* err = [NSError errorWithDomain:@"signalOne Error" code:100 userInfo:nil];
//        [subscriber sendError:err];
        
         return nil;
    }];
}

+(RACSignal*)signalTow:(NSString*)data
{
    return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:data];
//            [subscriber sendCompleted];
        
//                NSError* err = [NSError errorWithDomain:@"signalTow Error" code:100 userInfo:nil];
//                [subscriber sendError:err];
            
            });
        return nil;
    }];
}

+(RACSignal*)signalThree:(NSString*)data
{
    return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:data];
//            [subscriber sendCompleted];
            
            
//            NSError* err = [NSError errorWithDomain:@"signalThree Error" code:100 userInfo:nil];
//            [subscriber sendError:err];
        });
        return nil;
    }];
}

+(RACSignal*)signalFour:(NSString*)data
{
    return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:data];
            //            [subscriber sendCompleted];
            
            
            //            NSError* err = [NSError errorWithDomain:@"signalThree Error" code:100 userInfo:nil];
            //            [subscriber sendError:err];
        });
        return nil;
    }];
}

@end
