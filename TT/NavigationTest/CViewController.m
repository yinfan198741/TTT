//
//  CViewController.m
//  TT
//
//  Created by 尹凡 on 2/19/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "CViewController.h"

@interface CViewController ()

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

}

- (void)click {
  NSLog(@"click");
  [self.navigationController popViewControllerAnimated:true];
}

@end
