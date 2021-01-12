//
//  RACSignal+PP.m
//  TT
//
//  Created by 尹凡 on 2020/11/24.
//  Copyright © 2020 fanyin. All rights reserved.
//

#import "RACSignal+PP.h"
#import "MBProgressHUD.h"
#import "RACCompoundDisposable.h"
#import "RACSubscriber.h"
#import "RACSignal+Operations.h"

@implementation RACSignal (PP)


- (RACSignal*)takeLoading
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        RACCompoundDisposable* cp = [RACCompoundDisposable compoundDisposable];
        
        dispatch_block_t showLoading = ^{
            [MBProgressHUD showHUDAddedTo:UIApplication.sharedApplication.keyWindow animated:YES];
        };
        dispatch_block_t hiddenLoading = ^{
            [MBProgressHUD hideHUDForView:UIApplication.sharedApplication.keyWindow animated:YES];
        };
        
        RACDisposable* selfDispos = [RACDisposable disposableWithBlock:^{
            hiddenLoading();
        }];
        
        
        showLoading();
        
        RACDisposable* d = [self subscribeNext:^(id x) {
            [subscriber sendNext:x];
        } error:^(NSError *  error) {
            [subscriber sendError:error];
             hiddenLoading();
        } completed:^{
            [subscriber sendCompleted];
             hiddenLoading();
        }];
        
        [cp addDisposable:d];
        [cp addDisposable:selfDispos];
        
        return cp;
    }];
}

@end
