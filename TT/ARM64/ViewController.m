//
//  ViewController.m
//  ArmTest
//
//  Created by fanyin on 2020/9/20.
//

#import "ViewController.h"
#include "addTow.h"
#include "addThree.h"
#include "addFour.h"
#include "BigStruct.h"
#include "ArgsParamter.h"
#import "ArgsParamterOc.h"
#import "HPerson.h"
#import "THInterceptor.h"
#import <objc/runtime.h>
#import "fishhook.h"



@interface TestObject : NSObject
@end

@implementation TestObject

- (void)method
{
	NSLog(@"123 cmd = %s",_cmd);
}

@end

@interface ViewController ()

@end

extern int TestAss(void);

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	
//	self.view.backgroundColor = UIColor.redColor;
	
	UIButton* b1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
	b1.backgroundColor = [UIColor redColor];
	[b1 setTitle:@"one" forState:UIControlStateNormal];
	[b1 addTarget:self action:@selector(onclickOne) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:b1];
	
	UIButton* b2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 50, 50)];
	b2.backgroundColor = [UIColor redColor];
	[b2 setTitle:@"tow" forState:UIControlStateNormal];
	[b2 addTarget:self action:@selector(onclickTow) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:b2];
	
	
	UIButton* b3 = [[UIButton alloc] initWithFrame:CGRectMake(10, 300, 50, 50)];
	b3.backgroundColor = [UIColor redColor];
	[b3 setTitle:@"three" forState:UIControlStateNormal];
	[b3 addTarget:self action:@selector(onclickThree) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:b3];
	
	
	UIButton* b4 = [[UIButton alloc] initWithFrame:CGRectMake(10, 200, 50, 50)];
	b4.backgroundColor = [UIColor redColor];
	[b4 setTitle:@"Four" forState:UIControlStateNormal];
	[b4 addTarget:self action:@selector(onclickFour) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:b4];
	
	
	UIButton* b5 = [[UIButton alloc] initWithFrame:CGRectMake(200, 100, 50, 50)];
	b5.backgroundColor = [UIColor redColor];
	[b5 setTitle:@"Five" forState:UIControlStateNormal];
	[b5 addTarget:self action:@selector(onclickFive) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:b5];
	
	
	UIButton* b6 = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 50, 50)];
	b6.backgroundColor = [UIColor redColor];
	[b6 setTitle:@"Six" forState:UIControlStateNormal];
	[b6 addTarget:self action:@selector(onclickSix) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:b6];
	
	
	UIButton* b7 = [[UIButton alloc] initWithFrame:CGRectMake(200, 300, 50, 50)];
	b7.backgroundColor = [UIColor redColor];
	[b7 setTitle:@"Seven" forState:UIControlStateNormal];
	[b7 addTarget:self action:@selector(onclickSeven) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:b7];
	
	
	UIButton* b8 = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 50, 50)];
	b8.backgroundColor = [UIColor redColor];
	[b8 setTitle:@"Eight" forState:UIControlStateNormal];
	[b8 addTarget:self action:@selector(onclickOne1) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:b8];
	
	
	UIButton* b9 = [[UIButton alloc] initWithFrame:CGRectMake(200, 400, 50, 50)];
	b9.backgroundColor = [UIColor redColor];
	[b9 setTitle:@"Nine" forState:UIControlStateNormal];
	[b9 addTarget:self action:@selector(onclickOne2) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:b9];
	
	
	UIButton* b0 = [[UIButton alloc] initWithFrame:CGRectMake(100, 500, 50, 50)];
	b0.backgroundColor = [UIColor redColor];
	[b0 setTitle:@"Ten" forState:UIControlStateNormal];
	[b0 addTarget:self action:@selector(Ten) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:b0];
	
	
	UIButton* b11 = [[UIButton alloc] initWithFrame:CGRectMake(0, 600, 50, 50)];
	b11.backgroundColor = [UIColor redColor];
	[b11 setTitle:@"HKP" forState:UIControlStateNormal];
	[b11 addTarget:self action:@selector(HKPrint) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:b11];

	
	UIButton* b12 = [[UIButton alloc] initWithFrame:CGRectMake(100, 600, 50, 50)];
	b12.backgroundColor = [UIColor redColor];
	[b12 setTitle:@"FHKP" forState:UIControlStateNormal];
	[b12 addTarget:self action:@selector(FHKPrint) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:b12];
	
	
	UIButton* b13 = [[UIButton alloc] initWithFrame:CGRectMake(160, 600, 50, 50)];
	b13.backgroundColor = [UIColor redColor];
	[b13 setTitle:@"objMsH" forState:UIControlStateNormal];
	[b13 addTarget:self action:@selector(objMsH) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:b13];
	
	
	UIButton* b14 = [[UIButton alloc] initWithFrame:CGRectMake(230, 600, 50, 50)];
	b14.backgroundColor = [UIColor redColor];
	[b14 setTitle:@"MSend" forState:UIControlStateNormal];
	[b14 addTarget:self action:@selector(MSend) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:b14];
	
}

// C Format
void myInterceptor()
{
	// bla bla bla
	
	NSLog(@"myInterceptor");
}




- (void)onclickOne
{
//	long a = 0x1111;
//	long b = 0x2222;
//	long tow = addTow(a, b);
//	NSLog(@"tow = %ld",tow);

//	int ret = TestAss();
//	NSLog(@"ret = %d",ret);
//	myInterceptor();
	int ret = TestAss();
	NSLog(@"ret = %d",ret);
	
	
//	THInterceptor *interceptor = [[THInterceptor alloc] initWithRedirectionFunction:(IMP)myInterceptor];
//	Method m = class_getInstanceMethod([HPerson class], @selector(eat));
//	IMP imp = method_getImplementation(m);
//
//	// Intercept the imp
//	THInterceptorResult *result = [interceptor interceptFunction:imp];
//
//	// You can check the result.state to find whether the inteception is successfully carried out or not.
//	if (result.state == THInterceptStateSuccess)
//	{
//		NSLog(@"THInterceptStateSuccess");
//	}
//	HPerson* hp = [[HPerson alloc] init];
//	[hp eat];
	
	
	THInterceptor *interceptor = [[THInterceptor alloc] initWithRedirectionFunction:(IMP)myInterceptor];

	// Suppose you want to intercept the call of - [UIView initWithFrame:]
	Method m = class_getInstanceMethod([UIView class], @selector(initWithFrame:));
	IMP imp = method_getImplementation(m);

	// Intercept the imp
	THInterceptorResult *result = [interceptor interceptFunction:imp];

	// You can check the result.state to find whether the inteception is successfully carried out or not.
	if (result.state == THInterceptStateSuccess)
	{
		NSLog(@"THInterceptStateSuccess");
	}
	
}

- (void)onclickTow
{
	
//	HPerson* hp = [[HPerson alloc] init];a
//	[hp eat];
	long a = 0x1111;
	long b = 0x2222;
	long tow = addTow(a, b);
	NSLog(@"tow = %ld",tow);
}


- (void)onclickThree
{
	long a = 0x1234;
	long b = 0x2334;
	long c = 0x3234;
	long three = addThree(a, b, c);
	NSLog(@"three = %ld",three);
}

- (void)onclickFour
{
	long a = 0x1234;
	long b = 0x2334;
	long c = 0x3234;
	long d = 0x4234;
	long three = addFour(a, b, c,d);
	NSLog(@"three = %ld",three);
}


- (void)onclickFive
{
	bigs s = getBigs();
	NSLog(@"s.a19 = %lld",s.a19);
}


//static int a = 1;
//static int b = 2;
//static int c = 3;
//static int d = 4;




///BP 在那里
- (void)onclickSix
{
//	sum(5, 5, 7, 1, 3, -2);
	printf("%d\n", sum(1, 2, 3) );
	test("hget %s %s", "abc", "123456");
//	int a = 0x1234;
//	[ArgsParamterOc sum: @(1111) , @(2222), nil];
	
	
//	int ret = sum(1,2,3);
//	printf("%d",ret);
}

- (void)onclickSeven
{
//	int ret = argsTest(1,2,3,4);
//	printf("%d",ret);
//	int a = 0x1234;
//	[ArgsParamterOc sum: @(1) , @2, @3, @4, nil];
	
//	int ret = sum(1,2,3,4,5);
//	printf("%d",ret);
	printf("%d\n", sum(1,2,3,4,5) );
}



- (void)onclickOne1
{
//	UIView* v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
	NSLog(@"v = %@",@"onclickOne");
//	[_obj method];
	TestObject* __obj = [[TestObject alloc] init];
	[__obj method];
}


// 拦截函数
void wzq_check_variadic(id a, char * methodName, int *v, ...)
{
	NSLog(@"haha checked %@ %s", a, methodName);
}


- (void)onclickOne2
{

	
	THInterceptor *sharedInterceptor = [[THInterceptor alloc] initWithRedirectionFunction:(IMP)wzq_check_variadic];

	Method m = class_getInstanceMethod([TestObject class], @selector(method));
	IMP imp = method_getImplementation(m);

	THInterceptorResult *result = [sharedInterceptor interceptFunction:(IMP)imp];
	if (result.state == THInterceptStateSuccess) {
		method_setImplementation(m, (IMP)result.replacedAddress);
		NSLog(@"%p",result.replacedAddress);
	}

	
	
}


- (void)Ten
{
	
	int a = TestAss();
	NSLog(@"Ten %d",a);
}


- (void)HKPrint
{
	printf("abc\n");
}

static int(*oldPrintf)(const char *, ...);

int myPrintf(const char * message, ...)
{
	char *firstName = "真棒\n";
	char *result = malloc(strlen(message) + strlen(firstName));
	strcpy(result, message);
	strcat(result, firstName);
	oldPrintf(result);
	return 1;
}

- (void)FHKPrint
{
	printf("FHKPrint\n");
//	struct rebinding pp;
//	pp.name = "printf";
//	pp.replacement = myPrint;
//	pp.replaced = (void*)&oldPrintf;
//
//	struct rebinding rebindings[1] = {pp};
//	rebind_symbols(rebindings, 1);
	
	
	struct rebinding rebind;
	rebind.name = "printf";
	rebind.replacement = myPrintf; // 将自定义的函数赋值给replacement
	rebind.replaced = (void *)&oldPrintf; // 使用自定义的函数指针来接收printf函数原有的实现

	struct rebinding rebs[1] = {rebind};
	rebind_symbols(rebs, 1);

	
}


extern void hookStart();

- (void)objMsH
{
	NSLog(@"objMsH");
	hookStart();
}


- (void)MSend
{
	HPerson* p = [[HPerson alloc] init];
	[p sleep];
	NSLog(@"MSend");
}

@end
