//
//  DynamicSysTest.m
//  TT
//
//  Created by 尹凡 on 2019/9/29.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "DynamicSysTest.h"


@interface DynamicSysTest() {
    NSString* _address;
    NSString* _propertyName;
    
    NSString* _ppName;
}
@end

@implementation DynamicSysTest

@synthesize name = _nameMMM;

@synthesize propertyName = _propertyName;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _address = @"_address my Address settd";
        _testAge = @"test age 18";
    }
    return self;
}


- (NSString*)getAdd
{
    return _address;
}

- (void)setAdd:(NSString*)setAddStr {
    _address = setAddStr;
}

- (void)setName:(NSString *)name {
    _nameMMM = name;
}

- (NSString*)name {
    return _nameMMM;
}

//-(void)setTestAge:(NSString *)testAge {
//    _testAge = testAge;
//}

- (NSString*)testAgeME {
    return _testAge;
}

- (NSString *)myPropertyMethod {
//    self.propertyName = @"123";
    return @"myPropertyMethod";
}

- ( NSString *)myPPName {
    return _ppName;
}


- (void)setmyPPName:(nonnull NSString *)ppname {
    _ppName = ppname;
}


- (NSString*)testcategy1 {
//	NSLog(@"")
	return @"testcategy1 from DynamicSysTest";
}

@end
