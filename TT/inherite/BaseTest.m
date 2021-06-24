//
//  BaseTest.m
//  TT
//
//  Created by 尹凡 on 2021/3/26.
//  Copyright © 2021 fanyin. All rights reserved.
//

#import "BaseTest.h"

@implementation BaseTest

- (void)Test
{
  
  printf("start======");
  
  int c = 20; //0x200
  int *t= &c; //0x300 -> 0x200
  __block int val = 10;
  __block NSMutableArray* ma  = [NSMutableArray arrayWithCapacity:1];
  val = 12;
  char* fmt = "val = %d\n";//0x1000000
  void (^blk)(void) = ^{
    // block 内截获的是 10 和 fmt 指针指向的地址
    printf(fmt, val);
    val = 20;
    printf("c1\n");
    printf(fmt, *t); //0x300
    *t = 220;
    printf("c2\n");
    printf(fmt, *t);
    
    [ma addObject:@(1)];
  };
  
  // blk 只是截获了 val 的瞬间值(10)去初始化 block 结构体的 val 成员变量，
  // val 的值无论再怎么改写，都与 block 结构体内的值再无瓜葛
  val = 2;
  c = 110;
  // 修改了 fmt 指针的指向，blk 对应 block 结构体只是截获了 fmt 指针原始指向的 char 字符串，
  // 所以 blk 内打印使用的还是 "val = %d\n"
  fmt = "These values were changed. val = %d\n";//0x200000
  printf(fmt, c);
  printf("c3\n");
  blk();
  printf("c4\n");
  printf(fmt, c);
}

@end
