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
#include <objc/message.h>


@interface TS : NSObject

@end

@implementation TS

@end


@interface TS2 : NSObject

@end

@implementation TS2

@end

@interface father : NSObject

- (void)eat;
@end

@implementation father

- (void)eat
{
	NSLog(@"father eat");
	
}

-(Class)getMyClass
{
	return [self class];
}

- (Class)class
{
	return TS.class;
}

@end


@interface son : father

- (void)eat;

@end

@implementation son

- (void)eat
{
	[super eat];
//	NSLog(@"son eat");
}

-(void)test
{
	
	father *cA = [[father alloc] init];
	NSLog(@"selfClass: %@, superClass: %@", [self class], [cA class]);
	//son fasther
	
	NSLog(@"1selfClass: %@, superClass: %@", [self class], [super getMyClass]);
	///son son
	//ts2 ts2
	
	NSLog(@"2selfClass: %@, superClass: %@", [self class], [super class]);
	///son son
	///ts2 ts
}

- (Class)class
{
	return TS2.class;
}

@end

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
//	deepTree();
	
	
//	int c = 20;
//	int *t= &c;
//	int val = 10;
//	char* fmt = "val = %d\n";
//	void (^blk)(void) = ^{
//		// block 内截获的是 10 和 fmt 指针指向的地址
//		printf(fmt, val);
//		printf("c1\n");
//		printf(fmt, *t);
//		*t = 220;
//		printf("c2\n");
//		printf(fmt, *t);
//	};
//	
//	// blk 只是截获了 val 的瞬间值(10)去初始化 block 结构体的 val 成员变量，
//	// val 的值无论再怎么改写，都与 block 结构体内的值再无瓜葛
//	val = 2;
//	c = 110;
//	// 修改了 fmt 指针的指向，blk 对应 block 结构体只是截获了 fmt 指针原始指向的 char 字符串，
//	// 所以 blk 内打印使用的还是 "val = %d\n"
//	fmt = "These values were changed. val = %d\n";
//	printf(fmt, c);
//	printf("c3\n");
//	blk();
//	printf("c4\n");
//	printf(fmt, c);

	son* s  = [[son alloc] init];
	[s test];
//	[s eat];
	
	
//	son* s  = [[son alloc] init];
//	[s eat];
//
//
	struct objc_super superReceiver = {
		self,
		objc_getClass("son")
	};

//	struct objc_super* p = &superReceiver;
//	id sr = (__bridge id)p;
//
//	((void (*)(id, SEL))(void *)objc_msgSendSuper)(sr, sel_registerName("eat"));
	
//	((void (*)(id, SEL))(void*)objc_msgSendSuper(&superReceiver,sel_registerName("eat"));
	
	
	
	
	
	return;
	
	
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
