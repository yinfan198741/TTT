//
//  SubBackNaviViewController+Back.m
//  TT
//
//  Created by 尹凡 on 2/20/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "SubBackNaviViewController+Back.h"

@implementation SubBackNaviViewController (Back)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar
       shouldPushItem:(UINavigationItem *)item {
  NSLog(@"SubBackNaviViewController shouldPushItem");
  NSLog(@"%s",__func__);
  return true;
}

//- (BOOL)navigationBar:(UINavigationBar *)navigationBar
//        shouldPopItem:(UINavigationItem *)item {
//  NSLog(@"SubBackNaviViewController shouldPopItem");
//  NSLog(@"%s",__func__);
//  return true;
//}

@end
