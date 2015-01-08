这个项目将[SFTagView](https://github.com/shiweifu/SFTagView)中依赖的Auto Layout库[PureLayout](https://github.com/smileyborg/PureLayout)改为[Masonry](https://github.com/Masonry/Masonry)。

###使用说明

```objc
- (void)setupTagView
{
  self.tagView = ({
    SFTagView *view = [SFTagView new];
    view.margin    = UIEdgeInsetsMake(10, 25, 10, 25);
    view.insets    = 5;
    view.lineSpace = 2;
    view;
  });
  [self.view addSubview:self.tagView];
  [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
    UIView *superView = self.view;
    make.center.equalTo(superView);
    make.leading.equalTo(superView.mas_leading);
    make.trailing.equalTo(superView.mas_trailing);
  }];

  //添加Tags
  [@[@"python", @"mysql", @"flask", @"django", @"bottle", @"webpy", @"php"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
  {
    SFTag *tag = [SFTag tagWithText:obj];
    tag.textColor = [UIColor tagTextColor];
    tag.bgColor = [UIColor tagBgColor];
    tag.target = self;
    tag.action = @selector(handleBtn:);
    tag.cornerRadius = 3;

    [self.tagView addTag:tag];
  }];
}
```

详情见图：

![预览图][1]


  [1]: http://leanote.com/file/outputImage?fileId=5487869e38f41171fd000263
