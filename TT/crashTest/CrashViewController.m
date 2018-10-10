//
//  CrashViewController.m
//  TT
//
//  Created by 尹凡 on 9/29/18.
//  Copyright © 2018 fanyin. All rights reserved.
//

#import "CrashViewController.h"

typedef struct Test
{
  int a;
  int b;
}Test;


@interface CrashViewController ()

@end

@implementation CrashViewController

- (void)viewDidLoad {
    [super viewDidLoad];

  self.view.backgroundColor = UIColor.whiteColor;
  UIButton* _button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 150, 100)];
  [_button setTitle:@"signalException" forState:UIControlStateNormal];
  [_button setTitleColor:UIColor.redColor forState:UIControlStateNormal];
  [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_button];
  
  
  UIButton* _ocbutton = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 150, 100)];
  [_ocbutton setTitle:@"OCException" forState:UIControlStateNormal];
  [_ocbutton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
  [_ocbutton addTarget:self action:@selector(buttonOCException:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_ocbutton];
  
}

- (void)buttonClick:(UIButton *)sender {
  //1.信号量
  Test *pTest = {1,2};
  free(pTest);
  pTest->a = 5;
}

-(void)buttonOCException:(UIButton *)sender {
  //2.ios崩溃
  NSArray *array= @[@"tom",@"xxx",@"ooo"];
  [array objectAtIndex:5];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
