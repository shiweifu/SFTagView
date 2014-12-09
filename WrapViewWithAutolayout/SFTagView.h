//
//  SFTagView.h
//  WrapViewWithAutolayout
//
//  Created by shiweifu on 12/9/14.
//  Copyright (c) 2014 shiweifu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SFTag;

@interface SFTagView : UIView


@property (nonatomic) UIEdgeInsets margin;
@property (nonatomic) int lineSpace;
@property (nonatomic) float insets;

- (instancetype)initWithMargin:(UIEdgeInsets)margin
                     lineSpace:(int)lineSpace
                        insets:(float)insets;

+ (instancetype)viewWithMargin:(UIEdgeInsets)margin
                     lineSpace:(int)lineSpace
                        insets:(float)insets;

- (void)addTag:(SFTag *)tag;

@end
