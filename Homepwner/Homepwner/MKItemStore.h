//
//  MKItemStore.h
//  Homepwner
//
//  Created by 穆康 on 2016/10/14.
//  Copyright © 2016年 mukang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKItem;

@interface MKItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;
- (MKItem *)createItem;
- (void)removeItem:(MKItem *)item;
- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

@end
