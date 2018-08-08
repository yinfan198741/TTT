//
//  ViewController.m
//  TT
//
//  Created by fanyin on 10/04/2017.
//  Copyright © 2017 fanyin. All rights reserved.
//

#import "ViewController.h"
#import "envTest.h"
#import "stdlib.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView* _v  = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    _v.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_v];
    
    getEvnTest();
    
    char* env = getenv("HOME");
    printf("env = %s",env);
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
