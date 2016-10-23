//
//  MKImageStore.m
//  Homepwner
//
//  Created by 穆康 on 2016/10/23.
//  Copyright © 2016年 mukang. All rights reserved.
//

#import "MKImageStore.h"

@interface MKImageStore ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation MKImageStore

+ (instancetype)sharedStore {
    static MKImageStore *sharedStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] init];
    });
    return sharedStore;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key {
    [self.dictionary setObject:image forKey:key];
}

- (UIImage *)imageForKey:(NSString *)key {
    return [self.dictionary objectForKey:key];
}

- (void)deleteImageForKey:(NSString *)key {
    if (!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
}

@end
