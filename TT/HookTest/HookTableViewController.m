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


- (void)dealloc
{
	
	
}

@end
