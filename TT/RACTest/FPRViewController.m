//
//  FPRViewController.m
//  TT
//
//  Created by fanyin on 2019/9/14.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "FPRViewController.h"
#import "ReactiveObjC.h"

@interface FPRViewController ()

@property (nonatomic, strong) UIButton* timeButton;

@end

@implementation FPRViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
	[self.view addGestureRecognizer:tap];
	self.view.backgroundColor = UIColor.whiteColor;
	[self.view addSubview:self.timeButton];
	
	
}



- (void)tap {
	[self dismissViewControllerAnimated:YES completion:nil];
}


-(UIButton*)timeButton {
	
	if (_timeButton == nil) {
		_timeButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 100, 50)];
		[_timeButton setTitle:@"发送" forState:UIControlStateNormal];
		_timeButton.backgroundColor = UIColor.redColor;
		[_timeButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
		[_timeButton setTitleColor:UIColor.grayColor forState:UIControlStateDisabled];
//		[[self.timeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^( UIControl *  x) {
//			NSLog(@"%@",x);
//		}];
		
		RACSignal* touchSignal = [self.timeButton rac_signalForControlEvents:UIControlEventTouchUpInside];
		RACSignal* timeSignal = [self timeSignal];

		@weakify(self);
		[[[[[touchSignal map:^id (id  value) {
			return timeSignal;
		}] startWith:timeSignal] flatten]
		  takeUntil:self.rac_willDeallocSignal]
		 subscribeNext:^(NSNumber* x) {
			 @strongify(self);
			 NSLog(@"x = %ld",x.integerValue);
			 if (x.integerValue == 0) {
				 [self.timeButton setTitle:@"发送" forState:UIControlStateNormal];
				 self.timeButton.enabled = YES;
			 }else
			 {
				 NSString* title = [x stringValue];
				 [self.timeButton setTitle:title forState:UIControlStateNormal];
				 self.timeButton.enabled = NO;
			 }
		 } completed:^{
			 NSLog(@"%s, pipeline completed", __PRETTY_FUNCTION__);
		 }];
//
//
//		[[[touchSignal flattenMap:^ RACSignal * (id  value) {
//			return timeSignal;
//		}] takeUntil:self.rac_willDeallocSignal]
//
//		 subscribeNext:^(NSNumber*  _Nullable x) {
//			 @strongify(self);
//
//			 NSLog(@"x = %ld",x.integerValue);
//
//			 if (x.integerValue == 0) {
//				 [self.timeButton setTitle:@"发送" forState:UIControlStateNormal];
//				 self.timeButton.enabled = YES;
//			 }else
//			 {
//				 NSString* title = [x stringValue];
//				 [self.timeButton setTitle:title forState:UIControlStateNormal];
//				 self.timeButton.enabled = NO;
//			 }
//		 } completed:^{
//			 NSLog(@"%s, pipeline completed", __PRETTY_FUNCTION__);
//		 }];
	}
	return _timeButton;
}


-(RACSignal*)timeSignal {
	static int timeCount = 6;
	RACSignal* seconde = [RACSignal interval:1 onScheduler:RACScheduler.mainThreadScheduler];
	NSMutableArray *showSeconde = [NSMutableArray array];
	for (int i = timeCount ; i >= 0; i--) {
		[showSeconde addObject:@(i)];
	}
	RACSignal* showSignal =	[showSeconde.rac_sequence signal];
	RACSignal* _timeSg = [[showSignal zipWith:seconde] flattenMap:^ RACSignal * (RACTuple*  value) {
		return [RACSignal return:value.first];
	}];
//	RACSignal * sig = [_timeSg takeUntil:self.rac_willDeallocSignal];
//	return [[sig setNameWithFormat:@" %s ", __PRETTY_FUNCTION__] logCompleted];
	return [[_timeSg setNameWithFormat:@" %s ", __PRETTY_FUNCTION__] logCompleted];
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

