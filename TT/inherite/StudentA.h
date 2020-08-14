//
//  StudentA.h
//  TT
//
//  Created by fanyin on 2019/11/24.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "PersonA.h"

NS_ASSUME_NONNULL_BEGIN

@interface StudentA : PersonA

@property (nonatomic, strong) NSString* schoolName;


@property (nonatomic, copy) dispatch_block_t myBlock;


- (void)callName;

- (void)callTT;



-(void)ss;


@end

NS_ASSUME_NONNULL_END
