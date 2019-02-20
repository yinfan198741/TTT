//
//  NavigationDelegate.m
//  TT
//
//  Created by 尹凡 on 2/20/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "NavigationDelegate.h"

@implementation NavigationDelegate

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
  NSLog(@"%s",__func__);
}
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
   NSLog(@"%s",__func__);
}

@end
