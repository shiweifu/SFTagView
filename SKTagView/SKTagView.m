//
//  SKTagView.m
//
//  Created by Shaokang Zhao on 15/1/12.
//  Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import "SKTagView.h"
#import "SKTagButton.h"
#import <Masonry/Masonry.h>

#define SAVE_C(c) [self.tagsContraints addObject: c]

@interface SKTagView ()
@property (strong, nonatomic, nullable) NSMutableArray *tagsConstraints;
@property (strong, nonatomic, nullable) NSMutableArray *tags;
@property (assign, nonatomic) BOOL didSetup;
@end

@implementation SKTagView

#pragma mark - Lifecycle
- (void)updateConstraints {
    [self updateWrappingConstrains];
    [super updateConstraints];
}

-(CGSize)intrinsicContentSize {
    if (!self.tags.count) {
        return CGSizeZero;
    }
    
    NSArray *subviews = self.subviews;
    UIView *previousView = nil;
    CGFloat leftOffset = self.padding.left;
    CGFloat bottomOffset = self.padding.bottom;
    CGFloat rightOffset = self.padding.right;
    CGFloat itemSpacing = self.interitemSpacing;
    CGFloat topPadding = self.padding.top;
    CGFloat lineSpacing = self.lineSpacing;
    CGFloat currentX = leftOffset;
    CGFloat intrinsicHeight = topPadding;
    CGFloat intrinsicWidth = leftOffset;
    
    if (!self.singleLine && self.preferredMaxLayoutWidth > 0) {
        NSInteger lineCount = 0;
        for (UIView *view in subviews) {
            CGSize size = view.intrinsicContentSize;
            if (previousView) {
                CGFloat width = size.width;
                currentX += itemSpacing;
                if (currentX + width + rightOffset <= self.preferredMaxLayoutWidth) {
                    currentX += size.width;
                } else {
                    lineCount ++;
                    currentX = leftOffset + size.width;
                    intrinsicHeight += size.height;
                }
            } else {
                lineCount ++;
                intrinsicHeight += size.height;
                currentX += size.width;
            }
            previousView = view;
            intrinsicWidth = MAX(intrinsicWidth, currentX + rightOffset);
        }
        
        intrinsicHeight += bottomOffset + lineSpacing * (lineCount - 1);
    } else {
        for (UIView *view in subviews) {
            CGSize size = view.intrinsicContentSize;
            intrinsicWidth += size.width;
        }
        intrinsicWidth += itemSpacing * (subviews.count - 1) + rightOffset;
        intrinsicHeight += ((UIView *)subviews.firstObject).intrinsicContentSize.height + bottomOffset;
    }
    
    return CGSizeMake(intrinsicWidth, intrinsicHeight);
}

- (void)layoutSubviews {
    if (!self.singleLine) {
        self.preferredMaxLayoutWidth = self.frame.size.width;
    }
    
    [super layoutSubviews];
}

#pragma mark - Private
-(void)updateWrappingConstrains {
    if (self.didSetup || !self.tags.count) {
        return;
    }
    
    //Remove old constraints
    for (id obj in self.tagsConstraints) {
        if([obj isKindOfClass: MASConstraint.class]) {
            [(MASConstraint *)obj uninstall];
        } else if([obj isKindOfClass: NSArray.class]) {
            for (MASConstraint * constraint in (NSArray *)obj) {
                [constraint uninstall];
            }
        } else {
            NSAssert(NO, @"Error: unknown class type: %@",obj);
        }
    }
    [self.tagsConstraints removeAllObjects];
    
    //Install new constraints
    NSArray *subviews = self.subviews;
    UIView *previousView = nil;
    UIView *superView = self;
    CGFloat leftOffset = self.padding.left;
    CGFloat bottomOffset = self.padding.bottom;
    CGFloat rightOffset = self.padding.right;
    CGFloat itemSpacing = self.interitemSpacing;
    CGFloat topPadding = self.padding.top;
    CGFloat lineSpacing = self.lineSpacing;
    CGFloat currentX = leftOffset;
    
    if (!self.singleLine && self.preferredMaxLayoutWidth > 0) {
        for (UIView *view in subviews) {
            [view mas_makeConstraints: ^(MASConstraintMaker *make) {
                 SAVE_C(make.trailing.lessThanOrEqualTo(superView).with.offset(-rightOffset));
             }];
            
            CGSize size = view.intrinsicContentSize;
            if (previousView) {
                CGFloat width = size.width;
                currentX += itemSpacing;
                if (currentX + width + rightOffset <= self.preferredMaxLayoutWidth) {
                    [view mas_makeConstraints: ^(MASConstraintMaker *make) {
                        SAVE_C(make.leading.equalTo(previousView.mas_trailing).with.offset(itemSpacing));
                        SAVE_C(make.centerY.equalTo(previousView.mas_centerY));
                    }];
                    currentX += size.width;
                } else {
                    [view mas_makeConstraints: ^(MASConstraintMaker *make) {
                        SAVE_C(make.top.greaterThanOrEqualTo(previousView.mas_bottom).with.offset(lineSpacing));
                        SAVE_C(make.leading.equalTo(superView.mas_leading).with.offset(leftOffset));
                    }];
                    currentX = leftOffset + size.width;
                }
            } else {
                [view mas_makeConstraints: ^(MASConstraintMaker *make) {
                    SAVE_C(make.top.equalTo(superView.mas_top).with.offset(topPadding));
                    SAVE_C(make.leading.equalTo(superView.mas_leading).with.offset(leftOffset));
                }];
                currentX += size.width;
            }
            
            previousView = view;
        }
    } else {
        for (UIView *view in subviews) {
            CGSize size = view.intrinsicContentSize;
            if (previousView) {
                [view mas_makeConstraints: ^(MASConstraintMaker *make) {
                     SAVE_C(make.leading.equalTo(previousView.mas_trailing).with.offset(itemSpacing));
                     SAVE_C(make.centerY.equalTo(previousView.mas_centerY));
                 }];
                currentX += size.width;
            } else {
                [view mas_makeConstraints: ^(MASConstraintMaker *make) {
                     SAVE_C(make.top.equalTo(superView.mas_top).with.offset(topPadding));
                     SAVE_C(make.leading.equalTo(superView.mas_leading).with.offset(leftOffset));
                 }];
                currentX += size.width;
            }
            
            previousView = view;
        }
    }
    
    [previousView mas_makeConstraints: ^(MASConstraintMaker *make) {
         SAVE_C(make.bottom.equalTo(superView.mas_bottom).with.offset(-bottomOffset));
     }];
    
    self.didSetup = YES;
}

- (NSMutableArray *)tags {
    if(!_tags) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}

- (NSMutableArray *)tagsContraints {
    if(!_tagsConstraints) {
        _tagsConstraints = [NSMutableArray array];
    }
    return _tagsConstraints;
}

- (void)setPreferredMaxLayoutWidth: (CGFloat)preferredMaxLayoutWidth {
    if (preferredMaxLayoutWidth != _preferredMaxLayoutWidth) {
        _didSetup = NO;
        _preferredMaxLayoutWidth = preferredMaxLayoutWidth;
        [self setNeedsUpdateConstraints];
    }
}

- (void)onTag: (UIButton *)btn {
    if (self.didTapTagAtIndex) {
        self.didTapTagAtIndex([self.subviews indexOfObject: btn]);
    }
}

#pragma mark - Public
- (void)addTag: (SKTag *)tag {
    NSParameterAssert(tag);
    SKTagButton *btn = [SKTagButton buttonWithTag: tag];
    [btn addTarget: self action: @selector(onTag:) forControlEvents: UIControlEventTouchUpInside];
    [self addSubview: btn];
    [self.tags addObject: tag];
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

- (void)insertTag: (SKTag *)tag atIndex: (NSUInteger)index {
    NSParameterAssert(tag);
    if (index + 1 > self.tags.count) {
        [self addTag: tag];
    } else {
        SKTagButton *btn = [SKTagButton buttonWithTag: tag];
        [btn addTarget: self action: @selector(onTag:) forControlEvents: UIControlEventTouchUpInside];
        [self insertSubview: btn atIndex: index];
        [self.tags insertObject: tag atIndex: index];
        
        self.didSetup = NO;
        [self invalidateIntrinsicContentSize];
    }
}

- (void)removeTag: (SKTag *)tag {
    NSParameterAssert(tag);
    NSUInteger index = [self.tags indexOfObject: tag];
    if (NSNotFound == index) {
        return;
    }
    
    [self.tags removeObjectAtIndex: index];
    if (self.subviews.count > index) {
        [self.subviews[index] removeFromSuperview];
    }
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

- (void)removeTagAtIndex: (NSUInteger)index {
    if (index + 1 > self.tags.count) {
        return;
    }
    
    [self.tags removeObjectAtIndex: index];
    if (self.subviews.count > index) {
        [self.subviews[index] removeFromSuperview];
    }
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

- (void)removeAllTags {
    [self.tags removeAllObjects];
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

@end
