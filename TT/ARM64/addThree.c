//
//  addThree.c
//  ArmTest
//
//  Created by fanyin on 2020/9/20.
//

#include "addThree.h"
#include "addTow.h"


long addThree(long a,long b, long c)
{

	long baseThree = 0x3333;
	long tow = addTow(a, b);
	return baseThree + tow;
}
