//
// Created by Shaokang Zhao on 15/1/12.
// Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SKTag : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) UIEdgeInsets padding;
@property (nonatomic) float fontSize;

- (instancetype)initWithText:(NSString *)text;
+ (instancetype)tagWithText:(NSString *)text;

@end
