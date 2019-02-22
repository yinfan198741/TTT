//
//  SubBackNaviViewController+Back.m
//  TT
//
//  Created by 尹凡 on 2/20/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "SubBackNaviViewController+Back.h"
#import "CViewController.h"
#import "BViewController.h"

@implementation SubBackNaviViewController (Back)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar
       shouldPushItem:(UINavigationItem *)item {
  NSLog(@"SubBackNaviViewController shouldPushItem");
  NSLog(@"%s",__func__);
  return true;
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar
        shouldPopItem:(UINavigationItem *)item {
  NSLog(@"SubBackNaviViewController shouldPopItem");
  NSLog(@"%s",__func__);
  
  if ([self.topViewController isKindOfClass:[CViewController class]]) {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      UIAlertController* alert = [BViewController alertTestView];
      [self presentViewController:alert animated:YES completion:nil];
      
      UIAlertAction* action1 = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * _Nonnull action)
                                {
                                  [self popViewControllerAnimated:YES];
                                }];
      [alert addAction:action1];
//    });
    return NO;
    }

  [self popViewControllerAnimated:YES];
  return YES;
}

@end
