//
// Created by shiweifu on 12/9/14.
// Copyright (c) 2014 shiweifu. All rights reserved.
//

#import "SFTag.h"


@implementation SFTag
{

}

- (instancetype)initWithText:(NSString *)text
{
  self = [super init];
  if (self)
  {
    _text          = text;
    self.font  = [UIFont systemFontOfSize:14];
    self.textColor = [UIColor blackColor];
    self.bgColor   = [UIColor whiteColor];
  }

  return self;
}

+ (instancetype)tagWithText:(NSString *)text
{
  return [[self alloc] initWithText:text];
}


@end