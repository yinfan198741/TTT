
//
//  Example1ViewController.m
//  BundleDemo
//
//  Created by 晓童 韩 on 16/3/31.
//  Copyright © 2016年 晓童 韩. All rights reserved.
//

#import "Example1ViewController.h"

@interface Example1ViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UIImageView *questionView;

@end

@implementation Example1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //使用Create Groups
    NSString *filePath0 = [[NSBundle mainBundle] pathForResource:@"left" ofType:@"png" inDirectory:@"images"];
    NSLog(@"%@", filePath0);
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"left" ofType:@"png"];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:filePath]];
    self.image.image = [UIImage imageWithData:imageData];
    
    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"memory" ofType:@"png"];
    NSData *imageData2 = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:filePath2]];
    self.questionView.image = [UIImage imageWithData:imageData2];
    
    
    UIButton* bu = [[UIButton alloc] initWithFrame:CGRectMake(0, 500, 50, 50)];
    bu.backgroundColor = UIColor.redColor;
    [bu setTitle:@"Test" forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bu];
}


- (void)click {
    NSLog(@"click");
    
    NSString *path = NSHomeDirectory();
    NSLog(@"path = %@",path);
    
    NSArray<NSString*>* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSLog(@"NSArray = %@",paths);
    NSString* filePath = [NSString stringWithFormat:@"%@/%@",paths[0],@"test.txt"];
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    
    
    NSString* test = @"test";
    BOOL write = [test writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"write = %@",(write == YES ? @"yes":@"NO"));
    
    NSString* resource = [NSBundle mainBundle].resourcePath;
    NSLog(@"resource = %@",resource);
}

@end
