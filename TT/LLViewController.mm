//
//  LLViewController.m
//  TT
//
//  Created by 尹凡 on 2021/1/14.
//  Copyright © 2021 fanyin. All rights reserved.
//

#import "LLViewController.h"
#include "ll.hpp"
#include "MyPopViewController.h"
#include "CustomePopoverBackgroundView.h"


@interface LLViewController ()
{
	UIButton* button ;
}
@end

@implementation LLViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = UIColor.whiteColor;
	
	
	button = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 50, 50)];
	[button setTitle:@"TT" forState:UIControlStateNormal];
	[button setBackgroundColor:UIColor.redColor];
	[button addTarget:self action:@selector(createButtonTouched) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button];
	
	
	UIImageView* image = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
	image.image = [UIImage imageNamed:@"Arrow.png"];
	[self.view addSubview:image];
	
	// Do any additional setup after loading the view.
}

- (void)createButtonTouched
{
	deepTree();
	
	MyPopViewController* pop = [[MyPopViewController alloc] init];
	pop.preferredContentSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, 200);
	pop.modalPresentationStyle = UIModalPresentationPopover;
	pop.popoverPresentationController.sourceView = button;
	pop.popoverPresentationController.permittedArrowDirections = UIMenuControllerArrowUp;
	pop.popoverPresentationController.delegate = self;
	pop.popoverPresentationController.popoverBackgroundViewClass = [CustomePopoverBackgroundView class];
	
	[self presentViewController:pop animated:YES completion:nil];
}

#pragma mark - <UIPopoverPresentationControllerDelegate>
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
	return UIModalPresentationNone;
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
