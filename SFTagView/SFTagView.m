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

@interface SFTagView ()
@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic) BOOL didSetup;
@property (nonatomic) CGFloat intrinsicHeight;
@end

@implementation SFTagView

- (void)updateConstraints
{
    if(!self.didSetup)
    {
        if(self.tags.count > 0 && self.frame.size.width != 0)
        {
            [self updateWrappingConstrains];
        }
    }
    [super updateConstraints];
}

-(CGSize)intrinsicContentSize
{
    return CGSizeMake(self.frame.size.width, self.intrinsicHeight);
}

- (void)addTag:(SFTag *)tag
{
    SFTagButton *btn = [SFTagButton new];
    [btn setTitle:tag.text forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:tag.fontSize]];
    [btn setBackgroundColor:tag.bgColor];
    [btn setTitleColor:tag.textColor forState:UIControlStateNormal];
    [btn addTarget:tag.target action:tag.action forControlEvents:UIControlEventTouchUpInside];
    
    btn.layer.cornerRadius = tag.cornerRadius;
    [btn.layer setMasksToBounds:YES];
    
    [self addSubview:btn];
    [self.tags addObject:tag];
}

-(void)updateWrappingConstrains
{
    NSArray *subviews = self.subviews;
    UIView *previewsView = nil;
    UIView *superView = self;
    CGFloat leftOffset = self.margin.left;
    CGFloat bottomOffset = self.margin.bottom;
    CGFloat rightOffset = self.margin.right;
    CGFloat itemMargin = self.insets;
    CGFloat topPadding = self.margin.top;
    CGFloat itemVerticalMargin = self.lineSpace;
    CGFloat currentX = leftOffset;
    self.intrinsicHeight = topPadding;
    int lineIndex = 0;
    for (UIView *view in subviews) {
        CGSize size = view.intrinsicContentSize;
        if (previewsView) {
            CGFloat width = size.width;
            currentX += itemMargin;
            if (currentX + width + rightOffset <= CGRectGetWidth(self.frame)) {
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.leading.equalTo(previewsView.mas_trailing).with.offset(itemMargin);
                    make.centerY.equalTo(previewsView.mas_centerY);
                }];
                currentX += size.width;
            }else {
                //换行
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.greaterThanOrEqualTo(previewsView.mas_bottom).with.offset(itemVerticalMargin);
                    make.leading.equalTo(superView.mas_leading).with.offset(leftOffset);
                }];
                currentX = leftOffset + size.width;
                self.intrinsicHeight += size.height + itemVerticalMargin;
                lineIndex++;
            }
            
        }else {
            //第一次添加
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(superView.mas_top).with.offset(topPadding);
                make.leading.equalTo(superView.mas_leading).with.offset(leftOffset);
            }];
            self.intrinsicHeight += size.height;
            currentX += size.width;
        }
        
        previewsView = view;
    }
    
    UIView *lastView = subviews.lastObject;
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superView.mas_bottom).with.offset(bottomOffset);
    }];
    self.intrinsicHeight += bottomOffset;
    
    self.didSetup = YES;
    [self invalidateIntrinsicContentSize];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if(!self.didSetup)
    {
        if(self.frame.size.width != 0)
        {
            [self setNeedsUpdateConstraints];
        }
    }
}

- (NSMutableArray *)tags
{
    if(!_tags)
    {
        _tags = [NSMutableArray array];
    }
    return _tags;
}

@end
