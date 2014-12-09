//
// Created by shiweifu on 12/9/14.
// Copyright (c) 2014 shiweifu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ViewController;


@interface SFTag : NSObject

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIColor *bgColor;

@property (nonatomic) float fontSize;

@property (nonatomic, strong) id target;

@property (nonatomic) SEL action;

- (instancetype)initWithText:(NSString *)text;

+ (instancetype)tagWithText:(NSString *)text;


@end
