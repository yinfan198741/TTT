//
//  NavigationDelegate.m
//  TT
//
//  Created by 尹凡 on 2/20/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "NavigationBarDelegate.h"

@implementation NavigationBarDelegate

- (BOOL)navigationBar:(UINavigationBar *)navigationBar
       shouldPushItem:(UINavigationItem *)item {
  NSLog(@"%s",__func__);
  return true;
} // called to push. return NO not to.

- (BOOL)navigationBar:(UINavigationBar *)navigationBar
        shouldPopItem:(UINavigationItem *)item {
  NSLog(@"%s",__func__);
  return true;
}  // same as push methods



@end
