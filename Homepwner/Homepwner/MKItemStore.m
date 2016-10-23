//
//  MKItemStore.m
//  Homepwner
//
//  Created by 穆康 on 2016/10/14.
//  Copyright © 2016年 mukang. All rights reserved.
//

#import "MKItemStore.h"
#import "MKItem.h"
#import "MKImageStore.h"

@interface MKItemStore ()

@property (nonatomic, strong) NSMutableArray *privateItems;

@end

@implementation MKItemStore

+ (instancetype)sharedStore {
    static MKItemStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[MKItemStore sharedStore]" userInfo:nil];
    return nil;
}

- (NSArray *)allItems {
    return self.privateItems;
}

- (MKItem *)createItem {
    MKItem *item = [MKItem randomItem];
    [self.privateItems addObject:item];
    return item;
}

- (void)removeItem:(MKItem *)item {
    [[MKImageStore sharedStore] deleteImageForKey:item.itemKey];
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    MKItem *item = self.privateItems[fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];
}

@end
