## SKTagView

This project is derived from [SFTagView](https://github.com/shiweifu/SFTagView),which tries to build a view displaying tags without using UICollectionView and supports auto layout.It's a good begining,but not good enough.

So I try to make it more auto layout.After tring a lot,I inspired by UILabel.Now it just works like a UILabel and supports single line and multi-line.

### Installation with CocoaPods

```ruby
platform :ios, '7.0'
pod "SKTagView"
```

### Usage

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

  //Add Tags
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

### Tips
When use with UITableViewCell in multi-line mode,it MUST be set preferredMaxLayoutWidth before invoking
```objc
[cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
```

### Screenshot

![](https://raw.github.com/zsk425/SKTagView/master/Screenshots/example.png)

### License

AFNetworking is available under the MIT license. See the LICENSE file for more info.
