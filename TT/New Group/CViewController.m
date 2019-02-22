//
//  CViewController.m
//  TT
//
//  Created by 尹凡 on 2/19/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "CViewController.h"
#import "BViewController.h"

@interface CViewController ()<UIGestureRecognizerDelegate>
@property(nonatomic, weak)id<UIGestureRecognizerDelegate> _pg;
@end

@implementation CViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.title = @"CViewController";
  self.view.backgroundColor = UIColor.yellowColor;UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
  button.layer.borderColor = UIColor.blackColor.CGColor;
  button.layer.borderWidth = 2;
  [button setTitle:@"BACK" forState:UIControlStateNormal];
  [button setBackgroundColor:UIColor.redColor];
  [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
  
  self._pg = self.navigationController.interactivePopGestureRecognizer.delegate;
  self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)click {
  NSLog(@"click");
  [self.navigationController popViewControllerAnimated:true];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
  [self showPop];
  return NO;
}


- (void)showPop {
  UIAlertController* alert = [BViewController alertTestView];
  UIAlertAction* action1 = [UIAlertAction
                            actionWithTitle:@"OK"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * _Nonnull action)
                            {
                              [self.navigationController popViewControllerAnimated:YES];
                            }];
  [alert addAction:action1];
  [self presentViewController:alert animated:YES completion:nil];
}

- (void)dealloc {
  if (self._pg != nil) {
    NSLog(@"dealloc = %@ gester = %@",self, self._pg);
    self.navigationController.interactivePopGestureRecognizer.delegate = self._pg ;
  }
}

@end
