//
//  MyPopViewController.m
//  TT
//
//  Created by 尹凡 on 2021/1/25.
//  Copyright © 2021 fanyin. All rights reserved.
//

#import "MyPopViewController.h"


@interface pp : NSObject
@property (nonatomic, copy) NSString* na;

- (void)pps;
@end

@implementation pp


- (void)pps
{
  NSLog(@"%@",self.na);
}

@end

@interface MyPopViewController ()

@property (nonatomic, copy) NSString* name;

@end

@implementation MyPopViewController

@synthesize name = _name;


void test(void * loacation, void* a)
{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"123";
  
  
//  __block int i = 10000;
  
//  @autoreleasepool {
//    while ( i > 0) {
//      dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//
//        i--;
//
//        pp * p = [pp new];
//        p.na = @(i).stringValue;
//
//        __unsafe_unretained pp * _ps = p;
//         __weak pp* t1 = _ps;
//        [t1 na];
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//          __weak pp* t ;
////          [t na];
//          test(&t, (__bridge void*)_ps);
//        });
//
//      });
//
//    };
//    }
  
 
    
    
    

  
    // Do any additional setup after loading the view.
}

- (NSString *)name
{
  return _name;
}

- (void)setName:(NSString *)name
{
  _name = [name copy];
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
