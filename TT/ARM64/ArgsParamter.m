//
//  ArgsParamter.c
//  ArmTest
//
//  Created by fanyin on 2020/9/22.
//

#include "ArgsParamter.h"
#include <stdio.h>
#include <stdarg.h>
#include <string.h>


int assCall(int a,int b)
{
	printf("%d %d",a,b);
	return a + b ;
}


int sum(int argnum, ...)
{
	va_list arguments;
	int i;
	int sum = 0;

	va_start(arguments, argnum); /* Needs last known character to calculate
							   the address of the other parameters */
	for(i = 0; i < argnum; ++i)
		sum += va_arg(arguments, int); /* use next argument */

	va_end(arguments);

	return sum;
}

double average(int count, ...) {
	va_list ap;
	int j;
	double sum = 0;

	va_start(ap, count); /* Requires the last fixed parameter (to get the address) */
	for (j = 0; j < count; j++) {
		sum += va_arg(ap, int); /* Increments ap to the next argument. */
	}
	va_end(ap);

	return sum;
}


void parse(va_list ap) {
  char* arg;
  arg = va_arg(ap, char*);
	printf("%s  length = %lu",arg,strlen(arg));
//  std::cout << arg << std::endl
//			<< strlen(arg) << std::endl;
}
void test(const char* format, ...) {
  for (int i = 0; i < 2; i++) {
	va_list ap;
	va_start(ap, format);
	parse(ap);
	va_end(ap);
  }
}




