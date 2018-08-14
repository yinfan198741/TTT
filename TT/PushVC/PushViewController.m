//
//  PushViewController.m
//  TT
//
//  Created by 尹凡 on 8/13/18.
//  Copyright © 2018 fanyin. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.redColor;
    UIGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]
                                  initWithTitle: @"Root"
                                  style: UIBarButtonItemStylePlain
                                  target:nil
                                  action:nil];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.navigationItem.title = @"Hello, im the title";
   
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]
                                  initWithTitle: @"left"
                                  style: UIBarButtonItemStylePlain
                                  target:nil
                                  action:nil];
    
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)tap {
//    [self popViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"tap");
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
