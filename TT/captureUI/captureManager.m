//
//  captureManager.m
//  TT
//
//  Created by fanyin on 2019/11/17.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "captureManager.h"
#import "captureViewController.h"
#import "captureWindow.h"
#import "captureViewController.h"

static captureManager *single = nil;


@interface captureManager()
@property(strong) captureWindow *w2 ;
@end

@implementation captureManager

+ (instancetype)shareSingleObjc
{
	if (single == nil) {
		static dispatch_once_t onceToken;
		dispatch_once(&onceToken, ^{
			single = [[captureManager alloc] init];
		});
	}
	return single;
}


- (void)setupWindow
{
	captureWindow *w2 = [[captureWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	w2.windowLevel = campWindowLeve;
//	cgf
	captureViewController* vc2 = [[captureViewController alloc] init];
	w2.rootViewController = vc2;
	[w2 makeKeyAndVisible];
	self.w2 = w2;
}

@end
