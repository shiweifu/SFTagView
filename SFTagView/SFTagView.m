//
//  SFTagView.m
//  WrapViewWithAutolayout
//
//  Created by shiweifu on 12/9/14.
//  Copyright (c) 2014 shiweifu. All rights reserved.
//

#import "SFTagView.h"
#import "SFTag.h"
#import "SFTagButton.h"
#import <Masonry/Masonry.h>

#define SAVE_C(c) [self.tagsConstraints addObject:c];

@interface SFTagView ()
@property (nonatomic, strong) NSMutableArray *tagsConstraints;
@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic) CGFloat intrinsicHeight;
@property (nonatomic) CGFloat intrinsicWidth;
@end

@implementation SFTagView

- (void)updateConstraints
{
    CGFloat width = 0.;
    if (self.superview.translatesAutoresizingMaskIntoConstraints && !self.widthConstraint)
    {
        width = CGRectGetWidth(self.superview.frame) - self.leftConstraint.constant - self.rightConstraint.constant;
    }
    else
    {
        width = self.widthConstraint.constant;
    }
    
    if(self.intrinsicWidth != width)
    {
        self.intrinsicWidth = width;
        [self updateTagsConstrains];
    }
    
    [super updateConstraints];
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(self.intrinsicWidth, self.intrinsicHeight);
}

- (void)addTag:(SFTag *)tag
{
    SFTagButton *btn = [SFTagButton buttonWithTag:tag];
    [self addSubview:btn];
    [self.tags addObject:tag];
}

-(void)updateTagsConstrains
{
    //Remove old constraints
    [self.tagsConstraints enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([obj isKindOfClass:MASConstraint.class])
        {
            [(MASConstraint *)obj uninstall];
        }
        else if([obj isKindOfClass:NSArray.class])
        {
            [(NSArray *)obj enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [(MASConstraint *)obj uninstall];
            }];
        }
        else
        {
            NSAssert(NO, @"ERROR:find new type:%@!!!",obj);
        }
    }];
    [self.tagsConstraints removeAllObjects];
    
    //Add new constraints
    NSArray *subviews = self.subviews;
    UIView *previewsView = nil;
    UIView *superView = self;
    CGFloat leftOffset = self.padding.left;
    CGFloat bottomOffset = self.padding.bottom;
    CGFloat rightOffset = self.padding.right;
    CGFloat itemMargin = self.insets;
    CGFloat topPadding = self.padding.top;
    CGFloat itemVerticalMargin = self.lineSpace;
    CGFloat currentX = leftOffset;
    self.intrinsicHeight = topPadding;
    int lineIndex = 0;
    for (UIView *view in subviews) {
        CGSize size = view.intrinsicContentSize;
        if (previewsView) {
            CGFloat width = size.width;
            currentX += itemMargin;
            if (currentX + width + rightOffset <= self.intrinsicWidth) {
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    SAVE_C(make.leading.equalTo(previewsView.mas_trailing).with.offset(itemMargin));
                    SAVE_C(make.centerY.equalTo(previewsView.mas_centerY));
                }];
                currentX += size.width;
            }else {
                //换行
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    SAVE_C(make.top.greaterThanOrEqualTo(previewsView.mas_bottom).with.offset(itemVerticalMargin));
                    SAVE_C(make.leading.equalTo(superView.mas_leading).with.offset(leftOffset));
                }];
                currentX = leftOffset + size.width;
                self.intrinsicHeight += size.height + itemVerticalMargin;
                lineIndex++;
            }
            
        }else {
            //第一次添加
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                SAVE_C(make.top.equalTo(superView.mas_top).with.offset(topPadding));
                SAVE_C(make.leading.equalTo(superView.mas_leading).with.offset(leftOffset));
            }];
            self.intrinsicHeight += size.height;
            currentX += size.width;
        }
        
        previewsView = view;
    }
    
    [previewsView mas_makeConstraints:^(MASConstraintMaker *make) {
        SAVE_C(make.bottom.equalTo(superView.mas_bottom).with.offset(-bottomOffset));
    }];
    self.intrinsicHeight += bottomOffset;
    
    [self invalidateIntrinsicContentSize];
}

- (NSMutableArray *)tags
{
    if(!_tags)
    {
        _tags = [NSMutableArray array];
    }
    return _tags;
}

- (NSMutableArray *)tagsConstraints
{
    if(!_tagsConstraints)
    {
        _tagsConstraints = [NSMutableArray array];
    }
    return _tagsConstraints;
}

#pragma mark - Private methods
- (NSLayoutConstraint *)widthConstraint
{
    NSLayoutConstraint *widthConstraint = nil;
    
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeWidth) {
            widthConstraint = constraint;
            break;
        }
    }
    
    return widthConstraint;
}

- (NSLayoutConstraint *)leftConstraint
{
    NSLayoutConstraint *leftConstraint = nil;
    
    for (NSLayoutConstraint *constraint in self.superview.constraints) {
        if (constraint.firstItem == self || constraint.secondItem == self) {
            if (constraint.firstAttribute == NSLayoutAttributeLeft || constraint.firstAttribute == NSLayoutAttributeLeading) {
                leftConstraint = constraint;
                break;
            }
        }
    }
    
    return leftConstraint;
}

- (NSLayoutConstraint *)rightConstraint
{
    NSLayoutConstraint *rightConstraint = nil;
    
    for (NSLayoutConstraint *constraint in self.superview.constraints) {
        if (constraint.firstItem == self || constraint.secondItem == self) {
            if (constraint.firstAttribute == NSLayoutAttributeRight || constraint.firstAttribute == NSLayoutAttributeTrailing) {
                rightConstraint = constraint;
                break;
            }
        }
    }
    
    return rightConstraint;
}

@end
