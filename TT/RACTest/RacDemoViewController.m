//
//  RacDemoViewController.m
//  TT
//
//  Created by fanyin on 2019/8/18.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "RacDemoViewController.h"
#import "ReactiveObjC.h"


@interface RacDemoViewController ()

@end

@implementation RacDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.title = @"RacDemoViewController";
    self.view.backgroundColor = UIColor.whiteColor;
    UIGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
}


- (void)tap {
    [self dismissViewControllerAnimated:YES completion:nil];
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
