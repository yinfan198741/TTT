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
    int c = 0xC;
    int d = 0xD;
    int e = 0xE;
    int add = addFunction(1, 2);
    printf("add = %i\n", add);
    return add;
}

int addFunction(int a, int b)
{
    int c = a + b;
    int d = 4;
    int e = 5;
    int f = 6;
    int g = 7;
    int h = 8;
    int i = 9;
    return c + d + e + f + g + h + i;
}
