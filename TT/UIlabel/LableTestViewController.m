//
//  LableTestViewController.m
//  TT
//
//  Created by 尹凡 on 2019/10/18.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "LableTestViewController.h"
#import "InsetsLabel.h"
#import "View+MASAdditions.h"
#import "ReactiveObjC.h"

//今日问题
//jsonseri
//archive

@interface LableTestViewController ()

@property (strong,nonatomic) UILabel* label;

@property (strong,nonatomic) UILabel* label1;

@property (nonatomic, copy) NSString* showText;

@property (nonatomic, copy) NSString* item;

@property (nonatomic, strong)InsetsLabel* la;

@end

@implementation LableTestViewController


- (void)TestLable {
    
    self.item = @"abc";
    self.showText = @"showText";
    
    InsetsLabel* la = [[InsetsLabel alloc] initWithFrame:CGRectZero];
    la.translatesAutoresizingMaskIntoConstraints = NO;
    la.backgroundColor = UIColor.redColor;
    la.insets = UIEdgeInsetsMake(0, 100, 0, 0);
    la.text = @"123";
    la.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:la];
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).mas_offset(10);
        make.top.equalTo(self.view).mas_offset(30);
    }];
    
    self.la = la;
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectZero];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:@"TTTT" forState:0];
    button.backgroundColor = UIColor.blueColor;
    [button addTarget:self action:@selector(TTT) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).mas_offset(10);
        make.top.equalTo(self.view).mas_offset(100);
    }];
    
    [self bind];
    
    
    UITextField* t = [[UITextField alloc] initWithFrame:CGRectMake(10, 200, 30, 30)];
    t.backgroundColor = UIColor.redColor;
    t.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:t];
    
}

-(void)TTT
{
//    NSString* a =
//    NSString* a = "a";
    NSLog(@"TTT");
    
   self.showText = [NSString stringWithFormat:@"%@%@",_showText,_item];
    
    if (self.showText.length > 40) {
        self.showText = nil;
    }
    
}

- (void)bind {
//    self.item
    RAC(self.la,attributedText) = [RACObserve(self,showText) map:^id _Nullable(id  _Nullable value) {
        if (value!= nil) {
            NSAttributedString* att = [[NSAttributedString alloc] initWithString:value];
            return att;
        }
        return nil;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self TestLable];
   return;
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100,300, 60)];
    
    //    NSMutableAttributedString * attributeTitle = [[NSMutableAttributedString alloc] init];
    //
    //    [attributeTitle appendAttributedString:[[NSAttributedString alloc] initWithString:@"(共"]];
    //
    //    NSString* colorString = @"称";
    //    NSDictionary *att = @{NSForegroundColorAttributeName:UIColor.redColor};
    //    NSAttributedString* attrColorString = [[NSAttributedString alloc] initWithString:colorString attributes:att];
    //    [attributeTitle appendAttributedString:attrColorString];
    //
    //    [attributeTitle appendAttributedString:[[NSAttributedString alloc] initWithString:@"个)"]];
    //
    //    NSString *str6 = @"设置笔画宽度和填充颜色\n";
    //    NSDictionary *dictAttr6 = @{NSStrokeWidthAttributeName:@(2),NSStrokeColorAttributeName:[UIColor blueColor]};
    //    NSAttributedString *attr6 = [[NSAttributedString alloc]initWithString:str6 attributes:dictAttr6];
    //    [attributeTitle appendAttributedString:attr6];
    //
    //
    //    UIBezierPath *path = [[UIBezierPath alloc] init];
    //    [path moveToPoint:CGPointMake(0, 0)];
    //    [path addLineToPoint:CGPointMake(15, 0)];
    //    [path addLineToPoint:CGPointMake(15, 15)];
    //    [path addLineToPoint:CGPointMake(0, 0)];
    //
    //    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    //    shapeLayer.fillColor = UIColor.blueColor.CGColor;
    //    shapeLayer.path = path.CGPath;
    //
    //    [self.label.layer addSublayer:shapeLayer];
    //
    //    self.label.attributedText = attributeTitle;
    //    [self.view addSubview:self.label];
    //    attributeTitle
    
    //self.label.attributedText
    
    
    //    self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 200,20, 20)];
    //    self.label1.text = @"购";
    //    self.label1.layer.borderColor = UIColor.redColor.CGColor;
    //    self.label1.layer.borderWidth = 1;
    //    [self.view addSubview:self.label1];
    //    UIView* tp = [[self class] tempLable2:@"购"];
    UIView* tp = [[self class] tempLable2:@"买二赠一"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"这是一串字"];
    
    for (int i = 0 ; i < 100; i ++) {
        //设置Attachment
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        //使用一张图片作为Attachment数据
        attachment.image = [self convertViewToImage:tp];// [UIImage imageNamed:@"inventory_selected"];
        //这里bounds的x值并不会产生影响
        CGSize size = tp.bounds.size;
        attachment.bounds = CGRectMake(-2, -2, size.width, size.height);
        [attributedString appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
        [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
    }
    
    self.label.attributedText = attributedString;
    self.label.numberOfLines = 2;
    self.label.lineBreakMode = NSLineBreakByCharWrapping;
    [self.view addSubview:self.label];
    
   
    
}


+ (UIView*)tempLable:(NSString*)content{
    
    UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectZero];
    label1.font = [UIFont systemFontOfSize:16];
    label1.text = content;
    label1.textColor = [UIColor grayColor];
    label1.textAlignment = NSTextAlignmentCenter;
    CGSize size = [label1 sizeThatFits:CGSizeMake(INT_MAX, INT_MAX)];
    int max = MAX(size.width, size.height);
    label1.frame = CGRectMake(0.5, 0.5, max, max);
    UIView* v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, max + 1, max + 1)];
    v.layer.borderColor = UIColor.grayColor.CGColor;
    v.layer.borderWidth = 0.6;
    [v addSubview:label1];
    return v;
}



+ (UIView*)tempLable2:(NSString*)content{
    
    UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectZero];
    label1.font = [UIFont systemFontOfSize:12];
    label1.text = content;
    label1.textColor = UIColor.redColor;
    label1.textAlignment = NSTextAlignmentCenter;
    CGSize size = [label1 sizeThatFits:CGSizeMake(INT_MAX, INT_MAX)];
    UIEdgeInsets edge = UIEdgeInsetsMake(3, 3, 3, 3);
    label1.frame = CGRectMake(edge.left, edge.right, size.width, size.height);
    UIView* v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width + edge.left + edge.right,edge.top + edge.bottom + size.height)];
    v.backgroundColor = [UIColor colorWithRed:0xFF/255.0 green:0xEF/255.0 blue:0xFF/255.0 alpha:1.0];
    [v addSubview:label1];
    return v;
}

-(UIImage *)convertViewToImage:(UIView *)view{
    CGSize size = view.bounds.size;
    //下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
