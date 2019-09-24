//
//  MJViewController.m
//  TT
//
//  Created by fanyin on 2019/9/24.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "MJViewController.h"
#import "MJUser.h"

@interface MJViewController ()

@end

@implementation MJViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = UIColor.whiteColor;
	// Do any additional setup after loading the view.
	
	UIButton* t = [self TestButton];
	[self.view addSubview:t];
	
	UIButton* copy = [self copyTestButton];
	[self.view addSubview:copy];
	
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


//@property (copy, nonatomic) NSString *text;
//@property (strong, nonatomic) NSArray<MJUser*> *users;/* 其他模型类型 */
//@property (strong, nonatomic) MJStatus *retweetedStatus;/* 自我模型类型 */


- (void)copyTest {
	
	
	MJStatus* ms = [[MJStatus alloc] init];
	ms.text = @"123";
	
	MJUser* user1 = [[MJUser alloc] init];
	user1.name = @"user1";
	
	MJUser* user2 = [[MJUser alloc] init];
	user2.name = @"user2";
	
	ms.users = @[user1,user2];
	
	
	MJStatus* ms_retweetedStatus = [[MJStatus alloc] init];
	ms_retweetedStatus.text = @"123";
	
	MJUser* user1_retweetedStatus = [[MJUser alloc] init];
	user1_retweetedStatus.name = @"user1_retweetedStatus";
	
	MJUser* user2_retweetedStatus = [[MJUser alloc] init];
	user2_retweetedStatus.name = @"user2_retweetedStatus";
	
	ms_retweetedStatus.users = @[user1_retweetedStatus,user2_retweetedStatus];
	
	ms.retweetedStatus = ms_retweetedStatus;
	
	
	NSString* jsonStr = [ms mj_JSONString];
	MJStatus* ms2 = [MJStatus mj_objectWithKeyValues:jsonStr];
	ms2.retweetedStatus.users[0].name = @"ms2_user1_retweetedStatus";
	
	
	
	NSLog(@"ms2 = %@",ms2);
	NSLog(@"ms.retweetedStatus.users[0].name = %@",ms.retweetedStatus.users[0].name);
	NSLog(@"ms2.retweetedStatus.users[0].name = %@",ms2.retweetedStatus.users[0].name);
	
//	NSDictionary *dict = @{
//						   @"name" : @"Jack",
//						   @"icon" : @"lufy.png",
//						   @"age" : @20,
//						   @"height" : @"1.55",
//						   @"money" : @100.9,
//						   @"sex" : @(SexFemale),/* 枚举需要使用NSNumber包装 */
//						   @"gay" : @"NO"
//						   };
//	//字典转模型，使用的是mj_objectWithKeyValues:方法
//	MJUser *user = [MJUser mj_objectWithKeyValues:dict];
//	NSLog(@"%@",user.name);
//
//	NSDictionary *dict2 = @{
//							@"text" : @"Agree!Nice weather!",
//							@"user" : @{
//									@"name" : @"Jack",
//									@"icon" : @"lufy.png"
//									},
//							@"retweetedStatus" : @{
//									@"text" : @"Nice weather!",
//									@"user" : @{
//											@"name" : @"Rose",
//											@"icon" : @"nami.png"
//											}
//									}
//							};
//
//	MJStatus *st = [MJStatus mj_objectWithKeyValues:dict2];
//
//	NSString* jsonStr = [st mj_JSONString];
//
////	MJStatus *st1 = [MJStatus mj_objectWithKeyValues:jsonStr];
//
//	MJStatus *st1 = [st copy];
//	st1.user.name = @"st1";
//	NSLog(@" st.user.name = %@ ,  st1.user.name =  %@ ",  st.user.name, st1.user.name);
//	NSString *text = status.text;
//	NSString *name = status.user.name;
//	NSString *icon = status.user.icon;
//	NSLog(@"text=%@, name=%@, icon=%@", text, name, icon);
//	// text=Agree!Nice weather!, name=Jack, icon=lufy.png
//	NSString *text2 = status.retweetedStatus.text;
//	NSString *name2 = status.retweetedStatus.user.name;
//	NSString *icon2 = status.retweetedStatus.user.icon;
//	NSLog(@"text2=%@, name2=%@, icon2=%@", text2, name2, icon2);
//
//
//	NSDictionary* dic3 = @{@"canWeigh" : @"1",
//						   @"code" : @"CFC"};
//	NSLog(@"dic3 = %@",dic3);
//
//	MJDishSpuEntity *ss = [MJDishSpuEntity mj_objectWithKeyValues:dic3];
//	NSLog(@"ss");
	
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
