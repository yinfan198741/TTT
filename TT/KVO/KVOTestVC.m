//
//  KVOTestVC.m
//  TT
//
//  Created by fanyin on 2020/1/4.
//  Copyright © 2020 fanyin. All rights reserved.
//

#import "KVOTestVC.h"



@interface kvoPP : NSObject
@property (nonatomic, strong) NSString* name1;
@end

@implementation kvoPP

- (void)dealloc
{
	NSLog(@"dealloc");
}
@end

@interface kvoP : NSObject
@property (nonatomic, strong) NSString* name;
@end

@implementation kvoP

- (void)dealloc
{
	NSLog(@"dealloc");
}

@end

@interface kvoOb : NSObject

@end

@implementation kvoOb

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
						change:(NSDictionary<NSKeyValueChangeKey,id> *)change
					   context:(void *)context
{
	NSLog(@"object = %@",object);
//	kvoOb
//	kvoPP *ob = [[kvoPP alloc] init];
//	[ob observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end

@interface KVOTestVC ()

@property (nonatomic, strong) kvoP* p ;
@property (nonatomic, strong) kvoOb* ob;

@end

@implementation KVOTestVC

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.p = [[kvoP alloc] init];
	self.ob = [[kvoOb alloc] init];
	
	self.view.backgroundColor = UIColor.whiteColor;
	
	UIButton* bu = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 50, 50)];
	bu.backgroundColor = UIColor.redColor;
	[bu setTitle:@"add" forState:UIControlStateNormal];
	[bu addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:bu];
	
	
	UIButton* bu1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 50, 50)];
	bu1.backgroundColor = UIColor.redColor;
	[bu1 setTitle:@"change" forState:UIControlStateNormal];
	[bu1 addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:bu1];
}

- (void)click
{
	NSLog(@"click");
	
//	kvoP* pp = [[kvoP alloc] init];
//	[pp addObserver:self.ob forKeyPath:@"name" options:NSKeyValueObservingOptionInitial context:nil];
//
	
//	kvoP *pps = [[kvoP alloc] init];
//
//	[pps addObserver:self.ob forKeyPath:@"name" options:NSKeyValueObservingOptionInitial context:nil];
//	__unsafe_unretained kvoOb *wpps = pps;
//	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//		[wpps removeObserver:self.ob forKeyPath:@"name"];
//	});

	
//		kvoP *pps = [[kvoP alloc] init];
	
	kvoOb* tob = [[kvoOb alloc] init];
	
		[self.p addObserver:tob forKeyPath:@"name" options:NSKeyValueObservingOptionInitial context:nil];
	
	__weak kvoOb* wtob = tob;
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[self.p removeObserver:wtob forKeyPath:@"name"];
		});
	
}

- (void)change
{
//	self.p.name = @"1";
//	[self.p removeObserver:self.ob forKeyPath:@"name"];
	kvoPP* p = [[kvoPP alloc] init];
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
		
		p.name1 = @"123";
	});
	
	
	
	
}

@end
