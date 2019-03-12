//
//  Example3ViewController.m
//  BundleDemo
//
//  Created by 晓童 韩 on 16/3/31.
//  Copyright © 2016年 晓童 韩. All rights reserved.
//

#import "Example3ViewController.h"

@interface Example3ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@end

@implementation Example3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取NSBundle文件的Path
    NSString * imgBundlePath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"bundle"];
    // 使用Path地址新建一个NSBundle对象
    NSBundle *imgBundle = [NSBundle bundleWithPath:imgBundlePath];
    
    NSString *filePath = [imgBundle pathForResource:@"bundle4" ofType:@"png"];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:filePath]];
    self.imageView.image = [UIImage imageWithData:imageData];
    
    NSString *filePath2 = [imgBundle pathForResource:@"bundle5" ofType:@"png" inDirectory:@"res"];
    NSData *imageData2 = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:filePath2]];
    self.imageView2.image = [UIImage imageWithData:imageData2];
}


@end
