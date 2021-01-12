//
//  TestAss.s
//  ArmTest
//
//  Created by fanyin on 2020/9/23.
//
.global _TestAss

_addTow:
mov x2, #0x3
add x0, x0, x2;
ret


_jumpEqual:
mov x0, #1


_comp:
add x3, x3, x0
mov x4, #0x4

cmp x3, x4
b.le _jumpEqual
cmp x3, x4
b.eq _jumpEqual
cmp x3, x4
b.gt _jumpEqual




_TestAss:
mov x0 , #0x1;
mov x1 , #0x2;
add x0, x0, x1;
mov x3, 0;
mov x4, 0;
//b _comp;
str lr, [sp ,#-4];
bl _addTow
ldr lr, [sp ,#-4]
bl _assCall
ret



