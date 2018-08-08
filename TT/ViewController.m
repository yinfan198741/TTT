//
//  ViewController.m
//  TT
//
//  Created by fanyin on 10/04/2017.
//  Copyright © 2017 fanyin. All rights reserved.
//

#import "ViewController.h"
#include "Test.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView* _v  = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    _v.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_v];
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    button.backgroundColor = UIColor.yellowColor;
    [button setTitle:@"Test" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


- (void)click {
    NSLog(@"click123");
    fooFunction();
}




- (void)addNumber:(int)number {
    int a  = 1;
    int b = number;
    int c = a + b;
    NSLog(@"%d",c);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
