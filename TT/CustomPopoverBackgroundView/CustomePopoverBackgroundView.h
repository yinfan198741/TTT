//
//  CustomePopoverBackgroundView.h
//  TT
//
//  Created by 尹凡 on 2021/1/25.
//  Copyright © 2021 fanyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIPopoverBackgroundView.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomePopoverBackgroundView :UIPopoverBackgroundView
{
  CGFloat                     _arrowOffset;
  UIPopoverArrowDirection     _arrowDirection;
  UIImageView                *_arrowImageView;
  UIImageView                *_popoverBackgroundImageView;
}

@property (nonatomic, readwrite)            CGFloat                  arrowOffset;
@property (nonatomic, readwrite)            UIPopoverArrowDirection  arrowDirection;
@property (nonatomic, readwrite, strong)    UIImageView             *arrowImageView;
@property (nonatomic, readwrite, strong)    UIImageView             *popoverBackgroundImageView;

+ (CGFloat)arrowHeight;
+ (CGFloat)arrowBase;
+ (UIEdgeInsets)contentViewInsets;

@end

NS_ASSUME_NONNULL_END
