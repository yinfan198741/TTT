//
//  LogUploadManager.m
//  TT
//
//  Created by fanyin on 2019/11/25.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "LogUploadManager.h"


@interface LogUploadManager()

@property (nonatomic, strong) dispatch_source_t writeTimer;

@property (nonatomic, strong) NSMutableString* logInfo;

@end

@implementation LogUploadManager

static LogUploadManager* instance = nil;

+(LogUploadManager*)shareInstance
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[self alloc] init ];
	});
	return instance;
}


- (void)setup
{
	[self writeTimerT];
}


- (void)writeTimerT

{
	__block	int count = 0;
	
	// 获得队列
	
	dispatch_queue_t queue = dispatch_get_main_queue();
	
	// 创建一个定时器(dispatch_source_t本质还是个OC对象)
	
	self.writeTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
	
	// 设置定时器的各种属性（几时开始任务，每隔多长时间执行一次）
	
	// GCD的时间参数，一般是纳秒（1秒 == 10的9次方纳秒）
	
	// 何时开始执行第一个任务
	
	// dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC) 比当前时间晚3秒
	
	dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
	
	uint64_t interval = (uint64_t)(1 * NSEC_PER_SEC);
	
	dispatch_source_set_timer(self.writeTimer, start, interval, 0);
	
	// 设置回调
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"ss"];
	
	dispatch_source_set_event_handler(self.writeTimer, ^{
		
		
		NSString* tlog = [NSString stringWithFormat:@"%@",[NSDate date]] ;
		[self writeLog:tlog];
		
		
		
		count++;
		if (count == 4) {
			
			// 取消定时器
			//			[self.logI appendString:[NSString stringWithFormat:@"%@ *\n",log]];
//			NSLog(@"self.logI = %@",self.logI);
			dispatch_cancel(self.writeTimer);
			
			self.writeTimer = nil;
			
		}
		
	});
	
	// 启动定时器
	
	dispatch_resume(self.writeTimer);
}


- (void)writeLog:(NSString*)log
{
	
	//	[self.info addObject:log];
	//	[self.logI stringByAppendingString:@"\n"];
	//	[self.logI stringByAppendingString:log];
	NSLog(@"log = %@",log);
	
	
	
//	[self.logI appendString:[NSString stringWithFormat:@"%@",log]];
	
//	[self.logI appendString:@"\r"];
	
//	NSLog(@"logI = %@",self.logI);
}


@end
