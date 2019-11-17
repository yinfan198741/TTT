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



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self bindInsets];
        [self bindText];
    }
    return self;
}


- (void)bindText {

    @weakify(self)
    [[[RACSignal combineLatest:@[RACObserve(self,text),
                                 RACObserve(self,attributedText)]
                        reduce:^id(NSString* text, NSAttributedString* attr){
                            return  @(text.length > 0 || attr.length > 0);
                        }] distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
                            @strongify(self)
                            [self invalidateIntrinsicContentSize];
                            [self setNeedsLayout];
                        }];
    
//    [[RACSignal combineLatest:[RACObserve(self,text),
//                               RACObserve(self,attributedText)]  reduce:^(NSString* text, NSAttributedString* attr] {
//        return text.length > 0 || attr.length > 0
//    }];
//
//   [[ RACObserve(self,text), RACObserve(self,attributedText)] ]
//    [[[RACObserve(self,text) map:^id _Nullable(NSString*   value) {
//        return @(value.length > 0);
//    }]  distinctUntilChanged] subscribeNext:^(id x) {
//        [self invalidateIntrinsicContentSize];
//        [self setNeedsLayout];
//    }];

}

//- (CGSize)intrinsicContentSize
//{
//    if (self.text.length == 0 && self.attributedText.length == 0) {
//        return CGSizeZero();
//    }
//
//    return [super intrinsicContentSize];
//}


- (CGSize)intrinsicContentSize {
    if (self.text.length == 0 && self.attributedText.length == 0) {
        return CGSizeMake(0, 0);
    }
    else {
        CGSize sz = [super intrinsicContentSize];
        return CGSizeMake(sz.width + self.insets.left + self.insets.right,
                          sz.height + self.insets.top + self.insets.bottom);
    }
}


//- (void)bindText
//{
//    RACObserver(self,Text)
//}

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
