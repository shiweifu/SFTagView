[DEPRECATED]  
[use https://github.com/shiweifu/DPTagView for insteaded.]

使用 View 实现的 Tag视图，不用再使用CollectionView

时过境迁，因为性能和复用性的考虑，本库去掉使用AutoLayout来实现，如果你想使用AutoLayout版，可以使用这个：[https://github.com/zsk425/SKTagView](https://github.com/zsk425/SKTagView)


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

![预览图][2]

![预览图][3]


  [1]: http://i3.tietuku.com/f55315bbb964ce21.jpg
  [2]: https://github.com/YiQieSuiYuan/SFTagView/blob/master/SFTagView-1.png
  [3]: https://github.com/YiQieSuiYuan/SFTagView/blob/master/SFTagView-2.png


Swift 正在更新中

