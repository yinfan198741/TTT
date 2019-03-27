//
//  ViewController.m
//  TT
//
//  Created by fanyin on 10/04/2017.
//  Copyright © 2017 fanyin. All rights reserved.
//

#import "ViewController.h"
#import "envTest.h"
#import "stdlib.h"
#import "Test.h"
#import "PushViewController.h"
#import "TabItem.h"
#import "TTS-Swift.h"
#import "CrashViewController.h"
#import "CallTest.h"
#import "ThreadViewController.h"
#import "LLDBViewController.h"
#import "AnimationViewController.h"
#import "HashViewController.h"
#import "dyLibHello.h"
#import "RACTester.h"
#import "ImageHeaderViewController.h"
#import "AppearanceViewController.h"
#import "NSObject+PPrint.h"
#import "AViewController.h"
#import "HookTableViewController.h"
#import "BundleViewController.h"


@interface ViewController ()

@property (nonatomic, strong) NSMutableArray* source;

@end

UILabel* _la;

@implementation ViewController


- (instancetype)init
{
  self = [super init];
  if (self) {
    self.source = [NSMutableArray arrayWithCapacity:10];
    [self setupSource];
  }
  return self;
}


-(void)setupSource {
  //    [TabItem CreateItem:@"function Call" itemSelect:^(){
  ////        [self click];
  //        NSLog(@"ttttt");
  //    }];
  
  TabItem* navigationTest = [TabItem CreateItem:@"navigationTest" action:^{
    [self navigationTest];
  }];
  [self.source addObject:navigationTest];
  
  TabItem* call = [TabItem CreateItem:@"call" action:^{
    [self click];
  }];
  
  [self.source addObject:call];
  
  TabItem* Eva = [TabItem CreateItem:@"Eva" action:^{
    [self click2];
  }];
  
  [self.source addObject:Eva];
  
  
  TabItem* UILable = [TabItem CreateItem:@"UILable" action:^{
    NSLog(@"UILable");
  }];
  [self.source addObject:UILable];
  
  TabItem* push = [TabItem CreateItem:@"push" action:^{
    [self click3];
  }];
  [self.source addObject:push];
  
  TabItem* alert = [TabItem CreateItem:@"alert" action:^{
    [self click4];
  }];
  [self.source addObject:alert];
  
  
  TabItem* alertVC = [TabItem CreateItem:@"alertVC" action:^{
    [self alertVC];
  }];
  [self.source addObject:alertVC];
  
  
  TabItem* swiftCall = [TabItem CreateItem:@"swiftCall" action:^{
    [self swiftCall];
  }];
  [self.source addObject:swiftCall];
  
  
  TabItem* crashVC = [TabItem CreateItem:@"crashVC" action:^{
    [self crashVC];
  }];
  [self.source addObject:crashVC];
  
  TabItem* callARMC = [TabItem CreateItem:@"callARMC" action:^{
    [self callARMC];
  }];
  [self.source addObject:callARMC];
  
  TabItem* callARMOC = [TabItem CreateItem:@"callARMOC" action:^{
    [self callARMOC];
  }];
  [self.source addObject:callARMOC];
  
  
  TabItem* threadTest = [TabItem CreateItem:@"threadTest" action:^{
    [self threadTest];
  }];
  [self.source addObject:threadTest];
  
  TabItem* lldbTest = [TabItem CreateItem:@"lldbTest" action:^{
    [self lldbTest];
  }];
  [self.source addObject:lldbTest];
  
  
  TabItem* AnimationTest = [TabItem CreateItem:@"AnimationTest" action:^{
    [self AnimationTest];
  }];
  [self.source addObject:AnimationTest];
  
  
  TabItem* Base64Sha1Md5 = [TabItem CreateItem:@"Base64Sha1Md5" action:^{
    [self Base64Sha1Md5];
  }];
  [self.source addObject:Base64Sha1Md5];
  
  
  TabItem* dylibCall = [TabItem CreateItem:@"dylibCall" action:^{
    [self dylibCall];
  }];
  [self.source addObject:dylibCall];
  
  TabItem* RacCall = [TabItem CreateItem:@"RacCall" action:^{
    [self RacCall];
  }];
  [self.source addObject:RacCall];
  
  
  TabItem* imageHeader = [TabItem CreateItem:@"imageHeader" action:^{
    [self imageHeader];
  }];
  [self.source addObject:imageHeader];
  
  TabItem* imageHeaderSwift = [TabItem CreateItem:@"imageHeaderSwift" action:^{
    [self imageHeaderSwift];
  }];
  [self.source addObject:imageHeaderSwift];
  
  
    TabItem* AppearanceViewController = [TabItem            CreateItem:@"AppearanceViewController" action:^{
        [self AppearanceViewController];
    }];
    [self.source addObject:AppearanceViewController];

  
    TabItem* hookTest = [TabItem CreateItem:@"hookTest" action:^{
        [self hookTest];
    }];
    [self.source addObject:hookTest];
    
    TabItem* BundleTest = [TabItem CreateItem:@"BundleTest" action:^{
        [self BundleTest];
    }];
    [self.source addObject:BundleTest];
    
    
    TabItem* StoryBoardTest = [TabItem CreateItem:@"StoryBoardTest" action:^{
        [self StoryBoardTest];
    }];
    [self.source addObject:StoryBoardTest];
  
}


- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = UIColor.whiteColor;
  self.title = @"Test";
//  [UINavigationItemButtonView getpriority(<#int#>, <#id_t#>)]
  
//  [NSObject getProperties:[UINavigationItemButtonView Class]];
}

-(void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.source count];
  //    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  TabItem* item = (TabItem*)self.source[indexPath.row];
  item.itemActicon();
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell* cell = [[UITableViewCell alloc] init];
  TabItem* item = (TabItem*)self.source[indexPath.row];
  if (item != nil) {
    cell.textLabel.text = item.title;
  }
  cell.textLabel.textColor = UIColor.blackColor;
  return cell;
}

- (void)navigationTest {
  NSLog(@"navigationTest");
//  int va = fooFunction();
//  _la.text = [NSString stringWithFormat:@"%d",va];
//  AViewController* ac = [[AViewController alloc] init];
//  UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:ac];

  [self presentViewController:[AViewController createNavigationControler]
                     animated:true completion:nil];
}

- (void)click {
  NSLog(@"click123");
  int va = fooFunction();
  _la.text = [NSString stringWithFormat:@"%d",va];
}


- (void)click2 {
  NSLog(@"click2");
  getEvnTest();
  char* env = getenv("HOME");
  printf("env = %s",env);
}

- (void)click3 {
  NSLog(@"click3");
  
  //    for (int i = 0 ; i < 5; i++)
  {
    PushViewController* pvc = [[PushViewController alloc] init];
    [self.navigationController pushViewController:pvc animated:YES];
  }
}

- (void)click4 {
  NSLog(@"click4");
  
  UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"title1" message:@"message1" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
  [alert1 show];
  
  NSLog(@"alert1.window = %@   alert1.window.windowLevel = %f",alert1.window,alert1.window.windowLevel);
  NSLog(@"windows == %@",[UIApplication sharedApplication].windows);
  
  
  UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"title2" message:@"message2" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
  [alert2 show];
  
  NSLog(@"alert2.window = %@   alert2.window.windowLevel = %f",alert2.window,alert2.window.windowLevel);
}

-(void)alertVC {
  
  UIAlertController * uac = [UIAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction* ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    NSLog(@"aaaa");
  }];
  
  [uac addAction:ac];
  [self presentViewController:uac animated:YES completion:nil];
}

-(void)swiftCall {
  //    ObejctCall();
  //    [ocCall ObejctCall: self];
  //  [ocCall ObejctCall:self];
  //    swiftVC* vc = [swiftVC ]
  MyTabviewVC* vc = [[MyTabviewVC alloc] init];
  [self.navigationController pushViewController:vc animated:YES];
  
  //  [ocCall ObejctCall:self];
  //  ocCall* call = [[ocCall alloc] init];
  //  [call o]
  
}


- (void)crashVC {
  NSLog(@"crashVC");
  CrashViewController* pvc = [[CrashViewController alloc] init];
  [self.navigationController pushViewController:pvc animated:YES];
  
}

- (void)callARMC {
  NSLog(@"callARMC");
  int res = fooFunction();
  NSLog(@"info = %d",res);
}


- (void)callARMOC {
  NSLog(@"callARM");
  CallTest* test = [[CallTest alloc] init];
  int age = [test getAge:1];
  NSString* name = [test getName:@"YINFAN"];
  NSString* info = [test getInfo:name age:age];
  NSLog(@"info = %@",info);
}


- (void)threadTest {
  NSLog(@"threadTest");
  ThreadViewController* threadVC = [[ThreadViewController alloc] init];
  [self.navigationController pushViewController:threadVC animated:true];
}

- (void)lldbTest {
  NSLog(@"lldbTest");
  LLDBViewController* lldb = [[LLDBViewController alloc] init];
  [self.navigationController pushViewController:lldb animated:true];
}


- (void)AnimationTest {
  NSLog(@"AnimationTest");
  AnimationViewController* animation = [[AnimationViewController alloc] init];
  [self.navigationController pushViewController:animation animated:true];
}

- (void)Base64Sha1Md5 {
  NSLog(@"Base64Sha1Md5");
  HashViewController* hash = [[HashViewController alloc] init];
  [self.navigationController pushViewController:hash animated:true];
}

-(void)dylibCall {
  NSLog(@"dylibCall");
//  char* name = getDylibName();
//  NSLog(@"name = %s",name);
}

-(void)RacCall {
  NSLog(@"RacCall");
//  #import "RACTester.h"
  RACTester * tester = [[RACTester alloc] init];
  [tester Test];
//  NSLog(@"RacCall = %s",name);
}


-(void)imageHeader {
  NSLog(@"imageHeader");

  ImageHeaderViewController * vc = [[ImageHeaderViewController alloc] init];
  UINavigationController* uicon = [[UINavigationController alloc] initWithRootViewController:vc];
  [self presentViewController:uicon animated:YES completion:nil];
}

-(void)imageHeaderSwift {
//  ImageViewVC* vc = ImageViewVC
//  ImageViewVC * vc = [[ImageViewVC alloc] init];
//  UINavigationController* uicon = [[UINavigationController alloc] initWithRootViewController:vc];
//  [self presentViewController:uicon animated:YES completion:nil];
}

-(void)AppearanceViewController {
  NSLog(@"AppearanceViewController");
  AppearanceViewController * vc = [[AppearanceViewController alloc] init];
  [self presentViewController:vc animated:YES completion:nil];
  
}


- (void)hookTest {
  NSLog(@"hookTest");
  HookTableViewController * vc = [[HookTableViewController alloc] init];
  UINavigationController* nv = [[UINavigationController alloc] initWithRootViewController:vc];
 [self presentViewController:nv animated:YES completion:nil];
}

- (void)BundleTest {
    BundleViewController* vc = [[BundleViewController alloc] init];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)StoryBoardTest {
    NSLog(@"StoryBoardTest");
    
    UIViewController* tabVC = [[UIStoryboard storyboardWithName:@"Storyboard"
                                                         bundle:nil]
             instantiateViewControllerWithIdentifier:@"SBTAB"];
    
    [self presentViewController:tabVC animated:YES completion:nil];
//    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:tabVC];
//    [self presentViewController:nav animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end

