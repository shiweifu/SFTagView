//
//  SFTagView.m
//  WrapViewWithAutolayout
//
//  Created by shiweifu on 12/9/14.
//  Copyright (c) 2014 shiweifu. All rights reserved.
//

#import "SFTagView.h"
#import "SFTag.h"
#import "ALView+PureLayout.h"
#import "SFTagButton.h"

@interface SFTagView ()

@property (nonatomic, strong) NSMutableArray *wrapConstrains;
@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic) BOOL didSetup;
@property (assign) CGFloat intrinsicHeight;

@end

@implementation SFTagView
{
}

- (instancetype)init
{
  self = [super init];
  if (self)
  {
    self.tags = [@[] mutableCopy];
    [self setBackgroundColor:[UIColor redColor]];
  }

  return self;
}


- (void)updateConstraints
{
  if(!self.didSetup)
  {
    if(self.tags.count > 0 && self.frame.size.width != 0)
    {
      [self updateWrappingConstrains];
    }
  }
  [super updateConstraints];
}

-(CGSize)intrinsicContentSize {
  return CGSizeMake(self.frame.size.width, self.intrinsicHeight);
}

- (void)addTag:(SFTag *)tag
{
  SFTagButton *btn = [SFTagButton newAutoLayoutView];
  [btn setTitle:tag.text forState:UIControlStateNormal];
  [btn.titleLabel setFont:[UIFont systemFontOfSize:tag.fontSize]];
  [btn setBackgroundColor:tag.bgColor];
  [btn setTitleColor:tag.textColor forState:UIControlStateNormal];
  [btn addTarget:tag.target action:tag.action forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:btn];
  [self.tags addObject:tag];
}

-(void)updateWrappingConstrains {
  NSArray *subviews = self.subviews;
  UIView *previewsView = nil;
  CGFloat leftOffset = self.margin.left;
  CGFloat bottomOffset = self.margin.bottom;
  CGFloat itemMargin = self.insets;
  CGFloat topPadding = self.margin.top;
  CGFloat itemVerticalMargin = self.lineSpace;
  CGFloat currentX = leftOffset;
  self.intrinsicHeight = topPadding;
  int lineIndex = 0;
  for (UIView *view in subviews) {
    CGSize size = view.intrinsicContentSize;
    if (previewsView) {
      [self.wrapConstrains addObject:[view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:topPadding relation:NSLayoutRelationGreaterThanOrEqual]];
      [self.wrapConstrains addObject:[view autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:leftOffset relation:NSLayoutRelationGreaterThanOrEqual]];

      CGFloat width = size.width;
      currentX += itemMargin;
      if (currentX + width <= CGRectGetWidth(self.frame)) {
        [self.wrapConstrains addObject:[view autoConstrainAttribute:ALEdgeLeading toAttribute:ALEdgeTrailing ofView:previewsView withOffset:itemMargin relation:NSLayoutRelationEqual]];
        [self.wrapConstrains addObject:[view autoAlignAxis:ALAxisBaseline toSameAxisOfView:previewsView]];
        currentX += size.width;
      }else {
        [self.wrapConstrains addObject: [view autoConstrainAttribute:ALEdgeTop toAttribute:ALEdgeBottom ofView:previewsView withOffset:itemVerticalMargin relation:NSLayoutRelationGreaterThanOrEqual]];
        currentX = leftOffset + size.width;
        self.intrinsicHeight += size.height + itemVerticalMargin;
        lineIndex++;
      }

    }else {
      [self.wrapConstrains addObject:[view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:topPadding relation:NSLayoutRelationEqual]];
      [self.wrapConstrains addObject:[view autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:leftOffset relation:NSLayoutRelationEqual]];
      self.intrinsicHeight += size.height;
      currentX += size.width;
    }

    previewsView = view;
  }

  UIView *lastView = subviews.lastObject;
  [lastView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:bottomOffset];
  self.intrinsicHeight += bottomOffset;

  self.didSetup = YES;
  [self invalidateIntrinsicContentSize];
}

-(void)setViews:(NSArray*)views {
  if (self.wrapConstrains.count > 0) {
//    [UIView autoRemoveConstraints:self.wrapConstrains];
    [self removeConstraints:self.wrapConstrains];
    [self.wrapConstrains removeAllObjects];
  }

  NSArray *subviews = self.subviews;
  for (UIView *view in subviews) {
    [view removeFromSuperview];
  }
  for (UIView *view in views) {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:view];
    CGFloat leftPadding = 0;
    [view autoSetDimension:ALDimensionWidth toSize:CGRectGetWidth(self.frame) - leftPadding relation:NSLayoutRelationLessThanOrEqual];
  }
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  if(!self.didSetup)
  {
    if(self.frame.size.width != 0)
    {
      [self setNeedsUpdateConstraints];
    }
  }
}

@end
