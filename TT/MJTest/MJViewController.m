//
//  MJViewController.m
//  TT
//
//  Created by fanyin on 2019/9/24.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "MJViewController.h"
#import "MJUser.h"
#import "aaA.h"

@interface MJViewController ()

@end

@implementation MJViewController

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = UIColor.whiteColor;
	// Do any additional setup after loading the view.
	
	UIButton* t = [self TestButton];
	[self.view addSubview:t];
	
	UIButton* copy = [self copyTestButton];
	[self.view addSubview:copy];
	
    
    UIButton* serize = [self serize];
    [self.view addSubview:serize];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    UIPresentationController *presentationController = self.presentationController;
//    if (presentationController.presentingViewController) {
//        NSLog(@"%@", presentationController.presentingViewController);
//    }
//    if (presentationController.presentedViewController) {
//        NSLog(@"%@", presentationController.presentedViewController);
//    }
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

- (UIButton*)copyTestButton
{
	UIButton* changeButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 120, 50, 50)];
	changeButton.backgroundColor = UIColor.redColor;
	[changeButton setTitle:@"copy" forState:UIControlStateNormal];
	[changeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[changeButton setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
	[changeButton addTarget:self action:@selector(copyTest) forControlEvents:UIControlEventTouchUpInside];
	return changeButton;
}

- (UIButton*)serize
{
    UIButton* serize = [[UIButton alloc] initWithFrame:CGRectMake(10, 220, 50, 50)];
    serize.backgroundColor = UIColor.redColor;
    [serize setTitle:@"serize" forState:UIControlStateNormal];
    [serize setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [serize setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
    [serize addTarget:self action:@selector(serizeS) forControlEvents:UIControlEventTouchUpInside];
    return serize;
}



- (void)serizeS
{
    NSLog(@"serize");
    
    
    
    NSArray * array = @[@"a",@"b",@"c",@"d",@"e",@"f"];
      NSData *array_data = [NSJSONSerialization dataWithJSONObject:array options:0 error:nil];
    
     NSString* arrayJSON = [[NSString alloc] initWithData:array_data encoding:NSUTF8StringEncoding];
    
    
  NSArray * array2 = [NSJSONSerialization JSONObjectWithData:array_data options:NSJSONReadingMutableContainers error:nil];
    
    NSLog(@"arrayJSON = %@",arrayJSON);
    
    MJDishSpuEntity* ms = [[MJDishSpuEntity alloc] init];
    
    ms.code = @"123";
    
    
    NSData* dd = [NSKeyedArchiver archivedDataWithRootObject:ms];
    
    NSString* ss = [[NSString alloc] initWithData:dd encoding:NSASCIIStringEncoding];
    
    
    NSDictionary* ttt = [ms mj_JSONObject];
    
    
   MJDishSpuEntity * ms21 = [MJDishSpuEntity mj_objectWithKeyValues:ttt];
    
   
    NSDate* dic_data =  [NSKeyedArchiver archivedDataWithRootObject:ttt];
    
//     MJDishSpuEntity * ms2 = [NSJSONSerialization JSONObjectWithData:dic_data options:NSJSONReadingMutableContainers error:nil];
//
//   BOOL a = [NSJSONSerialization isValidJSONObject:ms];
//    NSLog(@"%@",a);
//        NSError *e = nil;
//        NSData *data = [NSJSONSerialization dataWithJSONObject:ms options:0 error:&e];
//
////    NSString * str = [NSData d]
//
//   NSString * str =   [[NSString  alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",str);
}


//@property (copy, nonatomic) NSString *text;
//@property (strong, nonatomic) NSArray<MJUser*> *users;/* 其他模型类型 */
//@property (strong, nonatomic) MJStatus *retweetedStatus;/* 自我模型类型 */


- (void)copyTest {
    
    
    
    aaA* a = [aaA createInstance:@"123"];
    aaA* b = [aaA createInstance:@"456"];
    
    NSArray * dt =  @[a];
    
   NSDictionary* ddd = [dt mj_JSONObject];
    
    
    NSError* err = nil;
    aaAArray * orderNoPrintdish =  [[aaAArray alloc] init];
    [orderNoPrintdish.printInfo addObject:a];
    [orderNoPrintdish.printInfo addObject:b];
    
//          NSData *JSONData1 = [NSJSONSerialization dataWithJSONObject:dt options:0 error:&err];
    
    NSDictionary *orderPrintKitchenOperateTOs = [orderNoPrintdish mj_JSONObject];
    BOOL valid = [NSJSONSerialization isValidJSONObject:orderPrintKitchenOperateTOs];
    
    NSLog(@"orderPrintKitchenOperateTOs = %@",orderPrintKitchenOperateTOs);
    
    
    NSData *JSONData2 = [NSJSONSerialization dataWithJSONObject:orderPrintKitchenOperateTOs options:0 error:&err];
    
    
    
    
    
    MJStatus* ms = [[MJStatus alloc] init];
    ms.text = @"123";
    
    MJUser* user1 = [[MJUser alloc] init];
    user1.name = @"user1";
    user1.testValue = 1.1;
    
    MJUser* user2 = [[MJUser alloc] init];
    user2.name = @"user2";
    user2.testValue = 1.2;
    
    ms.users = @[user1,user2];
    
    
    
    
    
    MJStatus* ms_retweetedStatus = [[MJStatus alloc] init];
    ms_retweetedStatus.text = @"123";
    
    MJUser* user1_retweetedStatus = [[MJUser alloc] init];
    user1_retweetedStatus.name = @"user1_retweetedStatus";
    user1_retweetedStatus.testValue = 1.1;
    
    MJUser* user2_retweetedStatus = [[MJUser alloc] init];
    user2_retweetedStatus.name = @"user2_retweetedStatus";
    user2_retweetedStatus.testValue = 1.2;
    
    ms_retweetedStatus.users = @[user1_retweetedStatus,user2_retweetedStatus];
    
    ms.retweetedStatus = ms_retweetedStatus;
    
    
    
    
    NSString* jsonStr = [ms mj_JSONString];
    
    
    //    NSError *e = nil;
    //    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:ms options:NSJSONReadingMutableContainers error:&e];
    //
    //
    //    if (!jsonArray) {
    //        NSLog(@"Error parsing JSON: %@", e);
    //    }
    
    
    
    
    MJStatus* ms2 = [MJStatus mj_objectWithKeyValues:jsonStr];
    ms2.retweetedStatus.users[0].name = @"ms2_user1_retweetedStatus";
    
    MJStatus* ms3 =  [ms copy];
    ms3.retweetedStatus.users[0].name = @"ms3_user1_retweetedStatus";
    
    NSLog(@"ms2 = %@",ms2);
    NSLog(@"ms.retweetedStatus.users[0].name = %@ testV = %f",
          ms.retweetedStatus.users[0].name ,ms.retweetedStatus.users[0].testValue );
    NSLog(@"ms2.retweetedStatus.users[0].name = %@ testV = %f",ms2.retweetedStatus.users[0].name ,ms2.retweetedStatus.users[0].testValue );
    NSLog(@"ms3.retweetedStatus.users[0].name = %@ testV = %f",
          ms3.retweetedStatus.users[0].name,
          ms3.retweetedStatus.users[0].testValue);
    
    
    
    
    //    NSDictionary *dict = @{
    //                           @"name" : @"Jack",
    //                           @"icon" : @"lufy.png",
    //                           @"age" : @20,
    //                           @"height" : @"1.55",
    //                           @"money" : @100.9,
    //                           @"sex" : @(SexFemale),/* 枚举需要使用NSNumber包装 */
    //                           @"gay" : @"NO"
    //                           };
    //    //字典转模型，使用的是mj_objectWithKeyValues:方法
    //    MJUser *user = [MJUser mj_objectWithKeyValues:dict];
    //    NSLog(@"%@",user.name);
    //
    //    NSDictionary *dict2 = @{
    //                            @"text" : @"Agree!Nice weather!",
    //                            @"user" : @{
    //                                    @"name" : @"Jack",
    //                                    @"icon" : @"lufy.png"
    //                                    },
    //                            @"retweetedStatus" : @{
    //                                    @"text" : @"Nice weather!",
    //                                    @"user" : @{
    //                                            @"name" : @"Rose",
    //                                            @"icon" : @"nami.png"
    //                                            }
    //                                    }
    //                            };
    //
    //    MJStatus *st = [MJStatus mj_objectWithKeyValues:dict2];
    //
    //    NSString* jsonStr = [st mj_JSONString];
    //
    ////    MJStatus *st1 = [MJStatus mj_objectWithKeyValues:jsonStr];
    //
    //    MJStatus *st1 = [st copy];
    //    st1.user.name = @"st1";
    //    NSLog(@" st.user.name = %@ ,  st1.user.name =  %@ ",  st.user.name, st1.user.name);
    //    NSString *text = status.text;
    //    NSString *name = status.user.name;
    //    NSString *icon = status.user.icon;
    //    NSLog(@"text=%@, name=%@, icon=%@", text, name, icon);
    //    // text=Agree!Nice weather!, name=Jack, icon=lufy.png
    //    NSString *text2 = status.retweetedStatus.text;
    //    NSString *name2 = status.retweetedStatus.user.name;
    //    NSString *icon2 = status.retweetedStatus.user.icon;
    //    NSLog(@"text2=%@, name2=%@, icon2=%@", text2, name2, icon2);
    //
    //
    //    NSDictionary* dic3 = @{@"canWeigh" : @"1",
    //                           @"code" : @"CFC"};
    //    NSLog(@"dic3 = %@",dic3);
    //
    //    MJDishSpuEntity *ss = [MJDishSpuEntity mj_objectWithKeyValues:dic3];
    //    NSLog(@"ss");
    
}

- (void)Test {
#if 0
	NSDictionary *dict = @{
						   @"name" : @"Jack",
						   @"icon" : @"lufy.png",
						   @"age" : @20,
						   @"height" : @"1.55",
						   @"money" : @100.9,
						   @"sex" : @(SexFemale),/* 枚举需要使用NSNumber包装 */
						   @"gay" : @"NO"
						   };
	//字典转模型，使用的是mj_objectWithKeyValues:方法
	MJUser *user = [MJUser mj_objectWithKeyValues:dict];
	NSLog(@"%@",user.name);
	
	NSDictionary *dict2 = @{
							@"text" : @"Agree!Nice weather!",
							@"user" : @{
									@"name" : @"Jack",
									@"icon" : @"lufy.png"
									},
							@"retweetedStatus" : @{
									@"text" : @"Nice weather!",
									@"user" : @{
											@"name" : @"Rose",
											@"icon" : @"nami.png"
											}
									}
							};
	
	MJStatus *status = [MJStatus mj_objectWithKeyValues:dict2];
	NSString *text = status.text;
	NSString *name = status.user.name;
	NSString *icon = status.user.icon;
	NSLog(@"text=%@, name=%@, icon=%@", text, name, icon);
	// text=Agree!Nice weather!, name=Jack, icon=lufy.png
	NSString *text2 = status.retweetedStatus.text;
	NSString *name2 = status.retweetedStatus.user.name;
	NSString *icon2 = status.retweetedStatus.user.icon;
	NSLog(@"text2=%@, name2=%@, icon2=%@", text2, name2, icon2);
	
	
	NSDictionary* dic3 = @{@"canWeigh" : @"1",
						   @"code" : @"CFC"};
	NSLog(@"dic3 = %@",dic3);
	
	MJDishSpuEntity *ss = [MJDishSpuEntity mj_objectWithKeyValues:dic3];
	NSLog(@"ss");
#endif
	
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
