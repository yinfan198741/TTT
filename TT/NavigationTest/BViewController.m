//
//  BViewController.m
//  TT
//
//  Created by 尹凡 on 2/19/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "BViewController.h"
#import "CViewController.h"

@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.title = @"BViewController";
   self.view.backgroundColor = UIColor.blueColor;
  UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
  button.layer.borderColor = UIColor.blackColor.CGColor;
  button.layer.borderWidth = 2;
  [button setTitle:@"push" forState:UIControlStateNormal];
  [button setBackgroundColor:UIColor.redColor];
  [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  
  if (self.isMovingFromParentViewController) {
//    UIAlertController* controler = [BViewController alertTestView];
//    [self.navigationController presentViewController:controler animated:YES completion:nil];
    NSLog(@"isMovingFromParentViewController");
    NSLog(@"hook back");
  }
}

+ (UIAlertController*)alertTestView {
  UIAlertController* controler = [UIAlertController
                                  alertControllerWithTitle:@"Test"
                                  message:@"message"
                                  preferredStyle:UIAlertControllerStyleAlert];
  
//  UIAlertAction* action = [UIAlertAction
//                           actionWithTitle:@"calcel"
//                           style:UIPreviewActionStyleDestructive
//                           handler:^(UIAlertAction * _Nonnull action)
//  {
//    [controler dismissViewControllerAnimated:true completion:nil];
//  }];
  
  UIAlertAction* action2 = [UIAlertAction
                            actionWithTitle:@"Cancel"
                            style:UIAlertActionStyleDestructive
                            handler:^(UIAlertAction * _Nonnull action)
                            {
                              
                            }];
  [controler addAction:action2];
  return controler;
}


- (void)push {
  NSLog(@"push");
  
  CViewController* bc = [[CViewController alloc] init];
  [self.navigationController pushViewController:bc animated:true];
}

@end
