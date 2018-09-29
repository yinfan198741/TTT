//
//  UncaughtExceptionHandler.m
//  UncaughtExceptionDemo
//
//  Created by  tomxiang on 15/8/28.
//  Copyright (c) 2015年  tomxiang. All rights reserved.
//

#import "UncaughtExceptionHandler.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>
#import <UIKit/UIKit.h>
#import "ExceptionModel.h"
//#import "NSFileManager.h"

@implementation UncaughtExceptionHandler

+ (NSString *)getDocumentsPath
{
    //获取Documents路径
  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSLog(@"path:%@", path);
    return path;
}

+(NSString*)getCurrentTimes{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
  
 
  
    NSLog(@"currentTimeString =  %@",currentTimeString);
    return currentTimeString;
}

+(NSString*)getCurrentTimesFFFF{
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
  [formatter setDateFormat:@"HH_mm_ss"];
  //现在时间,你可以输出来看下是什么格式
  NSDate *datenow = [NSDate date];
  //----------将nsdate按formatter格式转成nsstring
  
 
  NSString *currentTimeString = [formatter stringFromDate:datenow];
  NSLog(@"currentTimeString =  %@",currentTimeString);
  return currentTimeString;
}


+(void)writeFile{
  
  NSString *documentsPath =[self getDocumentsPath];
  NSString *time = [self getCurrentTimesFFFF];
  NSString* name = [NSString stringWithFormat:@"iOS_%@.txt",time];
    NSString* iOSPath = [documentsPath stringByAppendingPathComponent:name];
  NSFileManager *fm = [NSFileManager defaultManager];
  [fm createFileAtPath:iOSPath contents:nil attributes:nil];
  int i  = 0;
//    while(true)
  while(i < 100)
  {
    i++;
    NSString* content = [NSString stringWithFormat:@"i = %d content = %@\n", i, [self getCurrentTimes]];
    NSFileHandle *myHandle = [NSFileHandle fileHandleForWritingAtPath:iOSPath];
    [myHandle seekToEndOfFile];
    [myHandle writeData:[content dataUsingEncoding:NSUTF8StringEncoding]];
      
      
//        BOOL isSuccess = [content writeToFile:iOSPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
//        if (isSuccess) {
//            NSLog(@"write success");
//        } else {
//            NSLog(@"write fail");
//        }
    }
}



+(NSString*)saveTime:(NSString *)savePath {
    [UncaughtExceptionHandler writeFile];
    return @"";
}

+(NSString*)saveCreash:(NSString *)exceptionInfo
{
    NSString * _libPath  = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"OCCrash"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:_libPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:_libPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    
    NSString * savePath = [_libPath stringByAppendingFormat:@"/error%@.log",timeString];
    
    BOOL sucess = [exceptionInfo writeToFile:savePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"YES sucess:%d",sucess);
    return savePath;
}

@end

void HandleException(NSException *exception)
{
    // 异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];
    
    // 出现异常的原因
    NSString *reason = [exception reason];
    
    // 异常名称
    NSString *name = [exception name];
    
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception reason：%@\nException name：%@\nException stack：%@",name, reason, stackArray];
    
    NSLog(@"%@", exceptionInfo);

    NSString* path = [UncaughtExceptionHandler saveCreash:exceptionInfo];
    [UncaughtExceptionHandler saveTime:path];
}


void InstallUncaughtExceptionHandler(void)
{
    NSSetUncaughtExceptionHandler(&HandleException);
}

