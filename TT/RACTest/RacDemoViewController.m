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
  
    
    UIButton* bu = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 200, 50)];
    bu.backgroundColor = UIColor.redColor;
    [bu setTitle:@"倒计时" forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bu];
    
    
}

- (void)click:(UIButton*)b {
    
    RACDisposable* dis = [[RACSignal interval:1 onScheduler:RACScheduler.mainThreadScheduler] subscribeNext:^(NSDate * _Nullable x) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"mm:ss"];
        NSString *current = [formatter stringFromDate:x];
        b.titleLabel.text = current;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(10 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       [dis dispose];
                   });
   NSLog(@"click");
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
