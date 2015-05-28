//
//  TagsTableViewController.m
//  WrapViewWithAutolayout
//
//  Created by Shaokang Zhao on 15/1/12.
//  Copyright (c) 2015年 shiweifu. All rights reserved.
//

#import "TagsTableViewController.h"
#import "TagsTableCell.h"
#import "SKTagView.h"
#import <HexColors/HexColor.h>

#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)

//Cell
static NSString *const kTagsTableCellReuseIdentifier = @"TagsTableCell";


@interface UIImage (SKTagView)
+ (UIImage *)imageWithColor:(UIColor *)color;
@end

@interface TagsTableViewController ()
@property (nonatomic, strong) NSArray *colorPool;
@end

@implementation TagsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.colorPool = @[@"#7ecef4", @"#84ccc9", @"#88abda",@"#7dc1dd",@"#b6b8de"];
    
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (void)configureCell:(TagsTableCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.tagView.preferredMaxLayoutWidth = SCREEN_WIDTH;
    cell.tagView.padding    = UIEdgeInsetsMake(12, 12, 12, 12);
    cell.tagView.insets    = 15;
    cell.tagView.lineSpace = 10;
    
    [cell.tagView removeAllTags];
    
    //Add Tags
    [@[@"Python", @"Javascript", @"HTML", @"Go", @"Objective-C",@"C", @"PHP"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         SKTag *tag = [SKTag tagWithText:obj];
         tag.textColor = [UIColor whiteColor];
         tag.fontSize = 15;
         tag.padding = UIEdgeInsetsMake(13.5, 12.5, 13.5, 12.5);
         tag.bgImg = [UIImage imageWithColor:[UIColor colorWithHexString:self.colorPool[idx % self.colorPool.count]]];
         tag.cornerRadius = 5;
         tag.enable = NO;
         
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
    if (!cell)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:kTagsTableCellReuseIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - User interactions
- (void)handleBtn:(id)sender
{
    NSLog(@"Tapped me");
}

@end

@implementation UIImage (SKTagView)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
