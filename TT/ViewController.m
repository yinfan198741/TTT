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
#import "TT-Swift.h"
#import "CrashViewController.h"

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
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = UIColor.whiteColor;
    
//    int tabBarHeight = 66;
//
//    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, tabBarHeight, 100, 100)];
//    button.backgroundColor = UIColor.blueColor;
//    [button setTitle:@"fun Call" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//
//
//    UIButton* button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 100 + tabBarHeight, 100, 100)];
//    button2.backgroundColor = UIColor.blackColor;
//    [button2 setTitle:@"env" forState:UIControlStateNormal];
//    [button2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button2];
//
//    _la = [[UILabel alloc] initWithFrame:CGRectMake(0, 200 + tabBarHeight,
//                                                    100, 100)];
//    _la.text = @"lalala";
//    _la.backgroundColor = [UIColor yellowColor];
//    _la.textColor = [UIColor blueColor];
//    [self.view addSubview:_la];
//
//
//    UIButton* button3 = [[UIButton alloc]
//                         initWithFrame:CGRectMake(0, 300 + tabBarHeight,
//                                                  100,100)];
//    button3.backgroundColor = UIColor.blackColor;
//    [button3 setTitle:@"push" forState:UIControlStateNormal];
//    [button3 addTarget:self action:@selector(click3) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button3];
//
//
//    UIButton* button4 = [[UIButton alloc]
//                         initWithFrame:CGRectMake(0, 400 + tabBarHeight,
//                                                  100,100)];
//    button4.backgroundColor = UIColor.purpleColor;
//    [button4 setTitle:@"alert" forState:UIControlStateNormal];
//    [button4 addTarget:self action:@selector(click4) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button4];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return [self.source count];
//    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TabItem* item = (TabItem*)self.source[indexPath.row];
    item.itemActicon();
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
    [ocCall ObejctCall: self];
//    swiftVC* vc = [swiftVC ]
}


- (void)crashVC {
  NSLog(@"crashVC");
  CrashViewController* pvc = [[CrashViewController alloc] init];
  [self.navigationController pushViewController:pvc animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
