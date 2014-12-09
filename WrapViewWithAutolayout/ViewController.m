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
  [self.view setBackgroundColor:[UIColor blueColor]];

  [self setupTagView];

  self.tagView.margin    = UIEdgeInsetsMake(5, 5, 5, 5);
  self.tagView.insets    = 5;
  self.tagView.lineSpace = 10;

  [self.tagView setBackgroundColor:[UIColor redColor]];
  UIView *v = [UIView newAutoLayoutView];
  [v setBackgroundColor:[UIColor redColor]];
  [self.view addSubview:v];
  [v autoSetDimension:ALDimensionHeight toSize:50 relation:NSLayoutRelationEqual];
  [v autoSetDimension:ALDimensionWidth toSize:50 relation:NSLayoutRelationEqual];
  [v autoPinEdgeToSuperviewEdge:ALEdgeBottom];
  [v autoPinEdgeToSuperviewEdge:ALEdgeTrailing];

  self.testView = v;
}

- (void)setupTagView
{

  NSArray *texts = @[ @"A", @"Short", @"Button", @"Longer Button", @"Very Long Button", @"Short", @"More Button", @"Any Key"];

  [texts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
  {
    SFTag *tag = [SFTag tagWithText:obj];
    tag.textColor = [UIColor blackColor];
    tag.bgColor   = [UIColor yellowColor];
    tag.target    = self;
    tag.action  = @selector(handleBtn:);

    [self.tagView addTag:tag];
  }];

  [self.view addSubview:self.tagView];
  [self.tagView autoCenterInSuperview];
  [self.tagView autoSetDimension:ALDimensionWidth toSize:220];
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

@end
