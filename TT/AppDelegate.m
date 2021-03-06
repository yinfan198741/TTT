//
//  AppDelegate.m
//  TTSSS
//
//  Created by 尹凡 on 2020/3/9.
//  Copyright © 2020 尹凡. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LLViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //    return YES;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    LLViewController *viewController = [[ViewController alloc] init];
    UINavigationController* Navigation = [[UINavigationController alloc] init];
    [Navigation setViewControllers:@[viewController]];
    self.window.rootViewController = Navigation;
    [self.window makeKeyAndVisible];
    return YES;
    
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
