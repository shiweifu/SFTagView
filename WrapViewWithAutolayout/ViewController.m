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
        view.backgroundColor = UIColor.cyanColor;
        view.padding    = UIEdgeInsetsMake(12, 12, 12, 12);
        view.insets    = 15;
        view.lineSpace = 10;
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
         tag.textColor = UIColor.whiteColor;
         tag.bgColor = UIColor.orangeColor;
         tag.padding = UIEdgeInsetsMake(13.5, 12.5, 13.5, 12.5);
         tag.target = self;
         tag.action = @selector(handleBtn:);
         tag.cornerRadius = 5;
         
         [self.tagView addTag:tag];
     }];
}

- (void)handleBtn:(UIButton *)btn
{
    NSLog(@"%@", btn.titleLabel.text);
}

@end
