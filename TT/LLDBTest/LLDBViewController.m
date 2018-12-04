//
//  LLDBViewController.m
//  TT
//
//  Created by 尹凡 on 11/20/18.
//  Copyright © 2018 fanyin. All rights reserved.
//

#import "LLDBViewController.h"


@interface  LLDBModel: NSObject
@property(nonatomic, copy)NSString* name;
@property(nonatomic, assign)int age;
@end

@implementation LLDBModel {

}
@end


@interface LLDBViewController ()
  @property(nonatomic, strong) LLDBModel* model;
@end

static int a = 100;

@implementation LLDBViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setModel];
  self.view.backgroundColor = UIColor.whiteColor;
  UIButton* button = [[UIButton alloc] initWithFrame: CGRectMake(100, 100, 100, 100)];
  button.backgroundColor = UIColor.blueColor;
  [button setTitle:@"watch" forState:UIControlStateNormal];
  [button addTarget:self action:@selector(watch) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
}

- (void)setModel {
  LLDBModel* model = [[LLDBModel alloc] init];
  model.name = @"model";
  model.age = 25;
  self.model = model;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)watch{
  NSLog(@"watch");
  a++;
  NSLog(@"watch = %d",a);
  self.model.age = a;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

