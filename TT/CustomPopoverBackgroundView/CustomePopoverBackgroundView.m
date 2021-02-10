//
//  CustomePopoverBackgroundView.m
//  TT
//
//  Created by 尹凡 on 2021/1/25.
//  Copyright © 2021 fanyin. All rights reserved.
//

#import "CustomePopoverBackgroundView.h"


// Predefined arrow image width and height
#define ARROW_WIDTH 13.0
#define ARROW_HEIGHT 6.0

// Predefined content insets
#define TOP_CONTENT_INSET 0
#define LEFT_CONTENT_INSET 0
#define BOTTOM_CONTENT_INSET 0
#define RIGHT_CONTENT_INSET 0

@interface CustomePopoverBackgroundView()
{
//  UIImage *_topArrowImage;
  UIImage *_leftArrowImage;
  UIImage *_rightArrowImage;
  UIImage *_bottomArrowImage;
  
 
}
// @property(n ,strong)
@property (nonatomic ,strong) UIImage *topArrowImage;;

@end

@implementation CustomePopoverBackgroundView

@synthesize arrowOffset = _arrowOffset, arrowDirection = _arrowDirection, popoverBackgroundImageView = _popoverBackgroundImageView, arrowImageView = _arrowImageView;


#pragma mark - Overriden class methods

// The width of the arrow triangle at its base.
+ (CGFloat)arrowBase
{
  return ARROW_WIDTH;
}

// The height of the arrow (measured in points) from its base to its tip.
+ (CGFloat)arrowHeight
{
  return ARROW_HEIGHT;
}

// The insets for the content portion of the popover.
+ (UIEdgeInsets)contentViewInsets
{
  return UIEdgeInsetsMake(TOP_CONTENT_INSET, LEFT_CONTENT_INSET, BOTTOM_CONTENT_INSET, RIGHT_CONTENT_INSET);
}

#pragma mark - Custom setters for updating layout

// Whenever arrow changes direction or position layout subviews will be called in order to update arrow and backgorund frames

-(void) setArrowOffset:(CGFloat)arrowOffset
{
  _arrowOffset = arrowOffset;
  [self setNeedsLayout];
}

-(void) setArrowDirection:(UIPopoverArrowDirection)arrowDirection
{
  _arrowDirection = arrowDirection;
  [self setNeedsLayout];
}

#pragma mark - Initialization

-(id)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame])
      {
    
//    [UIImage imageNamed:@"inventory_selected"];
    self.topArrowImage = [UIImage imageNamed:@"inventory_selected"];
//    _topArrowImage = [UIImage imageNamed:@"Arrow_top"];
//    _leftArrowImage = [UIImage imageNamed:@"popover-black-left-arrow-image.png"];
//    _bottomArrowImage = [UIImage imageNamed:@"popover-black-bottom-arrow-image.png"];
//    _rightArrowImage = [UIImage imageNamed:@"popover-black-right-arrow-image.png"];
    
//    UIImage *popoverBackgroundImage = [[UIImage imageNamed:@"popover-black-bcg-image.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(49, 46, 49, 45)];
//    self.popoverBackgroundImageView = [[UIImageView alloc] initWithImage:popoverBackgroundImage];
//    [self addSubview:self.popoverBackgroundImageView];
    
    self.arrowImageView = [[UIImageView alloc] init];
    
    
    
    [self addSubview:self.arrowImageView];
  }
  
  return self;
}

#pragma mark - Layout subviews

-(void)layoutSubviews
{
  [super layoutSubviews];
  
  CGFloat popoverImageOriginX = 0;
  CGFloat popoverImageOriginY = 0;
  
  CGFloat popoverImageWidth = self.bounds.size.width;
  CGFloat popoverImageHeight = self.bounds.size.height;
  
  CGFloat arrowImageOriginX = 0;
  CGFloat arrowImageOriginY = 0;
  
  CGFloat arrowImageWidth = ARROW_WIDTH;
  CGFloat arrowImageHeight = ARROW_HEIGHT;
  
  // Radius value you used to make rounded corners in your popover background image
  CGFloat cornerRadius = 0;
  
  switch (self.arrowDirection) {
      
    case UIPopoverArrowDirectionUp:
      
      popoverImageOriginY = ARROW_HEIGHT - 2;
      popoverImageHeight = self.bounds.size.height - ARROW_HEIGHT;
      
      // Calculating arrow x position using arrow offset, arrow width and popover width
      arrowImageOriginX = roundf((self.bounds.size.width - ARROW_WIDTH) / 2 + self.arrowOffset);
      
      // If arrow image exceeds rounded corner arrow image x postion is adjusted
      arrowImageOriginX = MIN(arrowImageOriginX, self.bounds.size.width - ARROW_WIDTH - cornerRadius);
      arrowImageOriginX = MAX(arrowImageOriginX, cornerRadius);
      
      // Setting arrow image for current arrow direction
      self.arrowImageView.image = self.topArrowImage;
      
      break;
      
//    case UIPopoverArrowDirectionDown:
//
//      popoverImageHeight = self.bounds.size.height - ARROW_HEIGHT + 2;
//
//      arrowImageOriginX = roundf((self.bounds.size.width - ARROW_WIDTH) / 2 + self.arrowOffset);
//
//      arrowImageOriginX = MIN(arrowImageOriginX, self.bounds.size.width - ARROW_WIDTH - cornerRadius);
//      arrowImageOriginX = MAX(arrowImageOriginX, cornerRadius);
//
//      arrowImageOriginY = popoverImageHeight - 2;
//
//      self.arrowImageView.image = _bottomArrowImage;
//
//      break;
//
//    case UIPopoverArrowDirectionLeft:
//
//      popoverImageOriginX = ARROW_HEIGHT - 2;
//      popoverImageWidth = self.bounds.size.width - ARROW_HEIGHT;
//
//      arrowImageOriginY = roundf((self.bounds.size.height - ARROW_WIDTH) / 2 + self.arrowOffset);
//
//      arrowImageOriginY = MIN(arrowImageOriginY, self.bounds.size.height - ARROW_WIDTH - cornerRadius);
//      arrowImageOriginY = MAX(arrowImageOriginY, cornerRadius);
//
//      arrowImageWidth = ARROW_HEIGHT;
//      arrowImageHeight = ARROW_WIDTH;
//
//      self.arrowImageView.image = _leftArrowImage;
//
//      break;
//
//    case UIPopoverArrowDirectionRight:
//
//      popoverImageWidth = self.bounds.size.width - ARROW_HEIGHT + 2;
//
//      arrowImageOriginX = popoverImageWidth - 2;
//      arrowImageOriginY = roundf((self.bounds.size.height - ARROW_WIDTH) / 2 + self.arrowOffset);
//
//      arrowImageOriginY = MIN(arrowImageOriginY, self.bounds.size.height - ARROW_WIDTH - cornerRadius);
//      arrowImageOriginY = MAX(arrowImageOriginY, cornerRadius);
//
//      arrowImageWidth = ARROW_HEIGHT;
//      arrowImageHeight = ARROW_WIDTH;
//
//      self.arrowImageView.image = _rightArrowImage;
//
//      break;
//
//    default:
//
//      // For popovers without arrows (Thanks Martin!)
//      popoverImageHeight = self.bounds.size.height - ARROW_HEIGHT + 2;
//
//      break;
  }
  
//  self.popoverBackgroundImageView.frame = CGRectMake(popoverImageOriginX, popoverImageOriginY, popoverImageWidth, popoverImageHeight);
  self.arrowImageView.frame = CGRectMake(arrowImageOriginX, arrowImageOriginY, arrowImageWidth, arrowImageHeight);
}



@end
