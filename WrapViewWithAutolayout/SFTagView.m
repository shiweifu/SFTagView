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

@property (nonatomic, strong) NSMutableArray *tags;
@property (assign) CGFloat intrinsicHeight;

@end

@implementation SFTagView
{
}

-(CGSize)intrinsicContentSize {
  return CGSizeMake(self.frame.size.width, self.intrinsicHeight);
}

- (void)addTag:(SFTag *)tag
{
  SFTagButton *btn = [[SFTagButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
  [btn setTitle:tag.text forState:UIControlStateNormal];
  [btn.titleLabel setFont:tag.font];
  [btn setBackgroundColor:tag.bgColor];
  [btn setTitleColor:tag.textColor forState:UIControlStateNormal];
  [btn addTarget:tag.target action:tag.action forControlEvents:UIControlEventTouchUpInside];

  CGSize size = [tag.text sizeWithFont:tag.font];
  CGFloat i = tag.inset;
  if(i == 0)
  {
    i = 5;
  }
  size.width  += i * 2;
  size.height += i * 2;

  btn.layer.cornerRadius = tag.cornerRadius;
  [btn.layer setMasksToBounds:YES];

//  CGSize size = btn.intrinsicContentSize;
  CGRect r = CGRectMake(0, 0, size.width, size.height);
  [btn setFrame:r];

  [self.tags addObject:btn];

  [self rearrangeTags];
}

#pragma mark - Tag removal

- (void)removeTagText:(NSString *)text
{
  SFTagButton *b = nil;
  for (SFTagButton *t in self.tags) {
    if([text isEqualToString:t.titleLabel.text])
    {
      b = t;
    }
  }

  if(!b)
  {
    return;
  }

  [b removeFromSuperview];
  [self.tags removeObject:b];
  [self rearrangeTags];
}

- (void)removeAllTags
{
  for (SFTagButton *t in self.tags) {
    [t removeFromSuperview];
  }
  [self.tags removeAllObjects];
  [self rearrangeTags];
}

- (void)rearrangeTags
{
  [self.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
    [obj removeFromSuperview];
  }];
  __block float maxY = self.margin.top;
  __block float maxX = self.margin.left;
  __block CGSize size;
  [self.tags enumerateObjectsUsingBlock:^(SFTagButton *obj, NSUInteger idx, BOOL *stop) {
    size = obj.frame.size;
    [self.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
      if ([obj isKindOfClass:[SFTagButton class]]) {
        maxY = MAX(maxY, obj.frame.origin.y);
      }
    }];

    [self.subviews enumerateObjectsUsingBlock:^(SFTagButton *obj, NSUInteger idx, BOOL *stop) {
      if ([obj isKindOfClass:[SFTagButton class]]) {
        if (obj.frame.origin.y == maxY) {
          maxX = MAX(maxX, obj.frame.origin.x + obj.frame.size.width);
        }
      }
    }];

    // Go to a new line if the tag won't fit
    if (size.width + maxX + self.insets > (self.frame.size.width - self.margin.right)) {
      maxY += size.height + self.lineSpace;
      maxX = self.margin.left;
    }
    obj.frame = (CGRect){maxX + self.insets, maxY, size.width, size.height};
    [self addSubview:obj];
  }];

  CGRect r = self.frame;
  CGFloat n = maxY + size.height + self.margin.bottom;
  self.intrinsicHeight = n > self.intrinsicHeight? n : self.intrinsicHeight;
  [self setFrame:CGRectMake(r.origin.x, r.origin.y, self.frame.size.width, self.intrinsicHeight)];
  NSLog(@"%@", NSStringFromCGRect(self.frame));
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  [self rearrangeTags];
}

- (NSMutableArray *)tags
{
  if(!_tags)
  {
    _tags = [NSMutableArray array];
  }
  return _tags;
}

@end
