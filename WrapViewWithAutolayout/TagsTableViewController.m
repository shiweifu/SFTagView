//
//  TagsTableViewController.m
//  WrapViewWithAutolayout
//
//  Created by Shaokang Zhao on 15/1/12.
//  Copyright (c) 2015年 shiweifu. All rights reserved.
//

#import "TagsTableViewController.h"
#import "TagsTableCell.h"
#import "SKTag.h"
#import "SKTagView.h"
#import <HexColors/HexColor.h>

#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)

//Cell
static NSString *const kTagsTableCellReuseIdentifier = @"TagsTableCell";

@interface TagsTableViewController ()
@property (nonatomic, strong) NSArray *colorPool;
@end

@implementation TagsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colorPool = @[@"#7ecef4", @"#84ccc9", @"#88abda",@"#7dc1dd",@"#b6b8de"];
    
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)configureCell:(TagsTableCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.tagView.preferredMaxLayoutWidth = SCREEN_WIDTH;
    cell.tagView.padding    = UIEdgeInsetsMake(12, 12, 12, 12);
    cell.tagView.insets    = 15;
    cell.tagView.lineSpace = 10;
    
    [cell.tagView.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    
    //添加Tags
    [@[@"Python", @"Javascript", @"HTML", @"Go", @"Objective-C",@"C", @"PHP"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         SKTag *tag = [SKTag tagWithText:obj];
         tag.textColor = [UIColor whiteColor];
         tag.fontSize = 15;
         tag.padding = UIEdgeInsetsMake(13.5, 12.5, 13.5, 12.5);
         tag.bgColor = [UIColor colorWithHexString:self.colorPool[idx % self.colorPool.count]];
         tag.target = self;
         tag.action = @selector(handleBtn:);
         tag.cornerRadius = 5;
         
         [cell.tagView addTag:tag];
     }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TagsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kTagsTableCellReuseIdentifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TagsTableCell *cell = nil;
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:kTagsTableCellReuseIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
}

#pragma mark - User interactions
- (void)handleBtn:(id)sender
{
    NSLog(@"Tapped me");
}

@end
