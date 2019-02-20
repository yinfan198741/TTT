//
//  AViewController.m
//  TT
//
//  Created by 尹凡 on 2/19/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "AViewController.h"
#import "BViewController.h"
#import "NavigationBarDelegate.h"
#import "NavigationDelegate.h"

@interface AViewController ()
@property(nonatomic,strong)NavigationBarDelegate* barDelegate;
@property(nonatomic , strong)NavigationDelegate* navigationDelegate;
@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
 
  self.title = @"AViewController";
  self.view.backgroundColor = UIColor.redColor;
  UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
  button.layer.borderColor = UIColor.blackColor.CGColor;
  button.layer.borderWidth = 2;
  [button setTitle:@"push" forState:UIControlStateNormal];
  [button setBackgroundColor:UIColor.redColor];
  [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
  
  
  UIButton* disbutton = [[UIButton alloc] initWithFrame:CGRectMake(10, 150, 100, 100)];
  disbutton.layer.borderColor = UIColor.blackColor.CGColor;
  [disbutton setTitle:@"dismiss" forState:UIControlStateNormal];
  [disbutton setBackgroundColor:UIColor.redColor];
  disbutton.layer.borderWidth = 2;
  [disbutton addTarget:self action:@selector(dis) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:disbutton];
  
  self.barDelegate = [[NavigationBarDelegate alloc] init];
  self.navigationDelegate = [[NavigationDelegate alloc] init];
  self.navigationController.delegate = self.navigationDelegate;
//  self.navigationController.navigationBar.delegate = self.barDelegate;
//  self.navigationController.delegate =
    // Do any additional setup after loading the view.
}

- (void)push {
  NSLog(@"push");
  BViewController* bc = [[BViewController alloc] init];
  [self.navigationController pushViewController:bc animated:true];
}

- (void)dis {
  NSLog(@"push");
  [self dismissViewControllerAnimated:YES completion:nil];
}

+ (UINavigationController*) createNavigationControler {
  AViewController* ac = [[AViewController alloc] init];
  UINavigationController* navi = [[SubBackNaviViewController alloc] initWithRootViewController:ac];
//  navi.navigationBar.delegate = [[NavigationBarDelegate alloc] init];
  return navi;
}


@end
