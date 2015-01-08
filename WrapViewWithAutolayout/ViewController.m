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
#import <Masonry/Masonry.h>

@interface ViewController ()
@property (strong, nonatomic) SFTagView *tagView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTagView];
}

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

- (void)handleBtn:(UIButton *)btn
{
    NSLog(@"%@", btn.titleLabel.text);
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
