//
// Created by shiweifu on 12/9/14.
// Copyright (c) 2014 shiweifu. All rights reserved.
//

#import "SFTagButton.h"


@implementation SFTagButton
{

}

- (CGSize)intrinsicContentSize
{
  CGSize size = [super intrinsicContentSize];
  size.width += 10;
  return size;
}

@end
