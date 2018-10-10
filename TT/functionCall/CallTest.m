//
//  CallTest.m
//  TT
//
//  Created by 尹凡 on 9/29/18.
//  Copyright © 2018 fanyin. All rights reserved.
//

#import "CallTest.h"

@implementation CallTest


-(NSString*)getName:(NSString*)name {
  NSString* name1 = @"Name1";
  NSString* name2 = @"Name2";
  NSString* name3 = @"Name3";
  
  return [NSString stringWithFormat:@"n1 = %@, n2 = %@, n3 = %@ \n", name1 ,name2, name3];
}

-(int)getAge:(int)age {
  int p1 = 1;
  int p2 = 2;
  int p3 = 3;
  int p4 = p1 + p2 + p3 + age;
  return p4;
}

-(NSString*)getInfo:(NSString*)name age:(int)age {
  int p1 = 1;
  int p2 = 2;
  int p3 = 3;
  return [NSString stringWithFormat:@"name = %@, age = %d \n", name ,age];
}

@end
