//
//  RACTestViewController.m
//  TT
//
//  Created by 尹凡 on 2019/7/2.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "RACTestViewController.h"
#import "ReactiveObjC.h"
#import "RacDemoViewController.h"
#import "FPRViewController.h"
#import "MBProgressHUD.h"
#import "MJUser.h"
#import "RACPassthroughSubscriber.h"

@interface RACTestViewController ()

@property (nonatomic ,strong) NSArray<NSArray*>* source;

@property (nonatomic ,strong) UILabel* label;

@property (nonatomic ,strong) UIButton* retryButtton;

@property (nonatomic, strong) id<RACSubscriber> subscriber;

@property (nonatomic, strong) MBProgressHUD* hub;

@property (nonatomic, strong)  RACCommand* commandTest ;

@end

@implementation RACTestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.hub = [[MBProgressHUD alloc] init];
    self.source = @[
                    @[@"commandTestexecuting",@"commandTestexecuting"],
                    @[@"commandTestDebug",@"commandTestDebug"],
                    @[@"FPRDemo",@"FPRDemo"],
                    @[@"Rsignal Demo",@"RacDemo"],
                    @[@"Rsignal Test",@"signalTest"],
                    @[@"commandTest",@"commandTest"],
                    @[@"combineCommand",@"combineCommand"],
                    @[@"commandcocurent",@"commandcocurent"],
                    @[@"RACDisposable",@"RACDisposableTest"],
                    @[@"RACSubject",@"RACSubjectTest"],
                    @[@"switchToLatest",@"switchToLatestTest"],
                    @[@"MulticastConnection",@"MulticastConnectionTest"],
                    @[@"multicommand",@"multicommand"],
                    @[@"bindTest",@"bindTest"],
                    @[@"filterTest",@"filterTest"],
                    @[@"codeToHot",@"codeToHotTest"],
                    @[@"RacSubjectTest",@"RacSubjectTest"],
                    @[@"trycatch",@"trycatchTest"],
                    @[@"autoConnect",@"autoConnectTest"],
                    @[@"lastTest",@"lastTest"],
                    @[@"flatMap",@"flatMapTest"],
                    @[@"merge",@"mergeTest"],
                    @[@"eventQuene",@"eventQueneTest"],
                    @[@"flatten",@"flattenTest"],
                    @[@"testCollectSignalsAndCombineLatestOrZip",@"testCollectSignalsAndCombineLatestOrZip"],
                    @[@"doNext",@"doNextTest"],
                    @[@"loadingTest",@"loadingTest"],
                    @[@"changeItem",@"changeItemTest"],
                     @[@"demoTTItem",@"demoTTItem"],
                   ];
    self.view.backgroundColor = UIColor.whiteColor;
    self.tableView.dataSource =  self;
    self.tableView.delegate = self;
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(250,700, 200, 50)];
    _label.backgroundColor = UIColor.redColor;
    
    [self.view addSubview:self.label];
    [self.tableView reloadData];
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


- (void)RacDemo {
    NSLog(@"RacDemo");
    RacDemoViewController* dvc = [[RacDemoViewController alloc] init];
    
    
    [self presentViewController:dvc animated:YES completion:nil];
    
}


- (void)FPRDemo {
	NSLog(@"FPRDemo");
	FPRViewController* dvc = [[FPRViewController alloc] init];
	
	
	[self presentViewController:dvc animated:YES completion:nil];
	
}


- (void)signalTest {
    RACSignal* signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"123"];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"RACDisposable disposableWithBlock");
        }];
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"x = %@",x);
    }];
}


- (void)commandTestLog {
    NSLog(@"commandTest");
    
    RACCommand* command_1 = [[RACCommand alloc] initWithSignalBlock:^RACSignal * (id   input) {
       return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber>   subscriber) {
           
           static BOOL error = NO;
           error  = !error;
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:@"command_1_1"];
           });
           
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               [subscriber sendNext:@"command_1_2"];
           });
           
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               if (error) {
                   NSError* err = [NSError errorWithDomain:@"123error" code:100 userInfo:nil];
                   [subscriber sendError:err];
               }
               else {
                   [subscriber sendCompleted];
               }
           });
           
           return nil;
        }];
    }];
    
    
    [command_1.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
          NSLog(@"command_1 switchToLatest = %@",x);
    }];
    
    [command_1.errors subscribeNext:^(NSError * _Nullable x) {
        NSLog(@"command_1.errors %@",x);
    }];
    
    
    [command_1.executing subscribeNext:^(NSNumber * x) {
        NSLog(@"executing = %@",x.boolValue ? @"YES" : @"NO");
    }];
    
    [[command_1 execute:nil] subscribeNext:^(id  _Nullable x) {
         NSLog(@"command_1 subscribeNext = %@",x);
    } error:^(NSError * _Nullable error) {
         NSLog(@"command_1 error = %@",error);
    }];
    
}


- (void)combineCommand {
    
    NSLog(@"combineCommand");
    
    RACCommand* command_1 = [[RACCommand alloc] initWithSignalBlock:^RACSignal * (id   input) {
        return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber>   subscriber) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@" RACCommand* command_1");
                [subscriber sendNext:@"command_1"];
                [subscriber sendCompleted];
               
            });
            return nil;
           
        }];
    }];
    
    RACCommand* command_2 = [[RACCommand alloc] initWithSignalBlock:^RACSignal * (id   input) {
        return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber>   subscriber) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@" RACCommand* command_2");
//                [subscriber sendNext:@"command_2"];
//                [subscriber sendCompleted];
                
                NSError* err = [NSError errorWithDomain:@"123" code:100 userInfo:nil];
                [subscriber sendError:err];
            });
            
            
            return nil;
        }];
    }];
    
    
    RACCommand* command_3 = [[RACCommand alloc] initWithSignalBlock:^RACSignal * (id   input) {
        return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber>   subscriber) {
             NSLog(@" RACCommand* command_3");
            [subscriber sendNext:@"command_3"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
//    RACSignal* commd_1 = [command_1 execute:nil];
//    RACSignal* commd_2 = [command_2 execute:nil];
//    RACSignal* commd_3 = [command_3 execute:nil];
//
//    [[[commd_1 then:^RACSignal * _Nonnull{
//        return commd_2;
//    }] then:^RACSignal * _Nonnull{
//        return commd_3;
//    }] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"x = %@",x);
//    }];
    
//    RACSignal* commd_exe_1 =  [[command_1.executing skip:1] map:^id _Nullable(NSNumber * _Nullable value) {
    
//    }];
    
    
    RACSignal* commd_exe_1 =  [[command_1.executing skip:1] map:^id _Nullable(NSNumber * _Nullable value) {
        return @[@"一号命令",value];
    }];
    RACSignal* commd_exe_2 =  [[command_2.executing skip:1] map:^id _Nullable(NSNumber * _Nullable value) {
         return @[@"二号命令",value];
    }];
    RACSignal* commd_exe_3 =  [[command_3.executing skip:1] map:^id _Nullable(NSNumber * _Nullable value) {
         return @[@"三号命令",value];
    }];
    
    [[RACSignal merge:@[commd_exe_1, commd_exe_2, commd_exe_3]]
     subscribeNext:^(NSArray* x) {

         self.label.text = [NSString stringWithFormat:@"%@%@",x[0],x[1]];
    }];
    
    
//    [[command_1 execute:nil] then:^RACSignal * _Nonnull{
//        return [[command_2 execute:nil] then:^RACSignal * _Nonnull{
//            return [command_3 execute:nil];
//        }];
//    }];
    
    [[command_1 execute:nil] subscribeCompleted:^{
        NSLog(@"command_1 execute:nil");
        [[command_2 execute:nil] subscribeCompleted:^{
            NSLog(@"command_2 execute:nil");
            [[command_3 execute:nil] subscribeCompleted:^{
                NSLog(@"command_3 execute:nil");
            }];
        }];
    }];
    
    
    
}


- (void)commandcocurent {
    RACCommand* command_1 = [[RACCommand alloc] initWithSignalBlock:^RACSignal * (id   input) {
        return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber>   subscriber) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@" RACCommand* command_1");
                [subscriber sendNext:@"command_1"];
                [subscriber sendCompleted];
            });
            return nil;
        }];
    }];
    
    command_1.allowsConcurrentExecution = YES;
    [command_1 execute:nil];
    [command_1 execute:nil];
    [command_1 execute:nil];
    [command_1 execute:nil];
}



- (void)RACDisposableTest {
    
    RACSignal* sig = [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
        
        self.subscriber = subscriber;
        
        [subscriber sendNext:@"123"];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"RACDisposable disposableWithBlock");
        }];
    }];
    
    RACDisposable* dis = [sig subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
//    [dis dispose];
    
}


- (void)RACSubjectTest{
    
    RACSubject* subject = [[RACSubject alloc] init];
    [subject sendNext:@"1"];
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"subject subscribeNext = x = %@",x);
    }];
    [subject sendNext:@"2"];
    [subject sendNext:@"3"];
    [subject sendNext:@"4"];
    [subject sendNext:@"5"];

    
    RACSubject* subjectReplay = [RACReplaySubject replaySubjectWithCapacity:2];
    [subjectReplay sendNext:@"1"];
    [subjectReplay sendNext:@"2"];
    [subjectReplay sendNext:@"3"];
    [subjectReplay sendNext:@"4"];
    [subjectReplay sendNext:@"5"];
    
    [subjectReplay subscribeNext:^(id  _Nullable x) {
        NSLog(@"subjectReplay subscribeNext = x = %@",x);
    }];
    
}

- (void)switchToLatestTest {
    
    
//    RACSignal *numbers = @[@(0), @(1), @(2)].rac_sequence.signal;
//
//    RACSignal *letters1 = @[@"A", @"B", @"C"].rac_sequence.signal;
//    RACSignal *letters2 = @[@"X", @"Y", @"Z"].rac_sequence.signal;
//    RACSignal *letters3 = @[@"M", @"N"].rac_sequence.signal;
//    NSArray *arrayOfSignal = @[letters1, letters2, letters3]; //2
//
//
//    [[[numbers
//       map:^id(NSNumber *n) {
//           //3
//           return arrayOfSignal[n.integerValue];
//       }]
//      collect]  //4
//     subscribeNext:^(NSArray *array) {
//         DDLogVerbose(@"%@, %@", [array class], array);
//     } completed:^{
//         DDLogVerbose(@"completed");
//     }];
//}
    
    
    RACSubject *signalofsignal = [RACSubject subject];
    RACSubject *signal1 = [RACSubject subject];
    RACSubject *signal2 = [RACSubject subject];
    RACSubject *signal3 = [RACSubject subject];
    
    
    
    [signalofsignal subscribeNext:^(RACSubject*  _Nullable x) {
        NSLog(@"x =%@",x);
        [x subscribeNext:^(id  _Nullable x2) {
            NSLog(@"x2 =%@",x2);
        }];
    }];
    
    
    [[signalofsignal flatten] subscribeNext:^(id  _Nullable x) {
        NSLog(@"signalofsignal flatten x2 =%@",x);
    }];
    
    
    ///热信号?? 这里要好好看看
    [signalofsignal.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"signalofsignal.switchToLatest x2 =%@",x);
    }];
    
    
    
    [signalofsignal sendNext:signal1];
    [signalofsignal sendNext:signal2];
    [signalofsignal sendNext:signal3];
    
    [signal1 sendNext:@"1"];
    [signal2 sendNext:@"2"];
    [signal3 sendNext:@"3"];
    
    
//    RACSignal* s1 = [RACSignal createSignal:^RACDisposable * (id<RACSubscriber>  subscriber) {
//        [subscriber sendNext:@"123"];
//        [subscriber sendCompleted];
//        return nil;
//    }];
//
//    [s1 subscribe:signal1];
    
    
//    [s1 s]
    
    
    
    //    [signalofsignal switchToLatest:^(RACSubject*  _Nullable x) {
    //        NSLog(@"x =%@",x);
    //        [x subscribeNext:^(id  _Nullable x2) {
    //            NSLog(@"x2 =%@",x2);
    //        }];
    //    }];
    
    
    //    延迟发送
    //    [signalofsignal sendNext:signal1];
    //    [signalofsignal sendNext:signal2];
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //         [signal1 sendNext:@"123"];
    //    });
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [signal2 sendNext:@"456"];
    //    });
    
}

- (void)MulticastConnectionTest {
    
    
    RACSubject* sj = [[RACSubject alloc] init];
    
    [sj subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    RACSignal* t = [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"123"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    
    [t subscribe:sj];
    
    
    
    static BOOL muticast = NO;
    
    static int runTime = 0;
    RACSignal* s1 = [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
        
        runTime ++;
        NSLog(@"runTime = %d",runTime);
        
        [subscriber sendNext:@"1"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    muticast = !muticast;
    
    if (!muticast) {
        
        NSLog(@"不使用多波===");
        
        [s1 subscribeNext:^(id  _Nullable x) {
            NSLog(@"subscribeNext_1 = %@",x);
        }];
        
        [s1 subscribeNext:^(id  _Nullable x) {
            NSLog(@"subscribeNext_2 = %@",x);
        }];
    }
    else
    {
        
         NSLog(@"使用多波====");
        
        RACMulticastConnection* s2 =  [s1 publish];
        
        [s2.signal subscribeNext:^(id  _Nullable x) {
             NSLog(@"subscribeNext_2_1 = %@",x);
        }];
        
        [s2.signal subscribeNext:^(id  _Nullable x) {
            NSLog(@"subscribeNext_2_2 = %@",x);
        }];
        
        [s2 connect];
    }
    
    
}





- (void)multicommand {
    
    static int counter = 1;
    
    RACCommand* command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * (id  input) {
        return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber>   subscriber) {
            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                counter++;
                NSLog(@"counter = %d",counter);
                [subscriber sendNext:@(counter)];
                [subscriber sendCompleted];
//            });
           
            return nil;
        }];
    }];
    
    command.allowsConcurrentExecution = YES;
    
    [[command.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        NSLog(@"1 command.executionSignal = %@",x);
    }];
    
    [[command.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        NSLog(@"2 command.executionSignal = %@",x);
    }];
    
    [[command execute:nil] subscribeNext:^(id  _Nullable x) {
        NSLog(@"1 command execute x = %@ ",x);
    }];
    
    [[command execute:nil] subscribeNext:^(id  _Nullable x) {
        NSLog(@"2 command execute x = %@ ",x);
    }];
    
    RACSignal* signal3 = [command execute:nil];
    [signal3 subscribeNext:^(id  _Nullable x) {
         NSLog(@"signal3 command execute x = %@ ",x);
    }];
    
    [signal3 subscribeNext:^(id  _Nullable x) {
         NSLog(@"signal3 command execute x = %@ ",x);
    }];
}

- (void)bindTest {
    NSLog(@"bindTest");
    
    RACSubject * subject = [RACSubject subject];
    
    RACSignal* binded = [subject bind:^RACSignalBindBlock{
        return ^RACSignal* (id value, BOOL *stop){
            
            NSString* t = [NSString stringWithFormat:@"bindvalue = %@",value];
            return [RACSignal return:t];
        };
    }];
    
    [binded subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"123"];
}


- (void)filterTest {
    NSLog(@"filterTest");
    
    {
        NSLog(@"===========filter=====begin=====");
        
        RACSubject * subject = [RACSubject subject];
        [[[subject ignore:@"a"] ignore:@"b"] subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@",x);
        }];
        
        [subject sendNext:@"a"];
        [subject sendNext:@"a1"];
        [subject sendNext:@"b"];
        
        NSLog(@"===========filter=====end=====");
    }
    
    {
        NSLog(@"===========take=====begin=====");
        
        RACSubject * subject = [RACSubject subject];
        [[[[subject ignore:@"a"] ignore:@"b"] take:1] subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@",x);
        }];
        
        [subject sendNext:@"a"];
        [subject sendNext:@"a1"];
        [subject sendNext:@"b1"];
        [subject sendNext:@"c1"];
        [subject sendNext:@"b"];
        
        NSLog(@"===========filter=====end=====");
    }
    
    {
        NSLog(@"===========takeLast=====begin=====");
        
        RACSubject * subject = [RACSubject subject];
        [[[[subject ignore:@"a"] ignore:@"b"] takeLast:1] subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@",x);
        }];
        
        [subject sendNext:@"a"];
        [subject sendNext:@"a1"];
        [subject sendNext:@"b1"];
        [subject sendNext:@"c1"];
        [subject sendNext:@"b"];
        [subject sendCompleted];
        
        NSLog(@"===========filter=====end=====");
    }
    
    {
        NSLog(@"===========takeUntile=====begin=====");
        
        RACSubject * subject = [RACSubject subject];
        RACSubject * subject2 = [RACSubject subject];
        [[[[subject ignore:@"a"] ignore:@"b"] takeUntil:subject2] subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@",x);
        }];
        
        [subject sendNext:@"a"];
        [subject sendNext:@"a1"];
        [subject sendNext:@"b1"];
        [subject2 sendNext:@"1"];
        [subject sendNext:@"c1"];
        [subject sendNext:@"b"];
      
        
        NSLog(@"===========takeUntile=====end=====");
    }
    
}

- (void)codeToHotTest {
    NSLog(@"codeToHotTest");
    
    
    static NSInteger type = 0;
    static NSInteger max = 7;
//    type = (type = type + 1) % 3;
    type = type + 1;
    type = type % max;
    NSLog(@"type = %ld",(long)type);
    
    RACSignal* sourceSignal = [RACSignal createSignal:^RACDisposable * (id<RACSubscriber>  subscriber) {
        NSLog(@"sourceSignal Run=================");
        [subscriber sendNext:@"123"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    
//    type = 4;
    
    if (type == 0)
    {
        RACSubject* subject = [RACSubject subject];
        [subject subscribeNext:^(id  _Nullable x) {
            NSLog(@"subject subscribeNext 1= %@",x);
        }];
        
        [subject subscribeNext:^(id  _Nullable x) {
            NSLog(@"subject subscribeNext 2= %@",x);
        }];
        
        [subject subscribeNext:^(id  _Nullable x) {
            NSLog(@"subject subscribeNext 3= %@",x);
        }];
        
        [sourceSignal subscribe:subject];
    }
    else if (type == 1)
    {
        RACMulticastConnection* mc = [sourceSignal publish];
        
        [mc.signal subscribeNext:^(id  _Nullable x) {
            NSLog(@"mc.signal subscribeNext1 = %@",x);
        }];
        
        [mc.signal subscribeNext:^(id  _Nullable x) {
            NSLog(@"mc.signal subscribeNext2 = %@",x);
        }];
        
        [mc connect];
    }
    else if (type == 2)
    {
        RACSignal* mc = [[sourceSignal publish] autoconnect];
        
        [mc subscribeNext:^(id  _Nullable x) {
            NSLog(@"mc.publish] autoconnect subscribeNext1 = %@",x);
        }];
        
        [mc subscribeNext:^(id  _Nullable x) {
            NSLog(@"mc.publish] autoconnect subscribeNext2 = %@",x);
        }];
    }
    else if (type == 3)
    {
//        RACSignal* replaySignal = [sourceSignal flattenMap:^ RACSignal * (id  _Nullable value) {
//            return [[RACSignal return:value] replay];
//        }];
        
        
        RACSignal *replaySignal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"源信号被订阅了");
            [subscriber sendNext:@"假设这是网络1"];
            [subscriber sendNext:@"假设这是网络2"];
            [subscriber sendNext:@"假设这是网络3"];
            [subscriber sendCompleted];
            return nil;
        }] replay];
        
        
        NSLog(@"start to subscribeNext@@@@@@@@######$$$$$");
        
        [replaySignal subscribeNext:^(id  _Nullable x) {
            NSLog(@"replaySignal subscribeNext1 = %@",x);
        }];
        
        [replaySignal subscribeNext:^(id  _Nullable x) {
            NSLog(@"replaySignal subscribeNext2 = %@",x);
        }];
    } else if (type == 4)
    {
        //        RACSignal* replaySignal = [sourceSignal flattenMap:^ RACSignal * (id  _Nullable value) {
        //            return [[RACSignal return:value] replay];
        //        }];
        
        
        RACSignal *replaySignal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"源信号被订阅了");
            [subscriber sendNext:@"假设这是网络1"];
            [subscriber sendNext:@"假设这是网络2"];
            [subscriber sendNext:@"假设这是网络3"];
            [subscriber sendCompleted];
            return nil;
        }] replayLast];
        
        
        NSLog(@"start to subscribeNext@@@@@@@@######$$$$$");
        
        [replaySignal subscribeNext:^(id  _Nullable x) {
            NSLog(@"replaySignal subscribeNext1 = %@",x);
        }];
        
        [replaySignal subscribeNext:^(id  _Nullable x) {
            NSLog(@"replaySignal subscribeNext2 = %@",x);
        }];
    }
    else if (type == 5)
    {
        //        RACSignal* replaySignal = [sourceSignal flattenMap:^ RACSignal * (id  _Nullable value) {
        //            return [[RACSignal return:value] replay];
        //        }];
        
        
        RACSignal *replaySignal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"源信号被订阅了");
            [subscriber sendNext:@"假设这是网络1"];
            [subscriber sendNext:@"假设这是网络2"];
            [subscriber sendNext:@"假设这是网络3"];
            [subscriber sendCompleted];
            return nil;
        }] replayLast];
        
        
        NSLog(@"start to subscribeNext@@@@@@@@######$$$$$");
        
        [replaySignal subscribeNext:^(id  _Nullable x) {
            NSLog(@"replaySignal subscribeNext1 = %@",x);
        }];
        
        [replaySignal subscribeNext:^(id  _Nullable x) {
            NSLog(@"replaySignal subscribeNext2 = %@",x);
        }];
    }
    else if (type == 6)
    {
        //        RACSignal* replaySignal = [sourceSignal flattenMap:^ RACSignal * (id  _Nullable value) {
        //            return [[RACSignal return:value] replay];
        //        }];
        
        
        RACSignal *replaySignal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"源信号被订阅了");
            [subscriber sendNext:@"假设这是网络1"];
            [subscriber sendNext:@"假设这是网络2"];
            [subscriber sendNext:@"假设这是网络3"];
            [subscriber sendCompleted];
            return nil;
        }] replayLazily];
        
        
        NSLog(@"start to subscribeNext@@@@@@@@######$$$$$");
        
        [replaySignal subscribeNext:^(id  _Nullable x) {
            NSLog(@"replaySignal subscribeNext1 = %@",x);
        }];
        
        [replaySignal subscribeNext:^(id  _Nullable x) {
            NSLog(@"replaySignal subscribeNext2 = %@",x);
        }];
    }
    
   
    
    
}

- (void)RacSubjectTest {
    NSLog(@"RacSubjectTest******************");
//    RACSubject* subject = [RACSubject subject];
//    RACSubject* subReplay = [RACReplaySubject subject];
//
//    [RACScheduler.mainThreadScheduler afterDelay:1 schedule:^{
//        NSLog(@"RACScheduler.mainThreadScheduler after 2");
//        [subject subscribeNext:^(id  _Nullable x) {
//            NSLog(@"subject subscribeNext = %@",x);
//        }];
//
//        [subReplay subscribeNext:^(id  _Nullable x) {
//            NSLog(@"subReplay subscribeNext = %@",x);
//        }];
//
//    }];
//
//    [subject sendNext:@"subject sendNext"];
//    [subReplay sendNext:@"subReplay sendNext"];

    RACSubject *subject = [RACSubject subject];
    RACSubject *replaySubject = [RACReplaySubject subject];
    
    [[RACScheduler mainThreadScheduler] afterDelay:0.1 schedule:^{
        // Subscriber 1
        [subject subscribeNext:^(id x) {
            NSLog(@"Subscriber 1 get a next value: %@ from subject", x);
        }];
        [replaySubject subscribeNext:^(id x) {
            NSLog(@"Subscriber 1 get a next value: %@ from replay subject", x);
        }];
        
        // Subscriber 2
        [subject subscribeNext:^(id x) {
            NSLog(@"Subscriber 2 get a next value: %@ from subject", x);
        }];
        [replaySubject subscribeNext:^(id x) {
            NSLog(@"Subscriber 2 get a next value: %@ from replay subject", x);
        }];
    }];
    
    [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
        [subject sendNext:@"send package 1"];
        [replaySubject sendNext:@"send package 1"];
    }];
    
    [[RACScheduler mainThreadScheduler] afterDelay:1.1 schedule:^{
        // Subscriber 3
        [subject subscribeNext:^(id x) {
            NSLog(@"Subscriber 3 get a next value: %@ from subject", x);
        }];
        [replaySubject subscribeNext:^(id x) {
            NSLog(@"Subscriber 3 get a next value: %@ from replay subject", x);
        }];
        
        // Subscriber 4
        [subject subscribeNext:^(id x) {
            NSLog(@"Subscriber 4 get a next value: %@ from subject", x);
        }];
        [replaySubject subscribeNext:^(id x) {
            NSLog(@"Subscriber 4 get a next value: %@ from replay subject", x);
        }];
    }];
    
    [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
        [subject sendNext:@"send package 2"];
        [replaySubject sendNext:@"send package 2"];
    }];
    

}


- (void)trycatchTest {
    NSLog(@"trycatchTest");
    
    
    RACSignal* t1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"123"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal* t2 = [t1 flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
//        return [RACSignal return:@"456"];
        NSError* err =  [NSError errorWithDomain:@"111" code:10 userInfo:nil];
        return [RACSignal error:err];
    }];
    
    [[[t2 catch:^RACSignal * _Nonnull(NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
//      NSError* err =  [NSError errorWithDomain:@"111" code:100 userInfo:nil];
//        return [RACSignal error:err];
        return [RACSignal return:@"error catch"];
    }] catch:^RACSignal * _Nonnull(NSError * _Nonnull error) {
         return [RACSignal return:@"error catch2"];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"x = %@",x);
    }];
    
}

static RACSignal* t1  = nil;

- (void)autoConnectTest{
    
    NSLog(@"autoConnectTest");
    
     t1 = [[[RACSignal createSignal:^RACDisposable * (id<RACSubscriber>  subscriber) {
        NSLog(@"这个是一个网络请求");
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"123"];
            [subscriber sendCompleted];
        });
       
        return  nil;
    }] publish] autoconnect];
    
    [t1 subscribeNext:^(id  _Nullable x) {
        NSLog(@"subscribeNext 1 = %@",x);
    }];
    
    [t1 subscribeNext:^(id  _Nullable x) {
        NSLog(@"subscribeNext 2 = %@",x);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [t1 subscribeNext:^(id  _Nullable x) {
            NSLog(@"subscribeNext 3 = %@",x);
        }];
        
        [t1 subscribeNext:^(id  _Nullable x) {
            NSLog(@"subscribeNext 4 = %@",x);
        }];
        
    });
    
    
}

- (void)lastTest
{
    NSLog(@"lastTest");
    
    
    RACSubject* sub = [RACSubject subject];
    
    [sub.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"x= %@",x);
    }];
    
    
    [[sub flatten] subscribeNext:^(id  _Nullable x) {
         NSLog(@"%@",x);
    }];
    
//    [sub subscribeNext:^(RACSignal*   x) {
//        [x subscribeNext:^(id  _Nullable x) {
//            NSLog(@"%@",x);
//        }];
//    }];
    
    
    RACSubject* sub1 = [RACSubject subject];
    RACSignal* s1 = [RACSignal createSignal:^RACDisposable * (id<RACSubscriber>  subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
                           [subscriber sendNext:@"123"];
                           [subscriber sendCompleted];
                       });
        return nil;
    }];
    
    [s1 subscribe:sub1];
    [sub sendNext:sub1];
    
    
    RACSubject* sub2 = [RACSubject subject];
    
    RACSignal* s2 = [RACSignal createSignal:^RACDisposable * (id<RACSubscriber>  subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
                           [subscriber sendNext:@"456"];
                           [subscriber sendCompleted];
                       });
        return nil;
    }];
    
    [s2 subscribe:sub2];
    [sub sendNext:sub2];
    
    
   
    
//    [sub1 subscribeNext:^(id  _Nullable x) {
//        NSLog(@"x = %@",x);
//    }];
    
    
    
}

- (void)flatMapTest
{
    NSLog(@"flatMapTest");
    
    RACSignal* s1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [RACScheduler.mainThreadScheduler afterDelay:1 schedule:^{
            [subscriber sendNext:@"123"];
            [subscriber sendCompleted];
        }];
       
        return nil;
    }];
    
    RACSignal* s2 = [s1 flattenMap:^ RACSignal * (id value) {
        return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber>   subscriber) {
            
            [RACScheduler.mainThreadScheduler afterDelay:1 schedule:^{
                [subscriber sendNext:[NSString stringWithFormat:@"%@,456",value]];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
    
    [s2 subscribeNext:^(id  _Nullable x) {
        NSLog(@"x = %@",x);
    }];
}


- (void)mergeTest
{
    NSLog(@"mergeTest");
    
    RACSignal* s1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"123"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    
    RACSignal* s2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"456"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    
    RACSignal* s3 = [s1 merge:s2];
    [s3 subscribeNext:^(id  _Nullable x) {
        NSLog(@"s3 subscribeNext = %@",x);
    }];
    
    
//    [s1 subscribeNext:^(id  _Nullable x) {
//        NSLog(@"s1 subscribeNext = %@",x);
//    }];
    
//    [s1 merge:<#(nonnull RACSignal *)#>]
    
//    RACSignal* s2 = [s1 flattenMap:^ RACSignal * (id value) {
//        return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber>   subscriber) {
//
//            [RACScheduler.mainThreadScheduler afterDelay:1 schedule:^{
//                [subscriber sendNext:[NSString stringWithFormat:@"%@,456",value]];
//                [subscriber sendCompleted];
//            }];
//            return nil;
//        }];
//    }];
//
//    [s2 subscribeNext:^(id  _Nullable x) {
//        NSLog(@"x = %@",x);
//    }];
}


- (void)eventQueneTest {
    
    
    static int a = 1;
    
    RACSignal* showLoading = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"UI showLoading===");
        [subscriber sendNext:@"showLoading"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    
    RACSignal* hiddenLoading = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"UI hiddenLoading===");
        [subscriber sendNext:@"hiddenLoading"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    
    //点击 - 》 网络下载- 〉 文件
    RACSignal* tap = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"1 tap===");
        a++;
        [subscriber sendNext:@"tap"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal* load = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"2 load=== a= %d",a);
        
        
        [RACScheduler.mainThreadScheduler afterDelay:2 schedule:^{
            if (a % 5 == 0) {
                NSError* e = [NSError errorWithDomain:@"123" code:0 userInfo:nil];
                [subscriber sendError:e];
            }
            else
            {
                [subscriber sendNext:@"loading"];
                [subscriber sendCompleted];
            }
        }];
        return nil;
    }];
    
    
    RACSignal* save = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"3 save===");
        [subscriber sendNext:@"save Over"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    
//    RACSignal* taks = [[tap concat:load] concat:(nonnull RACSignal *]
    
    RACSignal* task = [tap flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
//        return [load flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
//            return save;
//        }];
        
//        return [[showLoading concat:load] flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
//            return [save concat:hiddenLoading];
//        }];
        
        return [[showLoading then:^RACSignal * _Nonnull{
            return load;
        }] flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
            return [save then:^RACSignal * _Nonnull{
                return hiddenLoading;
            }];
        }];
    }];
    
    [[task catch:^RACSignal * _Nonnull(NSError * _Nonnull error) {
//        return [RACSignal error:error];
        RACSignal* e = [RACSignal return: error];
        return [RACSignal merge:@[hiddenLoading,e]];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"result Over? =%@",x);
    }];
    
}


- (void)flattenTest {
    NSLog(@"flattenTest");
    
    RACSignal * a1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"RACSignal - a1");
        [subscriber sendNext:@"a1"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal * a2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
         NSLog(@"RACSignal - a2");
        [subscriber sendNext:@"a2"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal * a3 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
         NSLog(@"RACSignal - a3");
        [subscriber sendNext:@"a3"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    
    
    RACSignal * b = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:a1];
        [subscriber sendNext:a2];
        [subscriber sendNext:a3];
        [subscriber sendCompleted];
        return nil;
    }];
    
//    [b subscribeNext:^(id  _Nullable x) {
//
//    }];
    

///Value returned from -flattenMap: is not a stream:
//    crash
//    [[a1 flatten] subscribeNext:^(id  _Nullable x) {
//         NSLog(@"a1 flatten x = %@",x);
//    }];

    [[b flatten] subscribeNext:^(id  _Nullable x) {
        NSLog(@"b flatten x = %@",x);
    }];
    
}


- (void)doNextTest
{
    NSLog(@"doNextTest");
    
    [[[[RACSignal return:@(123)]
      doNext:^(id  _Nullable x) {
          NSLog(@"doNext1 x= %@",x);
          x = @(2);
    }] doNext:^(id  _Nullable x) {
           NSLog(@"doNext2 x= %@",x);
          x = @(3);
    }]  subscribeNext:^(id x) {
        
        NSLog(@"subscribeNext x = %@",x);
    }];
    
}


- (void)loadingTest
{
     NSLog(@"loadingTest");
    
//    [[[[RACSignal return:@(123)]
//       doNext:^(id  _Nullable x) {
//           NSLog(@"doNext1 x= %@",x);
//           x = @(2);
//       }] doNext:^(id  _Nullable x) {
//           NSLog(@"doNext2 x= %@",x);
//           x = @(3);
//       }]  subscribeNext:^(id x) {
//
//           NSLog(@"subscribeNext x = %@",x);
//       }];
    
    RACSignal* demoSignal = [self createDemoSignal];
    
    demoSignal = [[demoSignal publish] autoconnect];
    
    [self subScribeForLoading:demoSignal];
    
    [self subScribeAndShowLoadig:demoSignal];
    
}

- (RACSignal*) createDemoSignal {
    RACSignal* demoSignal =  [RACSignal createSignal:^RACDisposable * (id<RACSubscriber>   subscriber) {
        
        NSLog(@"demoSignal%%%%%%%%%%%%%%%%%%%%%% 冷信号被执行");
        [subscriber sendNext:@"000000"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"____123"];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"123"];
            [subscriber sendCompleted];
        });
        
        return nil;
    }];
    return demoSignal;
}

- (void)subScribeAndShowLoadig:(RACSignal*)racSignal
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   
    static int a = 0;
    a++;
    racSignal = [[[racSignal flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            [subscriber sendNext:@"456"];
            NSString* v = [NSString stringWithFormat:@"456_ %@",value];
            [subscriber sendNext:v];
            [subscriber sendCompleted];
            return nil;
        }];
    }] flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            if (a%2 == 0) {
                //                [subscriber sendNext:@"789"];
                NSString* v = [NSString stringWithFormat:@"789_ %@",value];
                [subscriber sendNext:v];
                [subscriber sendCompleted];
            }
            else
            {
                NSError * e = [NSError errorWithDomain:@"errorWithDomain" code:1 userInfo:nil];
                [subscriber sendError: e];
            }
            
            return nil;
        }];
    }] catch:^RACSignal * (NSError * error) {
        return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"####"];
            [subscriber sendCompleted];
            return nil;
        }];
    }]  ;
    
    [racSignal subscribeNext:^(id  x) {
        NSLog(@"sub scribe Next1 x = %@",x);
    }];
    
    [racSignal subscribeNext:^(id  x) {
        NSLog(@"sub scribe Next2 x = %@",x);
    }];
    
    [racSignal subscribeError:^(NSError *  error) {
        NSLog(@"Error1");
    } completed:^{
        NSLog(@"completed1");
    }];
    
}

- (void)subScribeForLoading:(RACSignal*)racSignal
{
//    [racSignal subscribeCompleted:^{
//         NSLog(@"completed2");
//         [MBProgressHUD hideHUDForView:self.view animated:YES];
//    }];
//
//    [racSignal subscribeError:^(NSError * _Nullable error) {
//         NSLog(@"Error2");
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//    }];
    
   [racSignal subscribeError:^(NSError * _Nullable error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"Error2");
    } completed:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"completed2");
    }];
}


- (void)changeItemTest
{
    NSLog(@"changeItemTest");
    
    MJDishSpuEntity* s1 = [[MJDishSpuEntity alloc] init];
    s1.code = @"a";
    
    MJDishSpuEntity* s2 = [[MJDishSpuEntity alloc] init];
     s2.code = @"b";
    
    MJDishSpuEntity* s3 = [[MJDishSpuEntity alloc] init];
     s3.code = @"c";
    
    
    MJDishSpuEntity* s4 = [[MJDishSpuEntity alloc] init];
    s4.code = @"d";
    
    NSArray * arryt = @[s1,s2,s3];
    
    MJDishSpuEntity* exist = [[[arryt.rac_sequence filter:^BOOL(MJDishSpuEntity* value) {
        return [value.code isEqualToString:@"b"];
    }] array] firstObject];
    
    exist = s4;
    
    MJDishSpuEntity* ttm = [arryt objectAtIndex:1];
    ttm = s4;
    
    
  NSMutableArray* arrayT = [arryt mutableCopy];
    arrayT[1] = s4;
    
//    arryt = [arrayT]
    
    
//    arryt[1] = s4;
    
    NSLog(@"123");
}


- (void)commandTestexecuting
{
    [[self.commandTest executing] subscribeNext:^(NSNumber * _Nullable x) {
        NSLog(@"executing123 = %@",x);
    }];
}

- (void)commandTestDebug
{
    NSLog(@"commandTestDebug=========");
    
    static int a =0;
    static int b =0;

//    a++;
//    NSLog(@"a = %d",a);
    
//    b++;
//    NSLog(@"b = %d",b);
    
    
    if (_commandTest == nil) {
        _commandTest = [[RACCommand alloc] initWithSignalBlock:^RACSignal * (id  input) {
            
            
//            RACSignal* a = [[RACSignal createSignal:^RACDisposable * (id<RACSubscriber>   subscriber) {
//
//                [subscriber sendNext:@"123"];
//                [subscriber sendCompleted];
//                return nil;
//            }] setNameWithFormat:@"AAAAA"] ;
//
//
//            RACSignal* b = [[RACSignal createSignal:^RACDisposable * (id<RACSubscriber>   subscriber) {
//
//                //                           [subscriber sendNext:@"456"];
//                //                           [subscriber sendCompleted];
//
//                NSError* e = [NSError errorWithDomain:@"123" code:123 userInfo:nil];
////                [subscriber sendError:e];
//                return nil;
//            }] setNameWithFormat:@"BBBBB"] ;
//
//            RACSignal *c  =
//            [[[RACSignal combineLatest:@[a,b]] catch:^RACSignal * _Nonnull(NSError * _Nonnull error) {
//                return [RACSignal return:error];
//            }] then:^RACSignal * _Nonnull{
//                return [[RACSignal return:@"AAAA"] doNext:^(id  _Nullable x) {
//                    NSLog(@"doNext AAAAA");
//                }];
//            }];
            
            RACSignal *c  = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                //                NSError* e = [NSError errorWithDomain:@"123" code:123 userInfo:nil];
                //                 [subscriber sendError:e];
                
                [subscriber sendNext:@"123"];
                //                [subscriber sendCompleted];
                return nil;
            }] timeout:5 onScheduler:RACScheduler.mainThreadScheduler] ;
            
            return c;
            
//            return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber>   subscriber) {
//
//                NSLog(@"source flat map 只有在前面的信号输出 next 才能执行");
////                NSLog(@"source send sendCompleted");
////                [subscriber sendNext:@"123"];
////                [subscriber sendCompleted];
//
//
////                if (a%5 == 0) {
//                     NSLog(@"source send sendError");
//                    [subscriber sendError:nil];
////
////                }
//                return nil;
//            }];
        }];
//        _commandTest.allowsConcurrentExecution = YES;
        
        
        
     
    }
    
   
    
    

    
    [[[[self.commandTest execute:nil]
       flattenMap:^ RACSignal * (id value) {
        NSLog(@"flatMap one**********");
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            //            if (b % 3 == 0) {
            //                NSLog(@"flatMap one send error");
            //                [subscriber sendError:nil];
            //                return nil;
            //            }
            NSLog(@"flatMap one send next");
            [subscriber sendNext:[NSString stringWithFormat:@"%@%@",value,@"456"]];
            //            [subscriber sendCompleted];
            
            return nil;
        }];
        
    }] flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        NSLog(@"flatMap two**********");
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSLog(@"flatMap tow send next**********");
            [subscriber sendNext:[NSString stringWithFormat:@"%@%@",value,@"789"]];
            //            [subscriber sendCompleted];
            return nil;
        }];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"subscribeNext = %@",x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"NSError = %@",error);
    }];
    
    
}

RACSignal *__weak signal1_weak_;
RACSignal *__weak signal2_weak_;

- (void)demoTTItem
{
    NSLog(@"123");
    
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendCompleted];
        return nil;
    }];
    
    signal1_weak_ = signal1;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"1******* %@", signal1_weak_);
    });
    
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * (id<RACSubscriber>   subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"123");
//            subscriber
            RACPassthroughSubscriber* a = (RACPassthroughSubscriber*)subscriber;
             NSLog(@"RACPassthroughSubscriber = %@",a);
            [subscriber sendNext:@"444"];
            [subscriber sendCompleted];
        });
        return nil;
    }];
    [signal2 subscribeNext:^(id  _Nullable x) {
        NSLog(@"xxxxxx%@", x);
    }];
    signal2_weak_ = signal2;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"2******** %@", signal2_weak_);
    });
//    NSLog(@"signal2 = %@",signal2);
//
//    __weak typeof(RACSignal*) wSelf = signal2;
//    NSLog(@"weak signal2 = %@",wSelf);
//
//
//    MJUser* user = [[MJUser alloc] init];
//    user.name = @"MJUser_name";
//     NSLog(@"strong User = %@",user);
//     __weak typeof(MJUser*) wuser = user;
//     NSLog(@"weak User = %@",wuser);
////    @weakify(signal2)
//    dispatch_async(dispatch_get_main_queue(), ^{
////        __strong typeof(RACSignal*) strongSelf = wSelf;
//         __strong typeof(MJUser*) strongUser = wuser;
////        __weak typeof(RACSignal*) wSelf = signal2;
////        NSLog(@"2*******  %@", signal2_weak_);
//         NSLog(@"21*******  %@", signal2);
////         NSLog(@"22*******  %@", strongSelf);
//
//        [signal2 subscribeNext:^(id  _Nullable x) {
//            NSLog(@"xxxxxx2 %@", x);
//        }];
//
//        NSLog(@"strongUser = %@",strongUser.name);
//
//    });
}


//http://fengjian0106.github.io/2016/04/17/The-Power-Of-Composition-In-FRP-Part-1/

#pragma mark part_1
//1
- (void)initPipeline {
    @weakify(self);
    RACSignal *keyboardWillShowNotification =
    [[NSNotificationCenter.defaultCenter rac_addObserverForName:UIKeyboardWillShowNotification object:nil]
     map:^id(NSNotification *notification) {
         //2
         NSDictionary* userInfo = [notification userInfo];
         NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
         return aValue;
     }];
    
    [[[[[NSNotificationCenter.defaultCenter rac_addObserverForName:UIKeyboardWillHideNotification object:nil]
        map:^id(NSNotification *notification) {
            //3
            return [NSValue valueWithCGRect:CGRectZero];
        }]
       merge:keyboardWillShowNotification]   //4
      takeUntil:self.rac_willDeallocSignal]  //6
     subscribeNext:^(NSValue *value) {
         NSLog(@"Keyboard size is: %@", value);
         //5
         @strongify(self);
         //self.messageEditViewContainerViewBottomConstraint.constant = 5.0 + [value CGRectValue].size.height;
         
         [self.view updateConstraints];
         [UIView animateWithDuration:0.6 animations:^{
             @strongify(self);
             [self.view layoutIfNeeded];
         }];
     } completed:^{
         //6
         NSLog(@"%s, Keyboard Notification signal completed", __PRETTY_FUNCTION__);
     }];
}

///倒计时
- (RACSignal *)retryButtonTitleAndEnable {
    static const NSInteger n = 60;
    
    RACSignal *timer = [[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]]  //7
                         map:^id(id value) {
                             return nil; //8
                         }]
                        startWith:nil]; //9
    
    //10
    NSMutableArray *numbers = [[NSMutableArray alloc] init];
    for (NSInteger i = n; i >= 0; i--) {
        [numbers addObject:[NSNumber numberWithInteger:i]];
    }
    
    return [[[[[numbers.rac_sequence.signal zipWith:timer]  //11
               map:^id(RACTuple *tuple) {
                   //12
                   NSNumber *number = tuple.first;
                   NSInteger count = number.integerValue;
                   
                   if (count == 0) {
                       return RACTuplePack(@"重试", [NSNumber numberWithBool:YES]);
                   } else {
                       NSString *title = [NSString stringWithFormat:@"重试(%lds)", (long)count];
                       return RACTuplePack(title, [NSNumber numberWithBool:NO]);
                   }
               }]
              takeUntil:[self rac_willDeallocSignal]] //13
             setNameWithFormat:@"%s, retryButtonTitleAndEnable signal", __PRETTY_FUNCTION__]
            logCompleted]; //14
}

- (void)initPipelines {
    
//    self.retryButtton.rac_command =
    
    @weakify(self);
    [[[[[[self.retryButtton rac_signalForControlEvents:UIControlEventTouchUpInside]
         map:^id(id value) {
             //2
             @strongify(self);
             return [self retryButtonTitleAndEnable];
         }]
        startWith:[self retryButtonTitleAndEnable]]  //3
       switchToLatest]  //4
      takeUntil:[self rac_willDeallocSignal]]  //5
     subscribeNext:^(RACTuple *tuple) {
         //6
         @strongify(self);
         NSString *title = tuple.first;
         [self.retryButtton setTitle:title forState:UIControlStateNormal];
         self.retryButtton.enabled = ((NSNumber *)tuple.second).boolValue;
     } completed:^{
         //5
         NSLog(@"%s, pipeline completed", __PRETTY_FUNCTION__);
     }];
    
    //这里省略了点击 retryButtton 后具体要做的业务逻辑，同时也省略了验证按钮和验证码输入框的处理逻辑
}


#pragma mark part_2

- (RACSignal*)getUIImageWithURLString:(NSString*)url {
    return nil;
}

- (RACSignal*)decodeBarWithUIImage:(UIImage*)image
{
    return nil;
}

- (RACSignal *)decodeBarWithURLString: (NSString *)urlString {
    NSParameterAssert(urlString != nil);
    
    @weakify(self);
    return [[[self getUIImageWithURLString:urlString]  //1
             flattenMap:^(UIImage *image) {
                 @strongify(self);
                 return [self decodeBarWithUIImage:image];  //2
             }]
            timeout:1.5 onScheduler:[RACScheduler schedulerWithPriority:RACSchedulerPriorityDefault]];  //3
    
}

-(void)jsCallImageClick:(NSString *)imageUrl imageClickName:(NSString *)imgClickName {
    NSMutableArray *components = [NSMutableArray arrayWithArray:[imageUrl componentsSeparatedByString:@"&qmSrc:"]];
    NSMutableArray *temp = [NSMutableArray arrayWithArray:[(NSString*)[components firstObject] componentsSeparatedByString:[NSString stringWithFormat:@"&%@:",imgClickName]]];
//    [self filterJsArray:temp];
    NSString *imageUrlString = [NSString stringWithFormat:@"%@",(NSString *)[temp firstObject]];
    
    RACSignal *barCodeStringSignal = [self decodeBarWithURLString:imageUrlString];
    
    @weakify(self);
    [[barCodeStringSignal
      deliverOn:[RACScheduler mainThreadScheduler]]  //1
     subscribeNext:^(NSString *barCodeString) {
         @strongify(self);
//         [self showImageSaveSheetWithImageUrl:imageUrl withImageClickName:imgClickName withBarCode:barCodeString];
     } error:^(NSError *error) {
         
         @strongify(self);
//         [self showImageSaveSheetWithImageUrl:imageUrl withImageClickName:imgClickName withBarCode:nil];
     } completed:^{
     }];
}



//
//- (RACSignal *)getAvatarWithContact: (NSArray *)contact {
//    RACSignal *addrs = [[contact.rac_sequence
//                         map:^(NSString *contactItem) {
//                             return @(contactItem.length);
//                         }]
//                        signal];//4
//
//    ///越界???
// return [[[[addrs take:1]  //5
//              map:^id(NSString *emailAddr) {
//                  return [[[FMAvatarManager shareInstance] rac_asyncGetAvatar:emailAddr]
//                          retry:3];  //6
//              }]
//             flatten]
//            catch:^RACSignal *(NSError *error) {
//                //7
//                return [RACSignal return:nil]; //8
//            }];
//}
//
//- (void)initPipelineWithCell:(FMContactCreateAvatarCell *)cell {
//    @weakify(cell);
//    [[[[self getAvatarWithContact:self.contact] //1
//       deliverOnMainThread]
//      takeUntil:cell.rac_prepareForReuseSignal]
//     subscribeNext:^(UIImage *image) {
//         @strongify(cell);
//         if (image) { //2
//             [cell.avatarButton setImage:image forState:UIControlStateNormal];
//         }
//     } error:^(NSError *error) {
//         //3
//     } completed:^{
//     }];
//}

#pragma mark part_3

- (void)testCollectSignalsAndCombineLatestOrZip {

//#define _first
#ifdef _first
    
    //1
    RACSignal *numbers = @[@(0), @(1), @(2)].rac_sequence.signal;
    
    RACSignal *letters1 = @[@"A", @"B", @"C"].rac_sequence.signal;
    RACSignal *letters2 = @[@"X", @"Y", @"Z"].rac_sequence.signal;
    RACSignal *letters3 = @[@"M", @"N"].rac_sequence.signal;
    NSArray *arrayOfSignal = @[letters1, letters2, letters3]; //2
    
    
    [[[numbers
       map:^id(NSNumber *n) {
           //3
           return arrayOfSignal[n.integerValue];
       }]
      collect]  //4
     subscribeNext:^(NSArray *array) {
         
         NSLog(@"%@, %@", [array class], array);
     } completed:^{
         NSLog(@"completed");
     }];
#endif

//#define _second
#ifdef _second
    
    RACSignal *numbers = @[@(0), @(1), @(2)].rac_sequence.signal;
    
    RACSignal *letters1 = @[@"A", @"B", @"C"].rac_sequence.signal;
    RACSignal *letters2 = @[@"X", @"Y", @"Z"].rac_sequence.signal;
    RACSignal *letters3 = @[@"M", @"M"].rac_sequence.signal;
    NSArray *arrayOfSignal = @[letters1, letters2, letters3];
    

    
    
    [[[[numbers
        map:^id(NSNumber *n) {
            return arrayOfSignal[n.integerValue];
        }]
       collect]
      flattenMap:^RACSignal *(NSArray *arrayOfSignal) {
          //1
          return [RACSignal combineLatest:arrayOfSignal
                                   reduce:^(NSString *first, NSString *second, NSString *third) {
                                       return [NSString stringWithFormat:@"%@-%@-%@", first, second, third];
                                   }];
      }]
     subscribeNext:^(NSString *x) {
         NSLog(@"%@, %@", [x class], x);
     } completed:^{
         NSLog(@"completed");
     }];
    
#endif
    
#define _third
#ifdef _third
    
    RACSignal *numbers = @[@(0), @(1), @(2)].rac_sequence.signal;
    
    RACSignal *letters1 = @[@"A", @"B", @"C"].rac_sequence.signal;
    RACSignal *letters2 = @[@"X", @"Y", @"Z"].rac_sequence.signal;
    RACSignal *letters3 = @[@"M", @"M"].rac_sequence.signal;
    NSArray *arrayOfSignal = @[letters1, letters2, letters3];
    
    
//    [[RACSignal zip:arrayOfSignal
//             reduce:^(NSString *first, NSString *second, NSString *third) {
//                 return [NSString stringWithFormat:@"%@-%@-%@", first, second, third];
//
//             }] subscribeNext:^(id  _Nullable x) {
//                  NSLog(@"========= %@, %@", [x class], x);
//             }];
    
    [[[[numbers
        map:^id(NSNumber *n) {
            return arrayOfSignal[n.integerValue];//!! this is Signal, but just use map NOT flatMap
        }]
       collect]
      flattenMap:^RACSignal *(NSArray *arrayOfSignal) {
          //1
          return [RACSignal zip:arrayOfSignal
                         reduce:^(NSString *first, NSString *second, NSString *third) {
                             return [NSString stringWithFormat:@"%@-%@-%@", first, second, third];
                             
                         }];
      }]
     subscribeNext:^(NSString *x) {
         NSLog(@"%@, %@", [x class], x);
     } completed:^{
         NSLog(@"completed");
     }];
    
#endif
    
}
//
//- (RACSignal *)savaAvatar:(UIImage *)image withContact:(NSArray *)contact {
//    NSParameterAssert(image != nil);
//    NSParameterAssert(contact.count > 0);
//
//    //1
//    RACSignal *addrs = [[contact.rac_sequence
//                         map:^(id *contactItem) {
//                             return contactItem.email;
//                         }]
//                        signal];
//
//    return [[[[addrs
//               map:^id(NSString *emailAddr) {
//                   return [[[[FMAvatarManager shareInstance] rac_setAvatar:emailAddr image:image] //2
//                            map:^id(id value) {
//                                //4
//                                return RACTuplePack(value, nil);
//                            }]
//                           catch:^RACSignal *(NSError *error) {
//                               //3
//                               return [RACSignal return:RACTuplePack(nil, error)];
//                           }];
//               }]
//              collect]  //5
//             flattenMap:^RACStream *(NSArray<RACSignal *> *arrayOfSignal) {
//                 return [[RACSignal zip:arrayOfSignal]  //6
//                         map:^id(RACTuple *tuple) {     //7
//                             //8
//                             return [tuple allObjects];
//                         }];
//             }]
//            map:^id(NSArray<RACTuple *> *value) {
//                //9
//                return value;
//            }];
//}
//
//
//
//- (void)initPipline_3 {
//    @weakify(self);
//    //1
//    RACSignal *emailsIsNil = [[RACObserve(self.contact, contactItems) //2
//                               flattenMap:^id(NSMutableArray *items) {
//                                   if (items.count == 0) { //3
//                                       return [RACSignal return:[NSNumber numberWithBool:YES]];
//                                   }
//
//                                   //4
//                                   return [[[items.rac_sequence.signal
//                                             map:^id(FMContactItem *item) {
//                                                 return [[RACObserve(item, email)  //5
//                                                          distinctUntilChanged]    //6
//                                                         map:^id(NSString *email) {
//                                                             //7
//                                                             return [NSNumber numberWithBool:(email.length == 0)];
//                                                         }];
//                                             }]
//                                            collect]  //8
//                                           flattenMap:^id(NSArray *arrayOfBoolSignal) {
//                                               return [[[RACSignal combineLatest:arrayOfBoolSignal]  //9
//                                                        map:^id(RACTuple *tuple) {
//                                                            //10
//                                                            BOOL b = YES;
//                                                            for (NSUInteger i = 0; i < tuple.count; i++) {
//                                                                NSNumber *n = [tuple objectAtIndex:i];
//                                                                b = b && n.boolValue;
//                                                            }
//                                                            return [NSNumber numberWithBool:b];
//                                                        }]
//                                                       distinctUntilChanged];  //11
//                                           }];
//                               }]
//                              distinctUntilChanged];  //11
//
//    //12
//    RACSignal *phonesIsNil = [[RACObserve(self.contact, telephone)
//                               map:^id(NSMutableArray *phones) {
//                                   if (phones.count == 0) {
//                                       return [NSNumber numberWithBool:YES];
//                                   }
//
//                                   for (NSString *phone in phones) {
//                                       if (phone.length > 0) {
//                                           return [NSNumber numberWithBool:NO];
//                                       }
//                                   }
//
//                                   return [NSNumber numberWithBool:YES];
//                               }]
//                              distinctUntilChanged];
//
//    RACSignal *addressIsNil = [[RACObserve(self.contact, familyAddress)
//                                map:^id(NSMutableArray *addrs) {
//                                    if (addrs.count == 0) {
//                                        return [NSNumber numberWithBool:YES];
//                                    }
//
//                                    for (NSString *addr in addrs) {
//                                        if (addr.length > 0) {
//                                            return [NSNumber numberWithBool:NO];
//                                        }
//                                    }
//
//                                    return [NSNumber numberWithBool:YES];
//                                }]
//                               distinctUntilChanged];
//
//    RACSignal *customInfosIsNil = [[RACObserve(self.contact, customInformations)
//                                    flattenMap:^id(NSMutableArray *infos) {
//                                        if (infos.count == 0) {
//                                            return [RACSignal return:[NSNumber numberWithBool:YES]];
//                                        }
//
//                                        return [[[infos.rac_sequence.signal
//                                                  map:^id(FMCustomInformation *info) {
//                                                      RACSignal *nameSignal = [[RACObserve(info, name)
//                                                                                distinctUntilChanged]
//                                                                               map:^id(NSString *name) {
//                                                                                   return [NSNumber numberWithBool:(name.length == 0)];
//                                                                               }];
//
//                                                      RACSignal *infoSignal = [[RACObserve(info, information)
//                                                                                distinctUntilChanged]
//                                                                               map:^id(NSString *i) {
//                                                                                   return [NSNumber numberWithBool:(i.length == 0)];
//                                                                               }];
//
//                                                      return [RACSignal combineLatest:@[nameSignal, infoSignal]
//                                                                               reduce:(id)^id(NSNumber *name, NSNumber *info){
//                                                                                   return [NSNumber numberWithBool:(name.boolValue && info.boolValue)];
//                                                                               }];
//
//                                                  }]
//                                                 collect]
//                                                flattenMap:^id(NSArray *arrayOfBoolSignal) {
//                                                    return [[[RACSignal combineLatest:arrayOfBoolSignal]
//                                                             map:^id(RACTuple *tuple) {
//                                                                 BOOL b = YES;
//                                                                 for (NSUInteger i = 0; i < tuple.count; i++) {
//                                                                     NSNumber *n = [tuple objectAtIndex:i];
//                                                                     b = b && n.boolValue;
//                                                                 }
//                                                                 return [NSNumber numberWithBool:b];
//                                                             }]
//                                                            distinctUntilChanged];
//                                                }];
//                                    }]
//                                   distinctUntilChanged];
//
//    RACSignal *nickIsNil = [[RACObserve(self.contact, nick)
//                             map:^id(NSString *nick) {
//                                 @strongify(self);
//                                 if (self.contact.nick == nil || [self.contact.nick isEqualToString:@""] == YES) {
//                                     return [NSNumber numberWithBool:YES];
//                                 }
//                                 return [NSNumber numberWithBool:NO];
//                             }]
//                            distinctUntilChanged];
//
//    RACSignal *markIsNil = [RACObserve(self.contact, mark)
//                            map:^id(NSString *mark) {
//                                (self);@strongify
//                                if (self.contact.mark == nil || [self.contact.mark isEqualToString:@""] == YES) {
//                                    return [NSNumber numberWithBool:YES];
//                                }
//                                return [NSNumber numberWithBool:NO];
//                            }];
//
//    RACSignal *birthdayIsNil = [RACObserve(self.contact, birthday)
//                                map:^id(NSString *birthday) {
//                                    @strongify(self);
//                                    if (self.contact.birthday == nil || [self.contact.birthday isEqualToString:@""] == YES) {
//                                        return [NSNumber numberWithBool:YES];
//                                    }
//                                    return [NSNumber numberWithBool:NO];
//                                }];
//
//    //13
//    NSArray *allSignal = @[nickIsNil, emailsIsNil, markIsNil, phonesIsNil, addressIsNil, birthdayIsNil, customInfosIsNil];
//    self.contactHasNoPros = [[[[RACSignal combineLatest:allSignal]  //13
//                               map:^id(RACTuple *tuple) {
//                                   //14
//                                   BOOL b = YES;
//                                   for (NSUInteger i = 0; i < tuple.count; i++) {
//                                       NSNumber *n = [tuple objectAtIndex:i];
//                                       b = b && n.boolValue;
//                                   }
//                                   return [NSNumber numberWithBool:b];
//                               }]
//                              distinctUntilChanged]
//                             deliverOnMainThread];
//}

#pragma mark part_4


//- (void)snapshotAndEdit {
//
//    //1
//    RACSignal *isNotActive = [[NSNotificationCenter.defaultCenter rac_addObserverForName:UIApplicationWillResignActiveNotification object:nil]
//                              map:^id(NSNotification *notification) {
//                                  return [NSNumber numberWithBool:NO];
//                              }];
//
//    RACSignal *isActive = [[[[NSNotificationCenter.defaultCenter rac_addObserverForName:UIApplicationDidBecomeActiveNotification object:nil]
//                             map:^id(NSNotification *notification) {
//                                 return [NSNumber numberWithBool:YES];
//                             }]
//                            startWith:[NSNumber numberWithBool:YES]]
//                           merge:isNotActive];
//
//    RACSignal *isNotInBackground = [[NSNotificationCenter.defaultCenter rac_addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil]
//                                    map:^id(NSNotification *notification) {
//                                        return [NSNumber numberWithBool:NO];
//                                    }];
//
//    RACSignal *isInForeground = [[[[NSNotificationCenter.defaultCenter rac_addObserverForName:UIApplicationWillEnterForegroundNotification object:nil]
//                                   map:^id(NSNotification *notification) {
//                                       return [NSNumber numberWithBool:YES];
//                                   }]
//                                  startWith:[NSNumber numberWithBool:YES]]
//                                 merge:isNotInBackground];
//
//    //2
//    RACSignal *didTakeScreenshot = [NSNotificationCenter.defaultCenter rac_addObserverForName:UIApplicationUserDidTakeScreenshotNotification object:nil];
//
//    @weakify(self);
//    RACSignal *imageSignal = [[[[[[[RACSignal if:[RACSignal merge:@[isInForeground, isActive]] then:didTakeScreenshot else:[RACSignal never]] //3
//                                   takeUntil:self.rac_willDeallocSignal]
//                                  filter:^BOOL(id value) {
//                                      //4
//                                      @strongify(self);
//                                      return [self filterScreenshotNotification];
//                                  }]
//                                 filter:^BOOL(id value) {
//                                     //5
//                                     @strongify(self);
//                                     return self.previewShotView == nil;
//                                 }]
//                                map:^id(NSNotification *notification) {
//                                    //6
//                                    @strongify(self);
//                                    return [self takeCurrentScreenshotOfWebview];
//                                }]
//                               multicast:[RACReplaySubject subject]]
//                              autoconnect];//7
//
//    //8
//    RACSignal *hotSignalForPreview = [[[imageSignal
//                                        map:^id(UIImage *image) {
//                                            @strongify(self);
//                                            return [self showScreenshotPreviewView:image];
//                                        }]
//                                       multicast:[RACReplaySubject subject]]
//                                      autoconnect];
//
//    //9
//    RACSignal *cancel = [[hotSignalForPreview
//                          map:^id(FMScreenshotPreviewView *previewView) {
//                              return [previewView.cancelSignal
//                                      map:^id(id value) {
//                                          return nil;
//                                      }];
//                          }]
//                         switchToLatest];
//
//    //10
//    RACSignal *editImage = [[hotSignalForPreview
//                             map:^id(FMScreenshotPreviewView *previewView) {
//                                 return [previewView.editImage
//                                         map:^id(id value) {
//                                             return nil;
//                                         }];
//                             }]
//                            switchToLatest];
//
//    //11
//    RACSignal *otherActionForHidePreview = [[hotSignalForPreview
//                                             map:^id(id value) {
//                                                 RACSignal *willResignActive = [[[NSNotificationCenter.defaultCenter rac_addObserverForName:UIApplicationWillResignActiveNotification object:nil]
//                                                                                 take:1]
//                                                                                takeUntil:[RACSignal merge:@[cancel, editImage]]];
//
//                                                 RACSignal *timeout = [[[RACSignal return:nil]
//                                                                        delay:10.0]
//                                                                       takeUntil:[RACSignal merge:@[cancel, editImage, willResignActive]]];
//
//
//                                                 return [[RACSignal merge:@[timeout, willResignActive]]
//                                                         take:1];
//                                             }]
//                                            switchToLatest];
//
//    //12
//    RACSignal *shouldHidePreviewView = [RACSignal merge:@[cancel, editImage, otherActionForHidePreview]];
//
//    //13
//    RACSignal *viewWillDisappear = [self rac_signalForSelector:@selector(viewWillDisappear:)];
//
//    //14
//    [[[shouldHidePreviewView
//       zipWith:hotSignalForPreview]
//      takeUntil:viewWillDisappear]//13
//     subscribeNext:^(RACTuple *tuple) {
//         @strongify(self);
//         [self hideScreenshotPreviewView:tuple];
//     } completed:^{
//     }];
//
//    //15
//    [[[imageSignal sample:editImage]
//      takeUntil:viewWillDisappear]
//     subscribeNext:^(UIImage *image) {
//         @strongify(self);
//         [self showDrawViewController:image];
//     } completed:^{
//     }];
//
//}


#pragma mark part_5


//- (void)fetchNecessaryDataForAccounts:(NSArray<FMAccount *> *)accounts {
//    NSParameterAssert(accounts != nil);
//    NSParameterAssert(accounts.count > 0);
//
//    @weakify(self);
//    [[[[[accounts.rac_sequence signal] //1
//        map:^id(FMAccount *account) {
//            //2
//            return [[[QHOldAccountMigration fetchInitialDataForAccount:account]
//                     map:^id(FMAccount *account) {
//                         //3
//                         return RACTuplePack(account, nil);
//                     }]
//                    catch:^RACSignal *(NSError *error) {
//                        //3
//                        return [RACSignal return:RACTuplePack(account, error)];
//                    }];
//        }]
//       collect] //4
//      flattenMap:^RACStream *(NSArray *arrayOfSignal) {
//          ///等待所有信号都完成??? 自己试一下zip
//          return [[RACSignal zip:arrayOfSignal] //4
//                  map:^id(RACTuple *tuple) {
//                      NSMutableArray *successAccounts = [[NSMutableArray alloc] init];
//                      NSMutableArray *failAccounts = [[NSMutableArray alloc] init];
//
//                      for (int i = 0; i < tuple.count; i++) {
//                          RACTuple *t = [tuple objectAtIndex:i];
//                          FMAccount *account = t.first;
//                          NSError *error = t.second;
//
//                          if (error) {
//                              [failAccounts addObject:account];
//                          } else {
//                              [successAccounts addObject:account];
//                          }
//                      }
//
//                      return RACTuplePack([successAccounts copy], [failAccounts copy]);
//                  }];
//      }]
//     subscribeNext:^(RACTuple *tuple) {
//         @strongify(self);
//         NSArray *successAccounts = tuple.first;
//         NSArray *failAccounts = tuple.second;
//         //5
//
//         if (failAccounts.count == 0) {
//             [self jumpToOriginalLogic];
//         } else {
//             NSMutableString *title;
//             if (successAccounts.count == 0) {
//                 title = [[NSMutableString alloc] initWithString:@"所有账号迁移失败，请重新登录"];
//             } else {
//                 title = [[NSMutableString alloc] initWithString:@"邮箱账号"];
//                 for (FMAccount *account in failAccounts) {
//                     [title appendFormat:@"%@, ", account.profile.mailAddress];
//                 }
//
//                 title = [[title substringToIndex:title.length - 2] mutableCopy];
//                 [title appendString:@"迁移失败，需要重新登录"];
//             }
//
//             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
//             [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                 @strongify(self);
//                 for (FMAccount *account in failAccounts) {
//                     FMMigrationFailAccount *failAccount = [FMMigrationFailAccount convertAccountToMigrationFailAccount:account];
//                     [failAccount save];
//
//                     [[FMManager shareInstance] deleteAccount:account.accountId];
//                 }
//                 [self jumpToOriginalLogic];
//             }]];
//
//             UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
//             [viewController presentViewController:alertController animated:YES completion:^{
//             }];
//         }
//     } error:^(NSError *error) {
//
//     } completed:^{
//
//     }];
//}


///模拟一个场景来实现这个需求
//- (void)fetchNecessaryDataForAccountsWithProcess:(NSArray<FMAccount *> *)accounts {
//    NSParameterAssert(accounts != nil);
//    NSParameterAssert(accounts.count > 0);
//
//    @weakify(self);
//    //1
//    RACSignal *fetchAllInitialData = [[[[accounts.rac_sequence signal]
//                                        map:^id(FMAccount *account) {
//                                            return [[[[[QHOldAccountMigration fetchInitialDataForAccount:account]
//                                                       map:^id(FMAccount *account) {
//                                                           return RACTuplePack(account, nil);
//                                                       }]
//                                                      catch:^RACSignal *(NSError *error) {
//                                                          return [RACSignal return:RACTuplePack(account, error)];
//                                                      }]
//                                                     multicast:[RACReplaySubject subject]] //3
//                                                    autoconnect];
//                                        }]
//                                       multicast:[RACReplaySubject subject]] //2
//                                      autoconnect];
//
//
//    //4
//    RACSignal *businessLogicSignal = [[fetchAllInitialData collect]
//                                      flattenMap:^RACStream *(NSArray *arrayOfSignal) {
//                                          return [[RACSignal zip:arrayOfSignal]
//                                                  map:^id(RACTuple *tuple) {
//                                                      NSMutableArray *successAccounts = [[NSMutableArray alloc] init];
//                                                      NSMutableArray *failAccounts = [[NSMutableArray alloc] init];
//
//                                                      for (int i = 0; i < tuple.count; i++) {
//                                                          RACTuple *t = [tuple objectAtIndex:i];
//                                                          FMAccount *account = t.first;
//                                                          NSError *error = t.second;
//
//                                                          if (error) {
//                                                              [failAccounts addObject:account];
//                                                          } else {
//                                                              [successAccounts addObject:account];
//                                                          }
//                                                      }
//
//                                                      return RACTuplePack([successAccounts copy], [failAccounts copy]);
//                                                  }];
//                                      }];
//
//
//    [businessLogicSignal
//     subscribeNext:^(RACTuple *tuple) {
//         @strongify(self);
//         NSArray *successAccounts = tuple.first;
//         NSArray *failAccounts = tuple.second;
//         //5
//         if (failAccounts.count == 0) {
//             [self jumpToOriginalLogic];
//         } else {
//             NSMutableString *title;
//             if (successAccounts.count == 0) {
//                 title = [[NSMutableString alloc] initWithString:@"所有账号迁移失败，请重新登录"];
//             } else {
//                 title = [[NSMutableString alloc] initWithString:@"邮箱账号"];
//                 for (FMAccount *account in failAccounts) {
//                     [title appendFormat:@"%@, ", account.profile.mailAddress];
//                 }
//
//                 title = [[title substringToIndex:title.length - 2] mutableCopy];
//                 [title appendString:@"迁移失败，需要重新登录"];
//             }
//
//             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
//             [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                 @strongify(self);
//                 for (FMAccount *account in failAccounts) {
//                     FMMigrationFailAccount *failAccount = [FMMigrationFailAccount convertAccountToMigrationFailAccount:account];
//                     [failAccount save];
//
//                     [[FMManager shareInstance] deleteAccount:account.accountId];
//                 }
//                 [self jumpToOriginalLogic];
//             }]];
//
//             UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
//             [viewController presentViewController:alertController animated:YES completion:^{
//             }];
//         }
//     } error:^(NSError *error) {
//
//     } completed:^{
//
//     }];
//
//
//    //11
//    static const CGFloat tickCount = 60 / 0.5;
//    RACSignal *timer = [[RACSignal interval:0.5 onScheduler:[RACScheduler mainThreadScheduler]]
//                        map:^id(id value) {
//                            return nil;
//                        }];
//
//    NSMutableArray *numbers = [[NSMutableArray alloc] init];
//    for (NSInteger i = 0; i < tickCount; i++) {
//        [numbers addObject:@(i)];
//    }
//
//    RACSignal *counter = [[[[[numbers.rac_sequence signal]
//                             zipWith:timer]
//                            map:^id(RACTuple *tuple) {
//                                NSNumber *n = tuple.first;
//                                return RACTuplePack(n, @(tickCount), nil);//12
//                            }]
//                           takeUntil:businessLogicSignal]
//                          logCompleted];
//
//
//
//    //6
//    NSMutableArray *sequence = [[NSMutableArray alloc] init];
//    for (int i = 0; i < accounts.count; i++) {
//        [sequence addObject:@(i + 1)];
//    }
//
//
//    static NSInteger progressValue = 0;
//
//    [[[[[[[fetchAllInitialData flatten]//6
//          map:^id(RACTuple *tuple) {
//              //7
//              return tuple.first;
//          }]
//         zipWith:[sequence.rac_sequence signal]]//8
//        combineLatestWith:[RACSignal return:@(accounts.count)]]//8
//       map:^id(RACTuple *tuple) {
//           //9
//           RACTuple *nestedTuple = tuple.first;
//           NSNumber *accountsCount = tuple.second;
//
//           FMAccount *account = nestedTuple.first;
//           NSNumber *order = nestedTuple.second;
//
//           //10
//           return RACTuplePack(order, accountsCount, account);
//       }]
//      merge:counter]//11
//     subscribeNext:^(RACTuple *tuple) {
//         NSNumber *order = tuple.first;
//         NSNumber *accountsCount = tuple.second;
//         FMAccount *account = tuple.third;
//
//         //13
//         if (account) {
//             NSLog(@"fetch initial data finished, order is: [%@, %@], account is: %@", order, accountsCount, account.profile.mailAddress);
//
//             NSInteger nextValue = order.integerValue * 100 / accountsCount.integerValue;
//             if (order.integerValue == accountsCount.integerValue) {
//                 nextValue = 100;
//                 progressValue = 100;
//             }
//
//             if (nextValue > progressValue) {
//                 progressValue = nextValue;
//             }
//         } else {
//             NSLog(@"counter info, [%@, %@]", order, accountsCount);
//             progressValue = progressValue + 1.0;
//
//             //14
//             if (progressValue > 95) {
//                 progressValue = 95.0;
//             }
//         }
//
//         //14
//         NSLog(@"======== progressValue is: %ld", (long)progressValue);
//
//     } error:^(NSError *error) {
//     } completed:^{
//     }];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
