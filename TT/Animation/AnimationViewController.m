//
//  AnimationViewController.m
//  TT
//
//  Created by 尹凡 on 11/21/18.
//  Copyright © 2018 fanyin. All rights reserved.
//

#import "AnimationViewController.h"



@interface DRInspectionLayer : CALayer
@end

@implementation DRInspectionLayer
- (void)addAnimation:(CAAnimation *)anim forKey:(NSString *)key
{
  NSLog(@"adding animation: %@", [anim debugDescription]);
  [super addAnimation:anim forKey:key];
}
@end


@interface DRInspectionView : UIView
@end

@implementation DRInspectionView
+ (Class)layerClass
{
  return [DRInspectionLayer class];
}
@end


@interface AnimationViewController ()

@property(nonatomic, strong) UIView * layerTest;

@property(nonatomic, strong) CALayer * layer;

@property(nonatomic, strong) CALayer * layer2;

@property(nonatomic, strong) CALayer * layer3;

@property(nonatomic, strong) UIView * uiview4;
@end

@implementation AnimationViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Animation";
  self.view.backgroundColor = UIColor.whiteColor;
  UIButton* change = [self ChangLayerButton];
  [self.view addSubview:change];
  
  UIButton* LayerAni = [self LayerAniButton];
  [self.view addSubview:LayerAni];
  
  self.layerTest = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 50, 50)];
  self.layerTest.backgroundColor = UIColor.redColor;
  [self.view addSubview:_layerTest];
  
  self.layer = [[DRInspectionLayer alloc] init];
  self.layer.frame = CGRectMake(300, 100, 50, 50);
  self.layer.backgroundColor = UIColor.redColor.CGColor;
  [self.view.layer addSublayer:self.layer];
  
  
  self.layer2 = [[CALayer alloc] init];
  self.layer2.frame = CGRectMake(300, 200, 50, 50);
  self.layer2.backgroundColor = UIColor.redColor.CGColor;
  [self.view.layer addSublayer:self.layer2];
  
  
  
  self.layer3 = [[CALayer alloc] init];
  self.layer3.frame = CGRectMake(300, 300, 50, 50);
  self.layer3.backgroundColor = UIColor.redColor.CGColor;
  [self.view.layer addSublayer:self.layer3];
  
  
  self.uiview4 = [[DRInspectionView alloc] init];
  self.uiview4.frame = CGRectMake(300, 400, 50, 50);
  self.uiview4.backgroundColor = UIColor.redColor;
  [self.view addSubview:self.uiview4];
//  [self.view addSubview:self.layer];
//  [self.view ]
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (UIButton*)ChangLayerButton
{
  UIButton* changeButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
  changeButton.backgroundColor = UIColor.blueColor;
  [changeButton setTitle:@"变色" forState:UIControlStateNormal];
    [changeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changeButton setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
  [changeButton addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
  return changeButton;
}


- (UIButton*)LayerAniButton
{
  UIButton* changeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 50, 100)];
  changeButton.backgroundColor = UIColor.blueColor;
  [changeButton setTitle:@"LayerAni" forState:UIControlStateNormal];
  [changeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [changeButton setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
  [changeButton addTarget:self action:@selector(layerFade) forControlEvents:UIControlEventTouchUpInside];
  return changeButton;
}


static bool i = true;

- (void)layerAction {
  
  // layer actions is not null implicate animation

  //  id layerBg = [self.layer actionForLayer:self.layer forKey:@"backgroundColor"];
  id layerBg = [self.layer actionForKey:@"backgroundColor"];
  //view actions is null remove implicate animation
  id layerBg2 = [self.uiview4 actionForLayer:self.uiview4.layer forKey:@"backgroundColor"];
  
  NSLog(@"layerBg = %@",layerBg);
  NSLog(@"layerBg2 = %@",layerBg2);
//  layerBg2self.uiview4
  NSLog(@"outside animation block: %@",
        [self.uiview4 actionForLayer:self.uiview4.layer forKey:@"position"]);
  
  [UIView animateWithDuration:0.3 animations:^{
    NSLog(@"inside animation block: %@",
          [self.uiview4 actionForLayer:self.uiview4.layer forKey:@"position"]);
  }];
}


- (void)change {

//  [self.layer actionForLayer:self.layer forKey:@"backgroundColor"]);
  
  
  
  if (i) {
    self.layerTest.layer.backgroundColor = UIColor.redColor.CGColor;
    self.layer.backgroundColor = UIColor.redColor.CGColor;
    self.layer2.frame = CGRectMake(300, 300, 20, 20);
    
    [UIView animateWithDuration:1 animations:^{
      self.uiview4.bounds = CGRectMake(0, 0, 100, 100);
    }];
  }
  else {
    self.layerTest.layer.backgroundColor = UIColor.purpleColor.CGColor;
    self.layer.backgroundColor = UIColor.purpleColor.CGColor;
    self.layer2.frame = CGRectMake(300, 400, 200, 200);
    
    [UIView animateWithDuration:1 animations:^{
      self.uiview4.bounds = CGRectMake(0, 0, 10, 10);
    }];
  }
  i = !i;
  [self disableCalayerAnimation];
}

///没有动画
-(void)disableCalayerAnimation {
  [CATransaction begin];
  [CATransaction setDisableActions:YES];
  if (i) {
    self.layer3.position = CGPointMake(50, 50);
  }
  else {
    self.layer3.position = CGPointMake(50, 150);
  }
  [CATransaction commit];
}

-(void)layerFade {
  [self fadeInCoreAnimation];
}

-(void)fadeInCoreAnimation {
  CABasicAnimation *fadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
  fadeIn.duration  = 0.75;
  fadeIn.fromValue = @0;
  
  self.layer.opacity = 1.0; // 更改 model 的值 ...
  // ... 然后添加动画对象
  [self.layer addAnimation:fadeIn forKey:nil];
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

