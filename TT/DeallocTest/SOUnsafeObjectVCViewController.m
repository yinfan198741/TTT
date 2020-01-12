//
//  SOUnsafeObjectVCViewController.m
//  TT
//
//  Created by fanyin on 2020/1/12.
//  Copyright © 2020 fanyin. All rights reserved.
//

#import "SOUnsafeObjectVCViewController.h"

@interface SOUnsafeObjectVCViewController ()

@end

@implementation SOUnsafeObjectVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)reloadDataInBackground {
	//	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
	//		dispatch_async(dispatch_get_main_queue(), ^{
	//			self.title = @"Retrieved data";
	//		});
	//
	//		sleep(3);
	//	});
	
	//	instrumentObjcMessageSends(YES);
	//	__weak typeof(self) wk = self;
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		dispatch_async(dispatch_get_main_queue(), ^{
			
			self.title = @"Retrieved data";
			
			//			__strong  typeof(self) sk = wk;
			NSLog(@"Retrieved data  =%@",NSThread.currentThread);
			//			sk.title = @"Retrieved data";
			
		});
		
		sleep(3);
	});
	
}

- (void)dealloc {
	NSLog(@"Test dealloc  =%@",NSThread.currentThread);
	NSAssert([NSThread isMainThread], @"Object should always be deallocated on the main thread");
}

@end
