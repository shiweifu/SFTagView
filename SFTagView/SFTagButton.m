//
// Created by shiweifu on 12/9/14.
// Copyright (c) 2014 shiweifu. All rights reserved.
//

#import "SFTagButton.h"
#import "SFTag.h"

@implementation SFTagButton

+ (instancetype)buttonWithTag:(SFTag *)tag
{
    SFTagButton *btn = [super buttonWithType:UIButtonTypeSystem];
    [btn setTitle:tag.text forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:tag.fontSize];
    btn.backgroundColor = tag.bgColor;
    [btn setTitleColor:tag.textColor forState:UIControlStateNormal];
    [btn addTarget:tag.target action:tag.action forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = tag.cornerRadius;
    btn.layer.masksToBounds = YES;
    
    return btn;
}

- (CGSize)intrinsicContentSize
{
    CGSize size = [super intrinsicContentSize];
    size.width += 10;
    return size;
}

@end
