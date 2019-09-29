//
//  DynamicSysTest+DySenteic.m
//  TT
//
//  Created by 尹凡 on 2019/9/29.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "DynamicSysTest+DySenteic.h"
#import <objc/runtime.h>

@implementation DynamicSysTest (DySenteic)


- (void)saveRefObj:(NSString*)str
{
    objc_setAssociatedObject(self , @"KEY" , str , OBJC_ASSOCIATION_COPY);
}

- (NSString*)getRefObj
{
    return objc_getAssociatedObject(self , @"KEY");
}

- (NSString*)testAgeME
{
    return @"testAgeME123";
}

@end
