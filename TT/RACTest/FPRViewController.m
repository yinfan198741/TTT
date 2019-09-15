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

@property (nonatomic, strong) UIButton* downLoadButton;

@property (nonatomic, strong) UIButton* combineButton;

@property (nonatomic, strong) UIImageView* imgView;

@property (nonatomic, strong) UIImage* image;

@property (nonatomic, strong) UIButton* downloadProgressButton;

@property (nonatomic, strong) NSArray* downloadSourceData;

@end

@implementation FPRViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.downloadSourceData = @[@[@"a",@"1"],
								@[@"b",@"3"],
								@[@"c",@"5"],];
	
	UIGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
	[self.view addGestureRecognizer:tap];
	self.view.backgroundColor = UIColor.whiteColor;
	
	//	定时器
	//	[self.view addSubview:self.timeButton];
	
	[self.view addSubview:self.downLoadButton];
	
	[self.view addSubview:self.imgView];
	
	[self.view addSubview:self.combineButton];
	
	[self.view addSubview:self.downloadProgressButton];
}



- (void)tap {
	[self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark 下载图片


- (UIButton*)downLoadButton {
	if (_downLoadButton == nil) {
		_downLoadButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 120, 100, 50)];
		[_downLoadButton setTitle:@"下载" forState:UIControlStateNormal];
		_downLoadButton.backgroundColor = UIColor.blueColor;
//		[[_downLoadButton rac_signalForControlEvents:UIControlEventTouchUpInside]
//		 subscribeNext:^( UIControl *  x) {
//			 NSLog(@"%@",x);
//		} completed:^{
//			 NSLog(@"%s, pipeline completed", __PRETTY_FUNCTION__);
//		}];
		@weakify(self)
		[[[_downLoadButton rac_signalForControlEvents:UIControlEventTouchUpInside]
		  flattenMap:^ RACSignal * (UIControl *  value) {
			  return self.downloadProcess;
		  }] subscribeNext:^(UIImage* x) {
			  @strongify(self)
			  self.image = x;
		  }];
	}
	return _downLoadButton;
}


 static NSInteger errorCount = 0;

-(RACSignal*)downloadProcess {
	
	
	RACSignal* takeTest = [RACSignal return:@"123"];
	[[takeTest take:3] subscribeNext:^(id   x) {
		NSLog(@"takeTest = %@",x);
	}];
	
	NSArray* imgPath = @[@"left",@"left1"];
	RACSignal* pathSig = [imgPath.rac_sequence signal];
	
	
	RACSequence* seque = imgPath.rac_sequence;
	[[[seque take:1] signal] subscribeNext:^(id   x) {
		NSLog(@"take:1  = %@ ",x);
	}];
	
	[[[seque take:2] signal] subscribeNext:^(id  x) {
		NSLog(@"take:2  = %@",x);
	}];
	
	[[[seque take:3] signal] subscribeNext:^(id  x) {
		NSLog(@"take:3  = %@",x);
	}];
	
	//	[[seque take:1] subscribeNext:^(id  _Nullable x) {
	//		NSLog(@"%@",x);
	//	}];
	//
	//	[[seque take:2] subscribeNext:^(id  _Nullable x) {
	//		NSLog(@"%@",x);
	//	}];
	//
	//	[[seque take:3] subscribeNext:^(id  _Nullable x) {
	//		NSLog(@"%@",x);
	//	}];
	
	
	
	RACSignal* downloadSig = [[pathSig take:1] flattenMap:^ RACSignal * (NSString*   value) {
		
		return	[RACSignal createSignal:^RACDisposable * (id<RACSubscriber>  subscriber) {
			errorCount ++ ;
			if (errorCount < 3) {
				NSLog(@"error happen");
				NSError* err = [NSError errorWithDomain:@"downloaderror" code:0 userInfo:nil];
				[subscriber sendError:err];
			}
			else {
				errorCount = 0;
				NSString* path = value;
				NSString *filePath0 = [[NSBundle mainBundle] pathForResource:path ofType:@"png" inDirectory:@"images"];
				__block	NSData * imgdata = [NSData dataWithContentsOfFile:filePath0];
				[subscriber sendNext:imgdata];
				[subscriber sendCompleted];
				return [RACDisposable disposableWithBlock:^{
					imgdata = nil;
				}];
			}
			return nil;
		}];
		
		
	}];
	
	//	RACSignal* downloadSig = [RACSignal createSignal:^RACDisposable * (id<RACSubscriber>  subscriber) {
	//		NSString *filePath0 = [[NSBundle mainBundle] pathForResource:@"left" ofType:@"png" inDirectory:@"images"];
	//		__block	NSData * imgdata = [NSData dataWithContentsOfFile:filePath0];
	//		[subscriber sendNext:imgdata];
	//		[subscriber sendCompleted];
	//		return [RACDisposable disposableWithBlock:^{
	//			imgdata = nil;
	//		}];
	//	}];
	
	return [[[[downloadSig deliverOn:RACScheduler.mainThreadScheduler] timeout:5 onScheduler:RACScheduler.mainThreadScheduler] retry:3] flattenMap:^ RACSignal * (NSData* value) {
		NSError* err = [NSError errorWithDomain:@"img data null" code:0 userInfo:nil];
		return	value == nil ? [RACSignal error:err] :
		[RACSignal createSignal:^RACDisposable * (id<RACSubscriber>  subscriber) {
			UIImage* img = [UIImage imageWithData:value];
			[subscriber sendNext:img];
			[subscriber sendCompleted];
			return nil;
		}];
	}];
	
}


- (UIImageView*)imgView {
	if (_imgView == nil) {
		_imgView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 120, 100, 100)];
//		RACObserve(_imgView, image)
		RAC(_imgView,image) = RACObserve(self, image);
		
	}
	return _imgView;
}


#pragma mark 倒计时

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


#pragma mark  combol then concate zip Test

-(void)mergeTest {
	
	NSArray* chars = @[@"a",@"b",@"c",@"d"];
	NSArray* number = @[@"1",@"2"];
	RACSignal* charsSig = [chars.rac_sequence signal];
	RACSignal* numberSig = [number.rac_sequence signal];
	
	[RACScheduler.mainThreadScheduler afterDelay:1 schedule:^{
		NSLog(@"merge=========");
		[[charsSig merge:numberSig] subscribeNext:^(id  _Nullable x) {
			NSLog(@"merge = %@",x);
		}];
	}];
	
	[RACScheduler.mainThreadScheduler afterDelay:2 schedule:^{
		NSLog(@"then=========");
		[[charsSig then:^RACSignal * {
			return numberSig;
		}] subscribeNext:^(id   x) {
			NSLog(@"then = %@",x);
		}];
	}];
	
	
	
	
	[RACScheduler.mainThreadScheduler afterDelay:3 schedule:^{
		NSLog(@"combineLatestWith=========");
		
		[[charsSig combineLatestWith:numberSig] subscribeNext:^(id  _Nullable x) {
			NSLog(@"combineLatestWith = %@",x);
		}];
		
	}];
	
	
	[RACScheduler.mainThreadScheduler afterDelay:4 schedule:^{
		NSLog(@"concat=========");
		
		[[charsSig concat:numberSig] subscribeNext:^(id  _Nullable x) {
			NSLog(@"concat = %@",x);
		}];
		
	}];
	
	
	[RACScheduler.mainThreadScheduler afterDelay:5 schedule:^{
		NSLog(@"zipWith=========");
		[[charsSig zipWith:numberSig] subscribeNext:^(id  _Nullable x) {
			NSLog(@"zip = %@",x);
		}];
		
	}];
	
}


- (UIButton*)combineButton {
	if (_combineButton == nil) {
		_combineButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 220, 100, 50)];
		[_combineButton setTitle:@"合并" forState:UIControlStateNormal];
		_combineButton.backgroundColor = UIColor.blueColor;
		@weakify(self)
		[[_combineButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^( UIControl *  x) {
			@strongify(self)
			[self mergeTest];
		}];
	}
	return _combineButton;
}


#pragma mark downloadProgress

- (void)downloadProgress
{
	NSLog(@"downloadProgress");
	
//		RACSignal* timer = [RACSignal interval:1 onScheduler:RACScheduler.mainThreadScheduler] ;
//
//		[timer subscribeNext:^(id  _Nullable x) {
//			NSLog(@"timer = %@ \n" ,x);
//		}];

	
	
	static const CGFloat tickCount = 60 / 0.5;
	RACSignal *timer = [[RACSignal interval:0.5 onScheduler:[RACScheduler mainThreadScheduler]]
						map:^id(id value) {
							return nil;
						}];
	
	NSMutableArray *numbers = [[NSMutableArray alloc] init];
	for (NSInteger i = 0; i < tickCount; i++) {
		[numbers addObject:@(i)];
	}
	
	RACSignal *counter = [[[[numbers.rac_sequence signal]
							 zipWith:timer]
							map:^id(RACTuple *tuple) {
								NSNumber *n = tuple.first;
								return RACTuplePack(n, @(tickCount), nil);//12
							}]
						   
						  logCompleted];
	
	
	NSArray* accounts =	self.downloadSourceData;
	//6
	NSMutableArray *sequence = [[NSMutableArray alloc] init];
	for (int i = 0; i < accounts.count; i++) {
		[sequence addObject:@(i + 1)];
	}
	
	
	static NSInteger progressValue = 0;
	
	RACSignal* gg = [self downloadProgressSigg];
	[[[[[[gg flatten] zipWith:[sequence.rac_sequence signal]]//8
		combineLatestWith:[RACSignal return:@(accounts.count)]]//8
	   map:^id(RACTuple *tuple) {
		   //9
		   RACTuple *nestedTuple = tuple.first;
		   NSNumber *accountsCount = tuple.second;
		   
		   NSString *account = nestedTuple.first;
		   NSNumber *order = nestedTuple.second;
		   
		   //10
		   return RACTuplePack(order, accountsCount, account);
	   }]
	  merge:counter] subscribeNext:^(id  _Nullable x) {
		NSLog(@"x = %@",x);
	}];
	
//	RACSignal* fsigs = [[[self downloadProgressSigs] rac_sequence] flatten];
//
//	[[fsigs merge:timer] subscribeNext:^(id  _Nullable x) {
//		NSLog(@"fsigs x1 = %@ \n" ,x);
//	}];
	
	
//	RACSignal* sig = [[[self downloadProgressSig] publish] autoconnect];
//	
//	[sig subscribeNext:^(id  _Nullable x) {
//		NSLog(@"x1 = %@ \n" ,x);
//	}];
	
//	RACSignal* timer = [[RACSignal interval:1 onScheduler:RACScheduler.mainThreadScheduler] takeUntil:self.rac_willDeallocSignal];
//
//	[timer subscribeNext:^(id  _Nullable x) {
//		NSLog(@"timer = %@ \n" ,x);
//	}];
	
//	[[sig zipWith:timer] subscribeNext:^(id  _Nullable x) {
//		NSLog(@"x1 = %@ \n" ,x);
//	}];
	
//	[sig subscribeNext:^(id  _Nullable x) {
//		NSLog(@"x1 = %@ \n" ,x);
//	}];
//
//	[sig subscribeNext:^(id  _Nullable x) {
//		NSLog(@"x2 = %@ \n" ,x);
//	}];
	
}

- (RACSignal*)downloadProgressSigg {
//	  [[self.downloadSourceData.rac_sequence signal] map:^id (NSArray<NSString*>* value) {
//		NSString* title = value.firstObject;
//		NSInteger time = value[1].integerValue;
//
//		RACSignal* innerSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//			[[[RACScheduler.mainThreadScheduler afterDelay:time schedule:^{
//				NSString* downloadInfo = [NSString stringWithFormat:@"download = %@",title];
//				NSLog(@"downloadSignale = %@",downloadInfo);
//				[subscriber sendNext:downloadInfo];
//				[subscriber sendCompleted];
//			}];
//			  return nil;
//			  }]] ;
//		return [[innerSignal multicast:[RACReplaySubject subject]] autoconnect];
//	}];
	
	
	return	[[[[self.downloadSourceData.rac_sequence signal] map:^id (NSArray<NSString*>* value) {
		NSString* title = value.firstObject;
		NSInteger time = value[1].integerValue;
		
		RACSignal* innerS = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
			NSString* downloadInfo = [NSString stringWithFormat:@"download = %@",title];
			NSLog(@"downloadSignale = %@",downloadInfo);
			[subscriber sendNext:downloadInfo];
			[subscriber sendCompleted];
			return nil;
		}];
		return [[innerS multicast:[RACReplaySubject subject]] autoconnect];
	}] multicast:[RACReplaySubject subject]] autoconnect]  ;
	
}


- (RACSignal*)downloadProgressSig
{

	
	NSArray<RACSignal*>* downloadSignales = [[[self.downloadSourceData.rac_sequence signal] map:^id _Nullable(NSArray<NSString*>*   value) {
		NSString* title = value.firstObject;
		NSInteger time = value[1].integerValue;
		return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
			[RACScheduler.mainThreadScheduler afterDelay:time schedule:^{
				NSString* downloadInfo = [NSString stringWithFormat:@"download = %@",title];
				NSLog(@"downloadSignale = %@",downloadInfo);
				[subscriber sendNext:downloadInfo];
				[subscriber sendCompleted];
			}];
			return nil;
		}];
	}] toArray];
	
//	NSArray<RACSignal*>* downloadSignales =	[[downloadSourceData.rac_sequence signal] flattenMap:^ RACSignal * (id  value) {
//		return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//			NSString* downloadInfo = [NSString stringWithFormat:@"download = %@",value];
//			[subscriber sendNext:downloadInfo];
//			[subscriber sendCompleted];
//			return nil;
//		}];
//	}];
//return 	[[downloadSignales.firstObject zipWith:downloadSignales[1]] zipWith:downloadSignales[2]];
//return 	[downloadSignales.firstObject zipWith:[downloadSignales[1] zipWith:downloadSignales[2]]];
//	return 	[RACSignal zip:downloadSignales];
	
	return [RACSignal merge:downloadSignales];
}


- (NSArray<RACSignal*>*)downloadProgressSigs
{
	
	
	NSArray<RACSignal*>* downloadSignales = [[[self.downloadSourceData.rac_sequence signal] map:^id _Nullable(NSArray<NSString*>*   value) {
		NSString* title = value.firstObject;
		NSInteger time = value[1].integerValue;
		return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
			[RACScheduler.mainThreadScheduler afterDelay:time schedule:^{
				NSString* downloadInfo = [NSString stringWithFormat:@"download = %@",title];
				NSLog(@"downloadSignale = %@",downloadInfo);
				[subscriber sendNext:downloadInfo];
				[subscriber sendCompleted];
			}];
			return nil;
		}];
	}] toArray];
	
	return downloadSignales;
	
	//	NSArray<RACSignal*>* downloadSignales =	[[downloadSourceData.rac_sequence signal] flattenMap:^ RACSignal * (id  value) {
	//		return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
	//			NSString* downloadInfo = [NSString stringWithFormat:@"download = %@",value];
	//			[subscriber sendNext:downloadInfo];
	//			[subscriber sendCompleted];
	//			return nil;
	//		}];
	//	}];
	//return 	[[downloadSignales.firstObject zipWith:downloadSignales[1]] zipWith:downloadSignales[2]];
	//return 	[downloadSignales.firstObject zipWith:[downloadSignales[1] zipWith:downloadSignales[2]]];
	//	return 	[RACSignal zip:downloadSignales];
	
	
}



- (UIButton*)downloadProgressButton {
	if (_downloadProgressButton == nil) {
		_downloadProgressButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 320, 100, 50)];
		[_downloadProgressButton setTitle:@"下载进度" forState:UIControlStateNormal];
		_downloadProgressButton.backgroundColor = UIColor.purpleColor;
		@weakify(self)
		[[_downloadProgressButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^( UIControl *  x) {
			@strongify(self)
			[self downloadProgress];
		}];
	}
	return _downloadProgressButton;
}

- (void)dealloc
{
	NSLog(@"dealloc");
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

