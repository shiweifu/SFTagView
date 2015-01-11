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


@property (nonatomic, assign) UIEdgeInsets margin;
@property (nonatomic, assign) int lineSpace;
@property (nonatomic, assign) CGFloat insets;

- (void)addTag:(SFTag *)tag;

- (void)removeAllTags;

- (void)removeTagText:(NSString *)text;
@end

