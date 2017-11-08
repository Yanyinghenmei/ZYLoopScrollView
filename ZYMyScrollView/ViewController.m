//
//  ViewController.m
//  ZYMyScrollView
//
//  Created by qianfeng on 15/4/7.
//  Copyright (c) 2015年 Yanyinghenmei. All rights reserved.
//

#import "ViewController.h"
#import "ZYLoopView.h"
#define selfWidth self.view.frame.size.width
#define selfHeight self.view.frame.size.height
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 本地图片
    NSArray *imageArr1 = @[@"0", @"1", @"2", @"3", @"4"];
    
    ZYLoopView *loopView = [ZYLoopView loopViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2) nameArr:imageArr1];
    loopView.havePageControl = true;
    loopView.subImgViewContentModel = UIViewContentModeScaleAspectFill;
    [loopView setTime:4];
    loopView.imageClickBlock = ^(NSInteger index) {
        NSLog(@"%ld", index);
    };
    [self.view addSubview:loopView];
    
    
    // 网络图片
    NSArray *imageArr2 = @[@"http://ppt360.com/background/UploadFiles_6733/201012/2010122016291897.jpg",
                           @"http://img15.3lian.com/2015/f1/173/89.jpg",
                           @"http://img2.3lian.com/2014/c7/76/13.jpg"];
    ZYLoopView *loopView2 = [ZYLoopView loopViewWithFrame:CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.height/2) urlArr:imageArr2];
    loopView2.havePageControl = NO;
    loopView2.havePageControl = YES;
    loopView2.subImgViewContentModel = UIViewContentModeScaleAspectFill;
    [loopView2 setTime:4];
    [self.view addSubview:loopView2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
