//
//  ArgsParamter.h
//  ArmTest
//
//  Created by fanyin on 2020/9/22.
//

#ifndef ArgsParamter_h
#define ArgsParamter_h

#include <stdio.h>
#include <stdarg.h>
#include <stdio.h>


int assCall(int a,int b);

int sum(int argnum, ...);

double average(int count, ...);

void test(const char* format, ...);

#endif /* ArgsParamter_h */
