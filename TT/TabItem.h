//
//  TabItem.h
//  TT
//
//  Created by 尹凡 on 8/14/18.
//  Copyright © 2018 fanyin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^itemSelect)() ;
@interface TabItem : NSObject
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) itemSelect itemActicon;
+(TabItem*)CreateItem:(NSString*)title action:(itemSelect)action;

@end

