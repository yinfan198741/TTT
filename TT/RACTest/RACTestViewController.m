//
//  RACTestViewController.m
//  TT
//
//  Created by 尹凡 on 2019/7/2.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "RACTestViewController.h"
#import "ReactiveObjC.h"

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
                    ];
    self.view.backgroundColor = UIColor.whiteColor;
    self.tableView.dataSource =  self;
    self.tableView.delegate = self;
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 600, 200, 50)];
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
