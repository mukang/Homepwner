//
//  MKItemsViewController.m
//  Homepwner
//
//  Created by 穆康 on 2016/10/13.
//  Copyright © 2016年 mukang. All rights reserved.
//

#import "MKItemsViewController.h"
#import "MKItemStore.h"
#import "MKItem.h"

@implementation MKItemsViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        for (int i=0; i<5; i++) {
            [[MKItemStore sharedStore] createItem];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [MKItemStore sharedStore].allItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSArray *items = [MKItemStore sharedStore].allItems;
    MKItem *item = items[indexPath.row];
    cell.textLabel.text = [item description];
    return cell;
}

@end
