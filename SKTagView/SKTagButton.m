//
// Created by Shaokang Zhao on 15/1/12.
// Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import "SKTagButton.h"
#import "SKTag.h"

@implementation SKTagButton

+ (instancetype)buttonWithTag:(SKTag *)tag
{
    SKTagButton *btn = [super buttonWithType:UIButtonTypeSystem];
    [btn setTitle:tag.text forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:tag.fontSize];
    btn.backgroundColor = tag.bgColor;
    btn.layer.cornerRadius = tag.cornerRadius;
    btn.layer.masksToBounds = YES;
    [btn setTitleColor:tag.textColor forState:UIControlStateNormal];
    [btn setContentEdgeInsets:tag.padding];
    
    return btn;
}

@end
