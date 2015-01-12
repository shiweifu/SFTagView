这个项目由[SFTagView](https://github.com/shiweifu/SFTagView)而来,修改了自动布局操作,添加单行支持,依赖Auto layout库[Masonry](https://github.com/Masonry/Masonry)。

当在UITableViewCell中使用多行模式时，请先设置preferredMaxLayoutWidth属性。

###使用说明

```objc
- (void)setupTagView
{
  self.tagView = ({
    SKTagView *view = [SKTagView new];
    view.backgroundColor = UIColor.cyanColor;
    view.padding    = UIEdgeInsetsMake(10, 25, 10, 25);
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
  [@[@"Python", @"Javascript", @"HTML", @"Go", @"Objective-C",@"C", @"PHP"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
  {
    SKTag *tag = [SKTag tagWithText:obj];
    tag.textColor = UIColor.whiteColor;
    tag.bgColor = UIColor.orangeColor;
    tag.target = self;
    tag.action = @selector(handleBtn:);
    tag.cornerRadius = 3;

    [self.tagView addTag:tag];
  }];
}
```

详情见图：

![预览图][1]


  [1]: http://7u2iw4.com1.z0.glb.clouddn.com/SKTagView.png
