//
// Created by Shaokang Zhao on 15/1/12.
// Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SKTag : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSAttributedString *attributedText;
@property (nonatomic, strong) UIColor *textColor;
///backgound color
@property (nonatomic, strong) UIColor *bgColor;
///background image
@property (nonatomic, strong) UIImage *bgImg;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic) CGFloat borderWidth;
///like padding in css
@property (nonatomic) UIEdgeInsets padding;
@property (nonatomic, strong) UIFont *font;
///if no font is specified, system font with fontSize is used
@property (nonatomic) CGFloat fontSize;
///default:YES
@property (nonatomic) BOOL enable;

- (instancetype)initWithText:(NSString *)text;
+ (instancetype)tagWithText:(NSString *)text;

@end
