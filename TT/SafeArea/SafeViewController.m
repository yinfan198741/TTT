//
//  SafeViewController.m
//  TT
//
//  Created by 尹凡 on 2019/10/24.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "SafeViewController.h"
#import "View+MASAdditions.h"

#define kDefaultTopViewHeight 44

@interface SafeViewController ()

@end

@implementation SafeViewController


static inline UIEdgeInsets sgm_safeAreaInset(UIView *view) {
    if (@available(iOS 11.0, *)) {
        return view.safeAreaInsets;
    }
    return UIEdgeInsetsZero;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        UILayoutGuide* gudide = self.view.safeAreaLayoutGuide;
    } else {
        // Fallback on earlier versions
    }
    UIEdgeInsets edge = self.additionalSafeAreaInsets;
    
    UIEdgeInsets a = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        a = self.view.safeAreaInsets;
    }
    
    CGFloat height = kDefaultTopViewHeight; // 导航栏原本的高度，通常是44.0
    UIEdgeInsets safeAreaInsets = sgm_safeAreaInset(self.view);
    height += safeAreaInsets.top > 0 ? safeAreaInsets.top : 20.0; // 20.0是statusbar的高度
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    NSInteger statusBar = UIApplication.sharedApplication.statusBarFrame.size.height;
    
    UITextView * f = [[UITextView alloc] init];
    f.translatesAutoresizingMaskIntoConstraints = NO;
    f.backgroundColor = UIColor.yellowColor;
    f.layer.borderColor = UIColor.redColor.CGColor;
    f.layer.borderWidth = 1;
    [self.view addSubview:f];
    
   
    [f mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(statusBar);
        make.height.mas_equalTo(100);
    }];
}

- (void)test:(NSInteger)height {
    
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
