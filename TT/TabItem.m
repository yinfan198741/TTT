
//
//  TabItem.m
//  TT
//
//  Created by 尹凡 on 8/14/18.
//  Copyright © 2018 fanyin. All rights reserved.
//

#import "TabItem.h"

@implementation TabItem


+(TabItem*)CreateItem:(NSString*)title action:(itemSelect)action; {
    TabItem* item = [[TabItem alloc] init];
    item.title = title;
    item.itemActicon = action;
    return item;
}

@end
