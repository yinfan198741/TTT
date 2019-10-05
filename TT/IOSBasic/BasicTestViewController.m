//
//  BasicTestViewController.m
//  TT
//
//  Created by 尹凡 on 2019/9/29.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "BasicTestViewController.h"
#import "DynamicSysTest.h"
#import "DynamicSysTest+DySenteic.h"
#import "DynamicSysTest+TestMethodConver.h"

@interface BasicTestViewController ()

@end

@implementation BasicTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSArray*)createSourceNameFunList {
   return @[@[@"synthesize&dynamic",@"SynthesizedynamicCall"],
			@[@"categriMethod",@"categriMethodCall"],
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
    
    [tt saveRefObj:@"saveRefObj 123"];
    NSLog(@"getRefObj = %@",[tt getRefObj]);
    
    NSLog(@"tt.testAgeME = %@",tt.testAgeME);
}


- (void)categriMethodCall {
	DynamicSysTest* tt = [[DynamicSysTest alloc] init];
	NSLog(@"categriMethodCall testcategy1 = %@",tt.testcategy1);
	NSLog(@"多个分类存在的方法,根据编译顺序决定、谁最后编译,就插到方法列表前面 categriMethodCall testAgeME = %@",tt.testAgeME);
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
