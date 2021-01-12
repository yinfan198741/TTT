//
//  addTow.c
//  ArmTest
//
//  Created by fanyin on 2020/9/20.
//

#include "addTow.h"


long addTow(long a,long b)
{
	long base = 0x2222;
	long baseP = &base;
	return base + a + b;
}
