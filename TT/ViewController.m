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
#import "Test.h"
#import "PushViewController.h"

@interface ViewController ()

@end

 UILabel* _la;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    int tabBarHeight = 66;
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, tabBarHeight, 100, 100)];
    button.backgroundColor = UIColor.blueColor;
    [button setTitle:@"fun Call" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton* button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 100 + tabBarHeight, 100, 100)];
    button2.backgroundColor = UIColor.blackColor;
    [button2 setTitle:@"env" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    _la = [[UILabel alloc] initWithFrame:CGRectMake(0, 200 + tabBarHeight,
                                                    100, 100)];
    _la.text = @"lalala";
    _la.backgroundColor = [UIColor yellowColor];
    _la.textColor = [UIColor blueColor];
    [self.view addSubview:_la];
    
    
    UIButton* button3 = [[UIButton alloc]
                         initWithFrame:CGRectMake(0, 300 + tabBarHeight,
                                                  100,100)];
    button3.backgroundColor = UIColor.blackColor;
    [button3 setTitle:@"push" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(click3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
}



- (void)click {
    NSLog(@"click123");
    int va = fooFunction();
    _la.text = [NSString stringWithFormat:@"%d",va];
}


- (void)click2 {
    NSLog(@"click2");
    getEvnTest();
    char* env = getenv("HOME");
    printf("env = %s",env);
}

- (void)click3 {
    NSLog(@"click3");
    
//    for (int i = 0 ; i < 5; i++)
    {
        PushViewController* pvc = [[PushViewController alloc] init];
        [self.navigationController pushViewController:pvc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
