//
//  ArgsParamterOc.m
//  ArmTest
//
//  Created by fanyin on 2020/9/22.
//

#import "ArgsParamterOc.h"

@implementation ArgsParamterOc




+ (long)sum:(NSNumber*)num, ...;
{
	
//	va_list arg_list;
//	va_start(arg_list, num);
//
////	for (int i = 0 ; i < num; i++) {
////		result += va_arg(arg_list, long);
////	}
//	int result = 0;
//
//	while ((objNum = va_arg(arg_list, long))) {
//		result += objNum;
//	}
//	va_end(arg_list);
//	return result;
//	return 0;;
	
	int ret = 0;
	va_list args;
	va_start(args, num);
	if (num)
	{
		ret = num.intValue;
		while ((num = va_arg(args, NSNumber *)))
		{
			ret += num.intValue;
		}
	}
	va_end(args);
	return  ret;
	
}

@end
