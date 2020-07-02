//
//  HookTableViewController.m
//  TT
//
//  Created by 尹凡 on 3/5/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "HookTableViewController.h"
#import "TabItem.h"
#import "CatelogHookViewController.h"
#import "UIViewController+AddParamterAndFunction.h"
#import "HookStudent.h"
#import "HookPerson.h"
#import "fishhook.h"


static void (*sys_nslog)(NSString *format,...);

void myNSLog(NSString *format, ...) {
    format = [format stringByAppendingString:@"hook成功！"];
    sys_nslog(format);
    sys_nslog(@"%s",__func__);
}

@interface HookTableViewController ()
@property (nonatomic, strong) NSMutableArray* source;
@end

@implementation HookTableViewController

- (instancetype)init
{
  self = [super init];
	if (self) {
		self.source = [NSMutableArray arrayWithCapacity:10];
		self.meSetcontrollerName = @"HookTableViewController";
	}
  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

  TabItem* hookCatalog = [TabItem CreateItem:@"hookCatalog" action:^{
    [self hookCatalog];
  }];
  [self.source addObject:hookCatalog];
  
  TabItem* hookSwizz = [TabItem CreateItem:@"hookSwizz" action:^{
    [self hookSwizz];
  }];
  [self.source addObject:hookSwizz];
	
	
	TabItem* hookStudentSwizz = [TabItem CreateItem:@"hookStudentSwizz" action:^{
		[self hookStudentSwizz];
	}];
	[self.source addObject:hookStudentSwizz];
	
	TabItem* fishhookTest = [TabItem CreateItem:@"fishhookTest" action:^{
	  [self fishhookTest];
	}];
	[self.source addObject:fishhookTest];
	
	TabItem* fishhookLog = [TabItem CreateItem:@"fishhookLog" action:^{
	  [self fishhookLog];
	}];
	[self.source addObject:fishhookLog];
  
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

- (void)hookCatalog {
  NSLog(@"hookCatalog");
  CatelogHookViewController* ca = [CatelogHookViewController new];
  [self.navigationController pushViewController:ca animated:YES];
}

- (void)hookSwizz {
  NSLog(@"hookSwizz");
}


- (void)hookStudentSwizz
{

	
	NSLog(@"#HookStudent start call sayHello");
	HookStudent* hs = [[HookStudent alloc] init];
	[hs sayHello];
	
	
//	NSLog(@"#HookPerson start call sayHello");
//	HookPerson* hp = [[HookPerson alloc] init];
//	[hp sayHello];
	
}


- (void)fishhookTest
{

	
	NSLog(@"#fishhookTest");
	
	
	struct rebinding rebindInfo;
    rebindInfo.name = "NSLog";
    rebindInfo.replacement = myNSLog;
    rebindInfo.replaced = (void *)&sys_nslog;
    
    struct rebinding rebs[1] = {rebindInfo};
    /**
     重新绑定符号

     @param rebindings#> 存放rebingding结构体的数组 description#>
     @param rebindings_nel#> 数组的长度 description#>
     @return return value description
     */
    rebind_symbols(rebs, 1);
}

- (void)fishhookLog
{
	NSLog(@"fishhookLog");
}


- (void)dealloc
{
	
	
}

@end
