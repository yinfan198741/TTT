//
//  captureWindow.m
//  TT
//
//  Created by fanyin on 2019/11/17.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "captureWindow.h"
#import "captureViewController.h"

@implementation captureWindow

+ (void)setupCaptureWindow
{
//	captureWindow* window = [[captureWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//	captureViewController* capVC = [[captureViewController alloc] init];
//	[window setRootViewController:capVC];
	
	
//	captureWindow *w2 = [[captureWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//	w2.windowLevel = NSIntegerMax;
//	w2.backgroundColor = [UIColor yellowColor];
//	captureViewController* vc2 = [[captureViewController alloc] init];
//	w2.rootViewController = vc2;
//	[w2 makeKeyAndVisible];
//	self.w2 = w2;
	
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
	return YES;
//	return NO;
}


@end
