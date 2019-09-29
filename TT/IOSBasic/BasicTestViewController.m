//
//  BasicTestViewController.m
//  TT
//
//  Created by 尹凡 on 2019/9/29.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "BasicTestViewController.h"
#import "DynamicSysTest.h"

@interface BasicTestViewController ()

@end

@implementation BasicTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSArray*)createSourceNameFunList {
   return @[@[@"synthesize&dynamic",@"SynthesizedynamicCall"],
      ];
}

- (void)SynthesizedynamicCall {
    NSLog(@"Synthesize&dynamicCall");
    DynamicSysTest* tt = [[DynamicSysTest alloc] init];
    tt.name = @"111";
    NSString* myAddress = [tt getAdd];
    NSLog(@"tt = %@ address = %@", @"my name call crash", myAddress);
    NSLog(@"tt = %@ address = %@ testAgeME = %@ myPropertyMethodRes = %@",
          tt.name ,
          myAddress,
          tt.testAgeME,
          tt.myPropertyMethod);
    
    tt.propertyName = @"ppname";
    NSLog(@"tt.propertyName = %@",tt.propertyName);
    
    NSLog(@"tt.myPPName = %@",tt.myPPName);
    [tt setmyPPName:@" cal set tt.myPPName"];
    NSLog(@"tt.myPPName = %@",tt.myPPName);
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
