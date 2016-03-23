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

@interface ViewController ()
@property (strong, nonatomic) SFTagView *tagView;

@property (nonatomic, strong) UIView *testView;
@property (weak, nonatomic) IBOutlet UITextField *textField;


@end

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  [self.view setBackgroundColor:[UIColor whiteColor]];

  [self setupTagView];
  [self setupData];

  SFTagView *v = [[SFTagView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
  [v addTag:[[SFTag alloc] initWithText:@"hello"]];
  [v addTag:[[SFTag alloc] initWithText:@"hello"]];
  [v addTag:[[SFTag alloc] initWithText:@"hello"]];
  [v addTag:[[SFTag alloc] initWithText:@"hello"]];
  [v addTag:[[SFTag alloc] initWithText:@"hello"]];
  [v addTag:[[SFTag alloc] initWithText:@"hello"]];
  [v addTag:[[SFTag alloc] initWithText:@"hello"]];
  [v addTag:[[SFTag alloc] initWithText:@"hello"]];
  [v addTag:[[SFTag alloc] initWithText:@"hello"]];

  NSLog(@"tagView frame: %@", NSStringFromCGRect(v.frame));
}

- (void)setupTagView
{
  [self.view addSubview:self.tagView];
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
    _tagView = [[SFTagView alloc] initWithFrame:CGRectMake(0, 20, 320, 0)];
    [_tagView setBackgroundColor:[UIColor blueColor]];

      // alignment 0 左对齐布局 1 右对齐布局
      _tagView.alignment = 1;
      
    _tagView.margin    = UIEdgeInsetsMake(10, 3, 10, 3);
    _tagView.insets    = 20;
    _tagView.lineSpace = 5;
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

- (IBAction)handleAddTag:(id)sender
{
  if([self.textField.text isEqualToString:@"!"] )
  {
    [self.tagView removeAllTags];
  }

  SFTag *tag = [SFTag tagWithText:self.textField.text];
  tag.textColor = [UIColor tagTextColor];
  tag.bgColor = [UIColor tagBgColor];
  tag.target = self;
  tag.action = @selector(handleBtn:);
  tag.cornerRadius = 3;

  NSUInteger fontSize = arc4random() % 30;

  tag.font = [UIFont systemFontOfSize:fontSize];
  tag.inset = 10;

  [self.tagView addTag:tag];
  NSLog(@"tagView frame: %@", NSStringFromCGRect(self.tagView.frame));
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
