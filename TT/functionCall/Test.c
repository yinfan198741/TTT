//
//  Test.c
//  TT
//
//  Created by 尹凡 on 7/9/18.
//  Copyright © 2018 fanyin. All rights reserved.
//

#include "Test.h"

int fooFunction() {
    int a = 0xA;
    int b = 0xB;
    int add = addFunction(1, 2);
    printf("add = %i\n", add);
    return add;
}

int addFunction(int a, int b)
{
    int c = a + b;
    int d = 4;
    int e = 5;
    return c + d + e;
}
