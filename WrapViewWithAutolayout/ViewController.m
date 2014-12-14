//
//  ViewController.m
//  WrapViewWithAutolayout
//
//  Created by shiweifu on 12/9/14.
//  Copyright (c) 2014 shiweifu. All rights reserved.
//

#import "ViewController.h"
#import "SFTag.h"
#import "SFTagView.h"
#import "ALView+PureLayout.h"

@interface ViewController ()
@property (strong, nonatomic) SFTagView *tagView;

@property (nonatomic, strong) UIView *testView;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  [self.view setBackgroundColor:[UIColor whiteColor]];

  [self setupTagView];
  [self setupData];

  self.tagView.margin    = UIEdgeInsetsMake(10, 25, 10, 25);
  self.tagView.insets    = 5;
  self.tagView.lineSpace = 2;
}

- (void)setupTagView
{
  [self.view addSubview:self.tagView];
  [self.tagView autoCenterInSuperview];
  [self.tagView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
  [self.tagView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
}

- (void)handleBtn:(UIButton *)btn
{
  NSLog(@"%@", btn.titleLabel.text);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (SFTagView *)tagView
{
  if(!_tagView)
  {
    _tagView = [SFTagView newAutoLayoutView];
  }

  return _tagView;
}

- (void)viewDidLayoutSubviews
{
  [super viewDidLayoutSubviews];
}


- (void)setupData
{
  NSArray *texts = @[@"python", @"mysql", @"flask", @"django", @"bottle", @"webpy", @"php"];

  [texts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
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

@end

@implementation UIColor(Test)

+ (UIColor *)tagBgColor
{
  return [UIColor brownColor];
}

+ (UIColor *)tagTextColor
{
  return [UIColor whiteColor];
}

@end
