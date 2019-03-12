//
//  ViewController.m
//  BundleDemo
//
//  Created by 晓童 韩 on 16/3/31.
//  Copyright © 2016年 晓童 韩. All rights reserved.
//

#import "BundleViewController.h"
#import <Masonry/Masonry.h>


@interface BundleViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation BundleViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview = ({
        UITableView *tableview = [UITableView new];
        [self.view addSubview:tableview];
        [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableview.delegate = self;
        tableview.dataSource = self;
        
        tableview;
    });
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Example%@",@(indexPath.row+1)];
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class cls = NSClassFromString([NSString stringWithFormat:@"Example%@ViewController", @(indexPath.row+1)] );
    
    if (cls) {
        [self.navigationController pushViewController:[cls new] animated:YES];
    }
}

@end
