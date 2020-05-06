//
//  CatelogHookViewController.m
//  TT
//
//  Created by 尹凡 on 3/5/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "CatelogHookViewController.h"

@interface CatelogHookViewController ()

@end

@implementation CatelogHookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.view.backgroundColor = UIColor.whiteColor;
  
  UIImageView *imageView = [[UIImageView alloc]
                            initWithFrame:CGRectMake(100, 100, 100, 100)];
  imageView.image = [UIImage imageNamed:@"inventory_selected"];
  [imageView setBackgroundColor:[UIColor redColor]];
  [self.view addSubview:imageView];
  
	self.meSetcontrollerName = @"categrouy =  CatelogHookViewController";
}


- (void)dealloc
{
	NSLog(@"delloc = %@",self.meSetcontrollerName);
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
