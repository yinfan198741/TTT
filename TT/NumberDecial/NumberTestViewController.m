//
//  NumberTestViewController.m
//  TT
//
//  Created by 尹凡 on 2019/10/14.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "NumberTestViewController.h"

@interface NumberTestViewController ()

@end

@implementation NumberTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (NSArray*)createSourceNameFunList {
    return @[@[@"nsnumberTest",@"nsnumberTestCall"],
             @[@"stringToNSNumber",@"stringToNSNumberCall"],
             ];
}

- (void)nsnumberTestCall {
    NSLog(@"nsnumberTestCall");
    
    double a = 1.135500;
    NSNumber* number_a = @(a);
    NSLog(@"去掉了零number_a = %@",number_a.stringValue);
    
    double b = 0.134500;
    NSNumber* number_b = @(b);
    NSLog(@"去掉了零number_b = %@",number_b.stringValue);
    
    double c = 0.134400;
    NSNumber* number_c = @(c);
    NSLog(@"去掉了零number_c = %@",number_c.stringValue);
    
    double d = 1;
    NSNumber* number_d = @(d);
    NSLog(@"去掉了零number_d = %@",number_d.stringValue);
    
    NSNumberFormatter* formatter = [self formatter1];
    NSLog(@"formatter1 number_a = %@", [formatter stringFromNumber:number_a]);
    formatter = [self formatter2];
    NSLog(@"formatter2 number_b = %@", [formatter stringFromNumber:number_b]);
    
    formatter = [self formatter3];
    NSLog(@"formatter3 number_c = %@", [formatter stringFromNumber:number_c]);
    
    formatter = [self formatter4];
    NSLog(@"formatter4 number_d = %@", [formatter stringFromNumber:number_d]);
    
}


- (NSNumberFormatter*)formatter1 {
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.roundingMode = NSNumberFormatterRoundHalfUp;
    formatter.maximumFractionDigits = 2;
    return formatter;
}

- (NSNumberFormatter*)formatter2 {
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.roundingMode = NSNumberFormatterRoundHalfUp;
    formatter.maximumFractionDigits = 2;
    return formatter;
}


- (NSNumberFormatter*)formatter3 {
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.roundingMode = NSNumberFormatterRoundFloor;
    formatter.maximumFractionDigits = 2;
    return formatter;
}

- (NSNumberFormatter*)formatter4 {
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.roundingMode = NSNumberFormatterRoundFloor;
    formatter.maximumFractionDigits = 2;
    return formatter;
}


- (void)stringToNSNumberCall{
    NSLog(@"stringToNSNumberCall");
    NSString* t = @"0.008";
    double t1 = t.doubleValue;
    NSLog(@"%f",t1);
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
