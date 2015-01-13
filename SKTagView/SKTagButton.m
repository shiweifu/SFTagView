//
// Created by Shaokang Zhao on 01/12/15.
// Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import "SKTagButton.h"
#import "SKTag.h"

@interface SKTagButton ()
@property (nonatomic, strong) SKTag *item;
@end

@implementation SKTagButton

+ (instancetype)buttonWithTag:(SKTag *)item
{
    SKTagButton *btn = [super buttonWithType:UIButtonTypeSystem];
    btn.item = item;
    [btn setTitle:item.text forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:item.fontSize];
    btn.backgroundColor = item.bgColor;
    [btn setTitleColor:item.textColor forState:UIControlStateNormal];
    [btn addTarget:item.target action:item.action forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = item.cornerRadius;
    btn.layer.masksToBounds = YES;
    [btn setContentEdgeInsets:item.padding];
    
    return btn;
}

- (CGSize)intrinsicContentSize
{
    CGSize size = [super intrinsicContentSize];
    size.width += 10;
    return size;
}

@end
