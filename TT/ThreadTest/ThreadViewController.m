//
//  ThreadViewController.m
//  TT
//
//  Created by 尹凡 on 11/5/18.
//  Copyright © 2018 fanyin. All rights reserved.
//

#import "ThreadViewController.h"

@interface ThreadViewController ()

@end



@implementation ThreadViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = UIColor.whiteColor;
  self.title = @"线程测试";
  [self readButton];
  [self writeButton];
  [self imageLoaderButton];
}

-(void)readButton {
  UIButton* read = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 50, 50)];
  [read setTitle:@"read" forState:UIControlStateNormal];
  [read setBackgroundColor:[UIColor redColor]];
  [read addTarget:self action:@selector(readThread) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:read];
}

-(void)writeButton {
  UIButton* write = [[UIButton alloc] initWithFrame:CGRectMake(130, 100, 50, 50)];
  [write setTitle:@"write" forState:UIControlStateNormal];
  [write setBackgroundColor:[UIColor redColor]];
  [write addTarget:self action:@selector(writeThread) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:write];
}


-(void)imageLoaderButton {
  UIButton* imageLoader = [[UIButton alloc] initWithFrame:CGRectMake(200, 100, 50, 50)];
  [imageLoader setTitle:@"imageLoader" forState:UIControlStateNormal];
  [imageLoader setBackgroundColor:[UIColor redColor]];
  [imageLoader addTarget:self action:@selector(ImageLoaderTest) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:imageLoader];
}

static int a = 100;

-(void) readThread {
  NSLog(@"readThread");
  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  for (int i = 0; i < 1000; i++) {
    dispatch_async(queue, ^{
      NSLog(@"readThread1 = %d thread info = %@",a,[NSThread currentThread]);
    });
  }
}

-(void) writeThread {
  NSLog(@"writeThread");
  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  for (int i = 0; i < 1000; i++) {
    dispatch_async(queue, ^{
      a = i;
      NSLog(@"writeThread = %d thread info = %@",a,[NSThread currentThread]);
    });
  }
}

-(void)ImageLoaderTest {
  for (int i = 0; i< 1000; i++) {
  NSRegularExpression *videoRegex = nil;
  videoRegex = [NSRegularExpression regularExpressionWithPattern:@"(?:&|^)ext=MOV(?:&|$)"
                                                        options:NSRegularExpressionCaseInsensitive
                                                           error:nil];
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       NSString *query = @"brand=MEITUAN&version=1.1.0&_=1535368692244";
        if (query != nil && [videoRegex firstMatchInString:query
                                                   options:0
                                                     range:NSMakeRange(0, query.length)]) {
        }
       NSLog(@"ImageLoaderTest = %d ",i);
     });
  }
}


@end

