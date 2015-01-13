//
// Created by Shaokang Zhao on 01/12/15.
// Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SKTag;
@interface SKTagButton : UIButton
+ (instancetype)buttonWithTag:(SKTag *)item;

@property (nonatomic, strong, readonly) SKTag *item;

@end