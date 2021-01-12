//
//  addFour.c
//  ArmTest
//
//  Created by fanyin on 2020/9/21.
//

#include "addFour.h"
#include "addThree.h"

long addFour(long a,long b, long c, long d)
{
	long basefour = 0x4444;
	long four = addThree(a, b, c);
	return basefour + four;
	
}
