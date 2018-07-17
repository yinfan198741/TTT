//
//  Test.c
//  TT
//
//  Created by 尹凡 on 7/9/18.
//  Copyright © 2018 fanyin. All rights reserved.
//

#include "Test.h"


void fooFunction() {
    int add = addFunction(12, 34);
    printf("add = %i", add);
}


__attribute__((noinline))

int addFunction(int a, int b)
{
    int c = a + b;
    return c;
}
