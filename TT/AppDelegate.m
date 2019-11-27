//
//  AppDelegate.m
//  TT
//
//  Created by fanyin on 10/04/2017.
//  Copyright © 2017 fanyin. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "SignalHandler.h"
#import "UncaughtExceptionHandler.h"
#import "captureViewController.h"
#import "captureManager.h"

#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"


// Log levels: off, error, warn, info, verbose
static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@interface AppDelegate ()

//@property (nonatomic, strong)UIWindow *w2;

@property (nonatomic, strong)captureManager* capManager;

@property (nonatomic, strong)HTTPServer* httpServer;



@end

@implementation AppDelegate

- (void)setupCrash {
    InstallSignalHandler();
    InstallUncaughtExceptionHandler();
}


- (void)startServer
{
	// Start the server (and check for problems)
	
	NSError *error;
	if([self.httpServer start:&error])
	{
		DDLogInfo(@"Started HTTP Server on port %hu", [self.httpServer listeningPort]);
	}
	else
	{
		DDLogError(@"Error starting HTTP Server: %@", error);
	}
}


- (void)startHttpServer
{
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
	
	// Create server using our custom MyHTTPServer class
	self.httpServer = [[HTTPServer alloc] init];
	[self.httpServer setPort:56666];
	
	// Tell the server to broadcast its presence via Bonjour.
	// This allows browsers such as Safari to automatically discover our service.
	[self.httpServer setType:@"_http._tcp."];
	
	// Normally there's no need to run our server on any specific port.
	// Technologies like Bonjour allow clients to dynamically discover the server's port at runtime.
	// However, for easy testing you may want force a certain port so you can just hit the refresh button.
	// [httpServer setPort:12345];
	
	// Serve files from our embedded Web folder
	NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
	DDLogInfo(@"Setting document root: %@", webPath);
}

- (void)stopHttpServer
{
	[self.httpServer stop];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  
  	[self setupCrash];
	
	// 1.创建UIWindow
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	// 设置UIWindow的背景颜色

	///创建root vc
	ViewController* vc = [[ViewController alloc] init];
	UINavigationController* root = [[UINavigationController alloc] initWithRootViewController:vc];
	self.window.rootViewController = root;
	
	// 让UIWindow显示出来(让窗口成为主窗口 并且显示出来)
	// 一个应用程序只能有一个主窗口
	[self.window makeKeyAndVisible];


	
	[self startHttpServer];
	
//	[[captureManager shareSingleObjc] setupWindow];
	
//	// 2. 再创建一个窗口
//	UIWindow *w2 = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//	w2.windowLevel = NSIntegerMax;
//	w2.backgroundColor = [UIColor yellowColor];
//	captureViewController* vc2 = [[captureViewController alloc] init];
//	w2.rootViewController = vc2;
//	[w2 makeKeyAndVisible];
//	self.w2 = w2;

//
//	// 3.创建两个文本输入框
//	// 3.1将文本输入框添加到window中
//	UITextField *tx1 = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 200, 40)];
////	tx1.borderStyle = UITextBorderStyleRoundedRect;
//	[self.window addSubview:tx1];
//
//	// 3.2将文本输入框添加到w2中
//	UITextField *tx2 = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 100, 40)];
////	tx2.borderStyle = UITextBorderStyleRoundedRect;
//	[self.w2 addSubview:tx2];
//

	
	
	

	
	return YES;

	
	
	
	/*
	///可以正常运行
>>>>>>> 3eb7b58818eb22ac6a88261a4feb7d41c34c4e50
    ViewController* vc = [[ViewController alloc] init];
    UINavigationController* root = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = root;
    [self.window makeKeyAndVisible];
<<<<<<< HEAD
    
    
    
    //  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //    UIViewController *vc = [UIViewController new];
    //    vc.view.backgroundColor = [UIColor redColor];
    //    [self.window.rootViewController presentViewController:vc animated:YES completion:^{
    //      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        UIViewController *vc1 = [UIViewController new];
    //        vc1.view.backgroundColor = [UIColor yellowColor];
    //        [vc presentViewController:vc1 animated:YES completion:nil];
    //      });
    //    }];
    //  });
    
    [[UINavigationBar appearance] setTranslucent:NO];
    
    //  [[FLObject appearance] setTextColor:[UIColor redColor]];
    
    //  [(FLAppearance *)[FLAppearance appearanceForClass:[self class]] startForwarding:self];
    
    //  [[UILabel appearance] setTextColor:UIColor.redColor];
    //  [[UILabel appearanceWhenContainedIn:[UITableViewCell class], nil]
    //setTextColor:[UIColor redColor]];
=======
	*/



	
  
  
  //  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
  //    UIViewController *vc = [UIViewController new];
  //    vc.view.backgroundColor = [UIColor redColor];
  //    [self.window.rootViewController presentViewController:vc animated:YES completion:^{
  //      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
  //        UIViewController *vc1 = [UIViewController new];
  //        vc1.view.backgroundColor = [UIColor yellowColor];
  //        [vc presentViewController:vc1 animated:YES completion:nil];
  //      });
  //    }];
  //  });
  
//  [[UINavigationBar appearance] setTranslucent:NO];
	
//  [[FLObject appearance] setTextColor:[UIColor redColor]];
  
//  [(FLAppearance *)[FLAppearance appearanceForClass:[self class]] startForwarding:self];
  
//  [[UILabel appearance] setTextColor:UIColor.redColor];
//  [[UILabel appearanceWhenContainedIn:[UITableViewCell class], nil]
//setTextColor:[UIColor redColor]];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
