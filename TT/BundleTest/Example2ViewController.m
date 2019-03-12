//
//  Example2ViewController.m
//  BundleDemo
//
//  Created by 晓童 韩 on 16/3/31.
//  Copyright © 2016年 晓童 韩. All rights reserved.
//

#import "Example2ViewController.h"

@interface Example2ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@end

@implementation Example2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"NSBundle2" ofType:@"png" inDirectory:@"images2"];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:filePath]];
    self.imageView.image = [UIImage imageWithData:imageData];
    
    
    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"NSBundle3" ofType:@"png" inDirectory:@"images2/bundle"];
    NSData *imageData2 = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:filePath2]];
    self.imageView2.image = [UIImage imageWithData:imageData2];
}

@end
