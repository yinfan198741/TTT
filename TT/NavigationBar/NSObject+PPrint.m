//
//  NSObject+PPrint.m
//  TT
//
//  Created by 尹凡 on 1/30/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "NSObject+PPrint.h"
#import <objc/runtime.h>// 导入运行时文件

@implementation NSObject (PPrint)


+ (instancetype)getProperties:(Class)cls{
  
  // 获取当前类的所有属性
  unsigned int count;// 记录属性个数
  objc_property_t *properties = class_copyPropertyList(cls, &count);
  // 遍历
  NSMutableArray *mArray = [NSMutableArray array];
  for (int i = 0; i < count; i++) {
    
    // An opaque type that represents an Objective-C declared property.
    // objc_property_t 属性类型
    objc_property_t property = properties[i];
    // 获取属性的名称 C语言字符串
    const char *cName = property_getName(property);
    // 转换为Objective C 字符串
    NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
    NSLog(@"name = %@",name);
    [mArray addObject:name];
  }
  
  return mArray.copy;
}

@end
