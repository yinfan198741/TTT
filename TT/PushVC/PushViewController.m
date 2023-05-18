//
//  PushViewController.m
//  TT
//
//  Created by 尹凡 on 8/13/18.
//  Copyright © 2018 fanyin. All rights reserved.
//

#import "PushViewController.h"
#import "SVProgressHUD.h"

@interface PushViewController ()

@property (nonatomic, copy) NSArray* source;

@end

@implementation PushViewController



- (void)viewDidLoad {
    [super viewDidLoad];
  self.source = @[@"AAAAAAAAAAAAAAAAAAA",
                  @"AAAAAAAAAAAAAAAAAAA",
                  @"AAAAAAAAAAAAAAAAAAA",
                  @"AAAAAAAAAAAAAAAAAAA",
                  @"AAAAAAAAAAAAAAAAAAA",
                  @"AAAAAAAAAAAAAAAAAAA",
                  @"AAAAAAAAAAAAAAAAAAA",
                  @"AAAAAAAAAAAAAAAAAAA",
                  @"AAAAAAAAAAAAAAAAAAA"];
    self.view.backgroundColor = UIColor.whiteColor;
    UIGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
//  navigationController.view.backgroundColor = UIColor.clearColor()
//  navigationController.navigationBar.backgroundColor = UIColor.clearColor()

//  self.navigationController.navigationBar.backgroundColor = UIColor.clearColor;
//  self.navigationController.view.backgroundColor = UIColor.clearColor;
  self.navigationController.navigationBar.translucent = YES;
//  self.navigationController.navigationBar.
    // Do any additional setup after loading the view.
    
    [SVProgressHUD show];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]
                                  initWithTitle: @"Root"
                                  style: UIBarButtonItemStylePlain
                                  target:nil
                                  action:nil];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.navigationItem.title = @"Hello, im the title";
   
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]
                                  initWithTitle: @"left"
                                  style: UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(tap)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
  
 
  
}

- (void)tap {
//    [self popViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"tap");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.source.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell* cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
  cell.textLabel.text = self.source[indexPath.row];
  cell.textLabel.textColor = UIColor.redColor;
  return cell;
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
