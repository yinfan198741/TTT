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
#import "MJUser.h"
#import "RACTestViewController.h"
#import "MJViewController.h"
#import "BasicTestViewController.h"
#import "NumberTestViewController.h"
#import "LableTestViewController.h"
#import "SafeViewController.h"
#import "captureManager.h"
#import "KVOTestVC.h"
#import "StudentA.h"
#import "PersonA.h"
#import "MMKV.h"
#include "ll.hpp"



@interface ViewController ()

@property (nonatomic, strong) NSMutableArray* source;

@property (nonatomic, strong) NSMutableArray* info;//= [[NSMutableArray alloc] initWithCapacity:100];

@property (nonatomic, strong) NSMutableString* logI;

@property (nonatomic, strong) dispatch_source_t timer;


@property (nonatomic, strong) dispatch_source_t writeTimer;


@property (nonatomic, strong) NSString* morethreadString;


@property (nonatomic, copy) NSArray* morethreadArray;


@end

UILabel* _la;

@implementation ViewController


- (instancetype)init
{
  self = [super init];
  if (self) {
    
  }
  return self;
}


- (void)initSource
{
    self.source = [NSMutableArray arrayWithCapacity:10];
     self.info = [[NSMutableArray alloc] initWithCapacity:100];
    [self setupSource];
      self.logI = [[NSMutableString alloc]init];
}

-(void)setupSource {
    //    [TabItem CreateItem:@"function Call" itemSelect:^(){
    ////        [self click];
    //        NSLog(@"ttttt");
    //    }];
	
	
	TabItem* SwiftTest = [TabItem CreateItem:@"SwiftTest" action:^{
		[self SwiftTest123];
	}];
	[self.source addObject:SwiftTest];
	
	TabItem* RacCall = [TabItem CreateItem:@"RacCall" action:^{
		[self RacCall];
	}];
	[self.source addObject:RacCall];
	


	
	TabItem* NSNumericSearch = [TabItem CreateItem:@"NSNumericSearch" action:^{
        [self NSNumericSearch];
    }];
    [self.source addObject:NSNumericSearch];
    
	TabItem* hookTest = [TabItem CreateItem:@"hookTest" action:^{
		[self hookTest];
	}];
	[self.source addObject:hookTest];
	
	
    
    TabItem* morethread = [TabItem CreateItem:@"morethread" action:^{
        [self morethread];
    }];
    [self.source addObject:morethread];
    
    
    TabItem* sendEmail = [TabItem CreateItem:@"sendEmail" action:^{
        [self sendEmail];
    }];
    [self.source addObject:sendEmail];
    
    
	
	TabItem* kvoTest = [TabItem CreateItem:@"kvoTest" action:^{
		[self kvoTest];
	}];
	[self.source addObject:kvoTest];
	
    
    TabItem* navigationTest = [TabItem CreateItem:@"navigationTest" action:^{
        [self navigationTest];
    }];
    [self.source addObject:navigationTest];
    
    TabItem* call = [TabItem CreateItem:@"call" action:^{
        [self click];
    }];
    
    [self.source addObject:call];
    
    
    TabItem* basicTest = [TabItem CreateItem:@"basicTest" action:^{
        [self basicTest];
    }];
    [self.source addObject:basicTest];
    
    
    TabItem* Eva = [TabItem CreateItem:@"Eva" action:^{
        [self click2];
    }];
    
    [self.source addObject:Eva];
    
    
    TabItem* UILable = [TabItem CreateItem:@"UILable" action:^{
        NSLog(@"UILable");
        [self UILableTest];
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
    
    
    
    TabItem* imageHeader = [TabItem CreateItem:@"imageHeader" action:^{
        [self imageHeader];
    }];
    [self.source addObject:imageHeader];
    
    TabItem* imageHeaderSwift = [TabItem CreateItem:@"imageHeaderSwift" action:^{
        [self imageHeaderSwift];
    }];
    [self.source addObject:imageHeaderSwift];
    
    
    TabItem* AppearanceViewController = [TabItem CreateItem:@"AppearanceViewController" action:^{
        [self AppearanceViewController];
    }];
    [self.source addObject:AppearanceViewController];

    
    TabItem* BundleTest = [TabItem CreateItem:@"BundleTest" action:^{
        [self BundleTest];
    }];
    [self.source addObject:BundleTest];
    
    
    TabItem* StoryBoardTest = [TabItem CreateItem:@"StoryBoardTest" action:^{
        [self StoryBoardTest];
    }];
    [self.source addObject:StoryBoardTest];
    
    
    TabItem* MJTest = [TabItem CreateItem:@"MJTest" action:^{
        [self MJTest];
    }];
    [self.source addObject:MJTest];
    
    
    TabItem* numberTest = [TabItem CreateItem:@"numberTest" action:^{
        [self numberTest];
    }];
    [self.source addObject:numberTest];
    
    
    TabItem* safeTest = [TabItem CreateItem:@"SafeViewController" action:^{
        [self safeTest];
    }];
    [self.source addObject:safeTest];
	
	
	TabItem* inherite = [TabItem CreateItem:@"inherite" action:^{
		[self inherite];
	}];
	[self.source addObject:inherite];
	
	
	TabItem* logText = [TabItem CreateItem:@"logText" action:^{
		[self logText];
	}];
	[self.source addObject:logText];
	
}



- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = UIColor.whiteColor;
  self.title = @"Test";
    
    
    [self initSource];
//    [[UIApplication.sharedApplication windows]
    
//    [self addControlbutton];
    
//  [UINavigationItemButtonView getpriority(<#int#>, <#id_t#>)]
  
//  [NSObject getProperties:[UINavigationItemButtonView Class]];
}


- (void)addControlbutton
{
//    UIButton* b  = [[UIButton alloc] init:CGRectMake(100, 100, 20, 20)];
    UIButton* b = [self TestButton];
    [self.view addSubview:b];
    
    UIButton* sb = [self ScrollButton];
    [self.view addSubview:sb];
    
}

- (UIButton*)TestButton
{
    UIButton* changeButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 50, 50, 50)];
    changeButton.backgroundColor = UIColor.redColor;
    [changeButton setTitle:@"Test" forState:UIControlStateNormal];
    [changeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changeButton setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
    [changeButton addTarget:self action:@selector(Test) forControlEvents:UIControlEventTouchUpInside];
    return changeButton;
}



- (UIButton*)ScrollButton
{
    UIButton* changeButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 110, 50, 50)];
    changeButton.backgroundColor = UIColor.redColor;
    [changeButton setTitle:@"ScrollButton" forState:UIControlStateNormal];
    [changeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changeButton setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
    [changeButton addTarget:self action:@selector(Scroll) forControlEvents:UIControlEventTouchUpInside];
    return changeButton;
}

- (void)Test
{
    NSLog(@"Test");
    NSIndexPath * path = [NSIndexPath indexPathForRow:7 inSection:0];
    [self.tableView performSelector:@selector(_userSelectRowAtPendingSelectionIndexPath:) withObject:path];
}


- (void)Scroll
{
    CGPoint po = self.tableView.contentOffset;
    po.y += 300;
    [self.tableView setContentOffset:po animated:NO];
}

-(void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
//	UIWindow *currentKeyWindow = [UIApplication sharedApplication].keyWindow;
//	[[captureManager shareSingleObjc] setupWindow];
//	[currentKeyWindow makeKeyWindow];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.source count];
  //    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  TabItem* item = (TabItem*)self.source[indexPath.row];
  item.itemActicon();
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    [UIApplication.sharedApplication.keyWindow]
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


- (void)NSNumericSearch
{
//	NSString *num1 = @"5.2.-1";
//	NSString *num2 = @"5.2";
//
//	NSComparisonResult res = [num1 compare:num2 options:NSNumericSearch];
//
//	if ([num1 compare:num2 options:NSNumericSearch] == NSOrderedDescending)
//		{
//		NSLog(@"%@ is bigger",num1);
//		}else
//			{
//			NSLog(@"%@ is bigger",num2);
//			}
	
	
	NSLog(@"123");
	
//	deepTree();
	return;
	
	int a[] = { 4 , 6 ,8 , 5 , 9 };
	
//	for (int *i  in &a) {
//		printf(@"%ld",*i);
//	}
	int*  p = a;
	for (int i = 0; i < sizeof(a)/sizeof(int); i++) {
		printf("%d ",*(a+i));
	}
	
	int s =  sizeof(a)/sizeof(int);
	
	for (int i = s/2 + 1 ; i >= 0; i--) {
		maked(a, 0, i);
	}
	
	printf("======\n");
	
	for (int i = 0; i < s; i++) {
		printf("%d ",p[0]);
	}
}

void mswap(int* a , int s , int t)
{
	int temp = *(a + s);
	*(a+s) = t;
	*(a+t) = temp;
}


void maked(int *a , int s, int idx)
{
	int temp = *(a + idx);
	//	for (int i = s/2 + 1 ; i >= 0; i--) {
	int lidx = (idx*2 + 1);
	int ridx = (idx*2 + 2);
	
	if (lidx) {
		
	}
	
	int left = *(a + lidx);
	int right = *(a + ridx);
	
	if (temp < MAX(left, right)) {
		if (left > right) {
			mswap(a, lidx, idx);
		}
		else {
			mswap(a, ridx, idx);
		}
	}
	//	}
}

//- (void)maked:(int*)a size:(int)s setI:(int)idx
//{
//	int temp = *(a + idx);
////	for (int i = s/2 + 1 ; i >= 0; i--) {
//		int lidx = (idx*2 + 1);
//		int ridx = (idx*2 + 2);
//		int left = *(a + lidx);
//		int right = *(a + ridx);
//
//		if (temp < MAX(left, right)) {
//			if (left > right) {
//				mswap(a, lidx, idx);
//			}
//			else {
//				mswap(a, ridx, idx);
//			}
//		}
////	}
//}


- (void)morethread
{
//    NSLog(@"morethread start");
//    int times = 1000;
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        for (int i = 0; i < times ; i++) {
//               dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                   self.morethreadString = [NSString stringWithFormat:@"%d",i];
//                   self.morethreadArray = @[@"test"];
//               });
//           }
//    });
//
//     dispatch_async(dispatch_get_global_queue(0, 0), ^{
//    for (int i = 0; i < times ; i++) {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            NSString* t = self.morethreadString;
//            NSArray* array =  self.morethreadArray;
//            NSLog(@"%@",t);
//            NSLog(@"%@",array);
//        });
//    }
//     });
//     NSLog(@"morethread end");
    
    
    
    NSProcessInfo* info = [NSProcessInfo processInfo];
    
    
    __block int* a = malloc(sizeof(int) * 1000);// [1000];
    NSMutableArray *originArray = [NSMutableArray arrayWithCapacity:1000000];
    for (int i = 0 ; i < 1000; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSString* obj = [NSString stringWithFormat:@"item%ld", i];
            NSInteger count = [originArray count];
//            NSLog(@"count = %d",count);
            [originArray addObject:obj];
//            a[i] = i;
                        
        });
    }
    
  
}

- (void)sendEmail
{
    NSLog(@"123");
    NSString * name = @"YF";
    NSString* reason = @"reason";
    NSString* arr = @"arr";
    
    
    
    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"a" ofType:@"txt"];
    NSData *imageData2 = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:filePath2]];
    
    NSString* newStr = [[NSString alloc] initWithData:imageData2 encoding:NSUTF8StringEncoding];
    NSString *crashLogInfo = newStr;// [NSString stringWithFormat:@"exception type : %@ \n crash reason : %@ \n call stack info : %@", name, reason, arr];
    NSString *urlStr = [NSString stringWithFormat:@"mailto:594317569@qq.com?subject=bug报告&body=感谢您的配合!错误详情:%@",crashLogInfo];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
    
    
//    NSDictionary *dic1 = @{
//                           @"command":@"1020",
//                           @"result" :@"1",
//                           @"returnFromApp":@"0",
//                           @"scene":@"0",
//                           @"sdkver":@"1.5",
//                           @"title":@"不接微信的sdk成功进行微信分享了"
//                           };
//    NSDictionary *diction = @{@"wx63e70d351f028e3c":dic1};
//    NSData *output1=[NSPropertyListSerialization dataWithPropertyList:diction format:NSPropertyListBinaryFormat_v1_0 options:0 error:nil];
//    [[UIPasteboard generalPasteboard] setData:output1 forPasteboardType:@"content"];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://app/wx63e70d351f028e3c/sendreq/?"]];
    
}

- (void)kvoTest
{
	KVOTestVC* vc = [[KVOTestVC alloc] init];
	[self.navigationController pushViewController:vc animated:YES];
}

- (void)navigationTest {
  NSLog(@"navigationTest");
//  int va = fooFunction();
//  _la.text = [NSString stringWithFormat:@"%d",va];
//  AViewController* ac = [[AViewController alloc] init];
//  UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:ac];
//    self = nil;
   __weak __typeof__(self) weakSelf = self;
    
  [self presentViewController:[AViewController createNavigationControler]
                     animated:true completion:^{
      
      typeof(self);
//     __strong ViewController* self = weakSelf;
//      self = nil;
//      [self kvoTest];
      
  }];
}

- (void)click {
  NSLog(@"click123");
  int va = fooFunction();
  _la.text = [NSString stringWithFormat:@"%d",va];
}

- (void)basicTest {
    NSLog(@"basicTest");
    BasicTestViewController* pvc = [[BasicTestViewController alloc] init];
    [self.navigationController pushViewController:pvc animated:YES];
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
//	alert1.window.windowLevel = 1000;
  [alert1 show];
//
  NSLog(@"alert1.window = %@   alert1.window.windowLevel = %f",alert1.window,alert1.window.windowLevel);
//  NSLog(@"windows == %@",[UIApplication sharedApplication].windows);
//
//
//  UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"title2" message:@"message2" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//  [alert2 show];
//
//  NSLog(@"alert2.window = %@   alert2.window.windowLevel = %f",alert2.window,alert2.window.windowLevel);
}

-(void)alertVC {
  
  UIAlertController * uac = [UIAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction* ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    NSLog(@"aaaa");
	  
	  
	  UIAlertController * uacb = [UIAlertController alertControllerWithTitle:@"title1" message:@"message1" preferredStyle:UIAlertControllerStyleAlert];
	  UIAlertAction* acb = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
		  
	  }];
	  
	  [uacb addAction:acb];
	  
	  [uac presentViewController:uacb animated:YES completion:nil];
	  
  }];
  
  [uac addAction:ac];
  [self presentViewController:uac animated:YES completion:nil];
}


- (void)UILableTest{
    
    LableTestViewController* vc = [[LableTestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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


-(void)SwiftTest123 {
	NSLog(@"SwiftTest");
	//  char* name = getDylibName();
	//  NSLog(@"name = %s",name);
	
	//	var arrT = [1,2,3];
	//	arrT.accu
	
	//	[let advaceSwfit:] = AdavaceSwift();
	//	advaceSwfit.
	
	//	var advaceSwfit = myAdavaceSwift1();
	//	var a = myAdavaceSwift1();
	//	var ad = myAdavaceSwift();
	
	swiftVC* vc = [[swiftVC alloc] init];
	[self.navigationController pushViewController:vc animated:YES];

}


-(void)dylibCall {
  NSLog(@"dylibCall");
//  char* name = getDylibName();
//  NSLog(@"name = %s",name);
}

-(void)RacCall {
  NSLog(@"RacCall");
//  #import "RACTester.h"
//  RACTester * tester = [[RACTester alloc] init];
//  [tester Test];
//  NSLog(@"RacCall = %s",name);
    
    RACTestViewController * vc = [[RACTestViewController alloc] init];
//     UINavigationController* uicon = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController pushViewController:vc animated:YES];
   
//    [self presentViewController:uicon animated:YES completion:nil];
//    [uicon pushViewController:vc animated:YES];
    
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

- (void)MJTest {
    NSLog(@"MJTest");
	
	
//	MJViewController* vc = [[MJViewController alloc] init];
//	UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
//	[self presentViewController:nav animated:YES completion:nil];
	
	
	MJViewController* animation = [[MJViewController alloc] init];
	[self.navigationController pushViewController:animation animated:true];
    
}


- (void)numberTest {
    NSLog(@"numberTest");
    NumberTestViewController* animation = [[NumberTestViewController alloc] init];
    [self.navigationController pushViewController:animation animated:true];
    
}


- (void)safeTest
{
    SafeViewController* sa = [[SafeViewController alloc] init];
    [self.navigationController presentViewController:sa animated:YES completion:nil];
}

- (void)inherite
{
//	NSLog(@"inherite");
	StudentA* stA = [[StudentA alloc] init];
	stA.name = @"name";
	stA.age = 10;
	stA.schoolName = @"pixian middel school";
    
    [stA callName];
//    [stA s]
	
	[stA callTT];
//	NSLog(@"stA %@",stA);
//	NSLog(@"stA.good.goodName %@",stA.good.goodName);
//	stA.good.goodName = @"new good name";
//	NSLog(@"stA.good.goodName %@",stA.good.goodName);
}


- (void)logText
{
	NSLog(@"logText");

//	[self createTimer];
    
    
//    PersonA * pp  = [[PersonA alloc] init];
//    [pp abc:10];
	
//	NSMutableString* a = [[NSMutableString alloc] initWithCapacity:10];
//	[a appendString:@"123"];
//	[a appendString:@"456"];
//	NSLog(@"%@",a);
	
	
//		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//[						NSString* tlog = [NSString stringWithFormat:@"%@",[NSDate date]] ;
//						[self writeLog:tlog];
//					});
	
//
//		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//							NSString* tlog = [NSString stringWithFormat:@"%@",[NSDate date]] ;
//						[self writeLog:tlog];
//			writeFileCount++;
//			if (writeFileCount < 10)
//			{
//				goto writeFILE;
//
//	}
	
    int abc = 0x12345;
    char* data = "大强🧱";
    int bcd = 0x54321;
    NSString* a = [NSString stringWithCString:data encoding:NSUTF8StringEncoding];
    NSInteger length = a.length;
    NSLog(@"length = %ld", length);
    NSData* dd = [a dataUsingEncoding:NSUTF8StringEncoding];
    NSData* dd2 = [a dataUsingEncoding:NSUTF16StringEncoding];
    NSLog(@"123");
    
    
    
//    MMKV *mmkv = [MMKV defaultMMKV];
//        
//    [mmkv setBool:YES forKey:@"bool"];
//    BOOL bValue = [mmkv getBoolForKey:@"bool"];
//        
//    [mmkv setInt32:-1024 forKey:@"int32"];
//    int32_t iValue = [mmkv getInt32ForKey:@"int32"];
//        
//    [mmkv setString:@"hello, mmkv" forKey:@"string"];
//    NSString *str = [mmkv getStringForKey:@"string"];
    
}


- (void)createTimer
{
	
	__block	int count = 0;
	
	// 获得队列
	
	dispatch_queue_t queue = dispatch_get_main_queue();
	
	// 创建一个定时器(dispatch_source_t本质还是个OC对象)
	
	self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
	
	// 设置定时器的各种属性（几时开始任务，每隔多长时间执行一次）
	
	// GCD的时间参数，一般是纳秒（1秒 == 10的9次方纳秒）
	
	// 何时开始执行第一个任务
	
	// dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC) 比当前时间晚3秒
	
	dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
	
	uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);
	
	dispatch_source_set_timer(self.timer, start, interval, 0);
	
	// 设置回调
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"ss"];
	
	dispatch_source_set_event_handler(self.timer, ^{
		
		NSDate *dateNow = [NSDate date];
		NSString *currentTime = [formatter stringFromDate:dateNow];

		
		count++;
		if (count == 4) {

			// 取消定时器

			dispatch_cancel(self.timer);

			self.timer = nil;

		}
		
	});
	
	// 启动定时器
	
	dispatch_resume(self.timer);
	
}


- (void)writeLog:(NSString*)log
{
	
//	[self.info addObject:log];
//	[self.logI stringByAppendingString:@"\n"];
//	[self.logI stringByAppendingString:log];
	NSLog(@"log = %@",log);
	
	
	
	[self.logI appendString:[NSString stringWithFormat:@"%@",log]];
	
	[self.logI appendString:@"\r"];
	
	NSLog(@"logI = %@",self.logI);
}


- (void)writeTofile
{
	
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end

