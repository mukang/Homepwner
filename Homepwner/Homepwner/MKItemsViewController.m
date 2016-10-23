//
//  MKItemsViewController.m
//  Homepwner
//
//  Created by 穆康 on 2016/10/13.
//  Copyright © 2016年 mukang. All rights reserved.
//

#import "MKItemsViewController.h"
#import "MKDetailViewController.h"
#import "MKItemStore.h"
#import "MKItem.h"

@interface MKItemsViewController ()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation MKItemsViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
//        for (int i=0; i<5; i++) {
//            [[MKItemStore sharedStore] createItem];
//        }
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        navItem.rightBarButtonItem = bbi;
        
        navItem.leftBarButtonItem = self.editButtonItem;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    UIView *header = self.headerView;
    self.tableView.tableHeaderView = header;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - dataSource

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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[MKItemStore sharedStore] allItems];
        MKItem *item = items[indexPath.row];
        [[MKItemStore sharedStore] removeItem:item];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[MKItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MKDetailViewController *detailVC = [[MKDetailViewController alloc] init];
    
    NSArray *items = [MKItemStore sharedStore].allItems;
    MKItem *selectedItem = items[indexPath.row];
    detailVC.item = selectedItem;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - actions

- (IBAction)addNewItem:(id)sender {
    MKItem *newItem = [[MKItemStore sharedStore] createItem];
    NSInteger lastRow = [[[MKItemStore sharedStore] allItems] indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

//- (IBAction)toggleEditingMode:(id)sender {
//    if (self.isEditing) {
//        [sender setTitle:@"Edit" forState:UIControlStateNormal];
//        [self setEditing:NO animated:YES];
//    } else {
//        [sender setTitle:@"Done" forState:UIControlStateNormal];
//        [self setEditing:YES animated:YES];
//    }
//}

#pragma mark - lazy

//- (UIView *)headerView {
//    if (!_headerView) {
//        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
//    }
//    return _headerView;
//}

@end
