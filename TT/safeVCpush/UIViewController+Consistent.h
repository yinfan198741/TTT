//
//  UIViewController+Consistent.h
//  TT
//
//  Created by 尹凡 on 8/13/18.
//  Copyright © 2018 fanyin. All rights reserved.
//

#import <UIKit/UIKit.h>

static char const * const ObjectTagKey = "ObjectTag";

@interface UINavigationController ()
@property (readwrite,getter = isViewTransitionInProgress) BOOL viewTransitionInProgress;
@end
