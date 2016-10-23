//
//  MKItem.m
//  RandomItems
//
//  Created by 穆康 on 16/9/5.
//  Copyright © 2016年 mukang. All rights reserved.
//

#import "MKItem.h"

@implementation MKItem

+ (instancetype)randomItem {
    NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
    NSArray *randomNounList = @[@"Bear", @"Spork", @"Mac"];
    
    NSInteger adjectiveIndex = arc4random() % randomAdjectiveList.count;
    NSInteger nounIndex = arc4random() % randomNounList.count;
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@",
                            randomAdjectiveList[adjectiveIndex],
                            randomNounList[nounIndex]];
    
    int randomValue = arc4random() % 100;
    
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10];
    
    MKItem *item = [[self alloc] initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerialNumber];
    return item;
}

- (instancetype)initWithItemName:(NSString *)name serialNumber:(NSString *)sNumber {
    return [self initWithItemName:name valueInDollars:0 serialNumber:sNumber];
}

- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber {
    self = [super init];
    if (self) {
        _itemName = name;
        _serialNumber = sNumber;
        _valueInDollars = value;
        _dateCreated = [NSDate date];
        NSUUID *uuid = [[NSUUID alloc] init];
        _itemKey = [uuid UUIDString];
    }
    return self;
}

- (instancetype)initWithItemName:(NSString *)name {
    return [self initWithItemName:name valueInDollars:0 serialNumber:@""];
}

- (instancetype)init {
    return [self initWithItemName:@"Item"];
}

- (NSString *)description {
    NSString *descriptionString =
        [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@",
                                         self.itemName,
                                         self.serialNumber,
                                         self.valueInDollars,
                                         self.dateCreated];
    return descriptionString;
}

@end
