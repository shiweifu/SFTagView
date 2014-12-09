使用 AutoLayout 实现的 TagView，不用再使用CollectionView


###使用说明

```objc
- (void)setupTagView
{

  NSArray *texts = @[ @"A", @"Short", @"Button", @"Longer Button", @"Very Long Button", @"Short", @"More Button", @"Any Key"];

  [texts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
  {
    SFTag *tag = [SFTag tagWithText:obj];
    tag.textColor = [UIColor blackColor];
    tag.bgColor   = [UIColor yellowColor];

    [self.tagView addTag:tag];
  }];

  [self.view addSubview:self.tagView];

  [self.tagView autoCenterInSuperview];

  [self.tagView autoSetDimension:ALDimensionWidth toSize:220];
}
```

详情见图：

![预览图][1]


  [1]: http://leanote.com/file/outputImage?fileId=5487869e38f41171fd000263


###TODO
 - Podspec
 - 旋转屏幕支持

（本控件依赖 (PureLayout)[https://github.com/smileyborg/PureLayout] 布局库。）
