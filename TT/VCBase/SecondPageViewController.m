//
//  SecondPageViewController.m
//  TT
//
//  Created by 尹凡 on 2019/9/29.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "SecondPageViewController.h"

@interface SecondPageViewController ()

@property (nonatomic ,strong) NSArray<NSArray*>* source;


@end

@implementation SecondPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.source = [self createSourceNameFunList];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.tableView.dataSource =  self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
    
}


- (NSArray*)createSourceNameFunList {
    return @[];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.source count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.text = self.source[indexPath.row].firstObject;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* sel = self.source[indexPath.row][1];
    [self performSelector: NSSelectorFromString(sel) withObject:nil] ;
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
