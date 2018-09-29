//
//  UncaughtExceptionHandler.h
//  UncaughtExceptionDemo
//
//  Created by  tomxiang on 15/8/28.
//  Copyright (c) 2015年  tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UncaughtExceptionHandler: NSObject
+(NSString*)saveCreash:(NSString *)exceptionInfo;
+(NSString*)saveTime:(NSString *)savePath;
@end


void InstallUncaughtExceptionHandler(void);


