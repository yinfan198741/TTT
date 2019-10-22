//
//  InsetsLabel.m
//  TT
//
//  Created by 尹凡 on 2019/10/22.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "InsetsLabel.h"
#import "ReactiveObjC.h"

@implementation InsetsLabel


- (void)drawTextInRect:(CGRect)rect
{
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}

// 修改绘制文字的区域，edgeInsets增加bounds
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    
    //调用父类该方法
    //注意传入的UIEdgeInsetsInsetRect(bounds, self.edgeInsets),bounds是真正的绘图区域
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds,
                                                                 self.insets) limitedToNumberOfLines:numberOfLines];
    //根据edgeInsets，修改绘制文字的bounds
    rect.origin.x -= self.insets.left;
    rect.origin.y -= self.insets.top;
    rect.size.width += self.insets.left - self.insets.right;
    rect.size.height += self.insets.top - self.insets.bottom;
    return rect;
}

- (CGSize)intrinsicContentSize {
    CGSize sz = [super intrinsicContentSize];
    return CGSizeMake(sz.width + self.insets.left + self.insets.right,
                      sz.height + self.insets.top + self.insets.bottom);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self bindInsets];
    }
    return self;
}


- (void)bindInsets {
    @weakify(self)
    [[RACObserve(self, insets) distinctUntilChanged] subscribeNext:^(id x) {
        @strongify(self)
        [self invalidateIntrinsicContentSize];
        [self setNeedsLayout];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
