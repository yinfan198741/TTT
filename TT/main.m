//
//  main.m
//  TT
//
//  Created by fanyin on 10/04/2017.
//  Copyright © 2017 fanyin. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTest.h"

int main(int argc, char * argv[]) {
  
  NSLog(@"main");
  
//  NSObject *obj = [[NSObject alloc] init];
//  __weak NSObject *weakObj = obj;
  
  
  BaseTest* ba = [[BaseTest alloc] init];
  [ba Test];
  
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
