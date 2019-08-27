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

@interface RACTestViewController ()

@property (nonatomic ,strong) NSArray<NSArray*>* source;

@property (nonatomic ,strong) UILabel* label;

@property (nonatomic, strong) id<RACSubscriber> subscriber;

@end

@implementation RACTestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.source = @[@[@"Rsignal Demo",@"RacDemo"],
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


- (void)commandTest {
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
