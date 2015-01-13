//
// Created by Shaokang Zhao on 01/12/15.
// Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SKTag : NSObject

///Your custom data
@property (nonatomic, copy) id data;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) UIEdgeInsets padding;
@property (nonatomic) float fontSize;
@property (nonatomic, weak) id target;
@property (nonatomic) SEL action;

- (instancetype)initWithText:(NSString *)text;
+ (instancetype)tagWithText:(NSString *)text;

@end
