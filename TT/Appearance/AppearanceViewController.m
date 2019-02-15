//
//  AppearanceViewController.m
//  TT
//
//  Created by 尹凡 on 1/22/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

//https://hyancat.com/posts/2016/04/13/UIAppearance/
#import "AppearanceViewController.h"


@interface CardView : UIView
@property (nonatomic, strong) UIView* headerView;
@property (nonatomic, strong) UIView* bodyView;
@property (nonatomic, strong) UIColor *headerColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *bodyColor UI_APPEARANCE_SELECTOR;
@end

@implementation CardView

//- (instancetype)init {
//  self = [super init];
//  self.headerView = [[UIView alloc] init];
//  self.bodyView = [[UIView alloc] init];
//  [self addSubview:_headerView];
//  [self addSubview:_bodyView];
//}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.headerView = [[UIView alloc] init];
    self.bodyView = [[UIView alloc] init];
    [self addSubview:_headerView];
    [self addSubview:_bodyView];
  }
  return self;
}


- (void)setHeaderColor:(UIColor *)headerColor
{
  _headerColor = headerColor;
  self.headerView.backgroundColor = _headerColor;
}

- (void)setBodyColor:(UIColor *)bodyColor
{
  _bodyColor = bodyColor;
  self.bodyView.backgroundColor = _bodyColor;
}

@end

@interface AppearanceViewController ()

@end

@implementation AppearanceViewController





- (void)createButtonTouched {
  CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(20, 100, 80, 120)];
  [self.view addSubview:cardView];
  cardView.headerColor = [UIColor greenColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  self.view.backgroundColor = UIColor.whiteColor;
  
  UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 20, 20)];
  [button setTitle:@"选图" forState:UIControlStateNormal];
  [button setBackgroundColor:UIColor.redColor];
  [button addTarget:self action:@selector(createButtonTouched) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
    // Do any additional setup after loading the view.
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
