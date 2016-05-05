//
//  ViewController.m
//  ZYMyScrollView
//
//  Created by qianfeng on 15/4/7.
//  Copyright (c) 2015年 Yanyinghenmei. All rights reserved.
//

#import "ViewController.h"
#import "ZYLoopScrollView.h"
#define selfWidth self.view.frame.size.width
#define selfHeight self.view.frame.size.height
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:194/255.0 green:165/255.0 blue:107/255.0 alpha:1.0];
    
    // 本地图片
    NSArray *imageArr1 = @[@"0.jpg", @"1.png", @"2.png", @"3.png", @"4.png"];
    ZYLoopScrollView *loopScrollView = [ZYLoopScrollView scrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2) nameArr:imageArr1];
    loopScrollView.havePageControl = YES;
    loopScrollView.havePageControl = NO;
    [loopScrollView setTime:4];
    [self.view addSubview:loopScrollView];
    
    
    // 网络图片
    NSArray *imageArr2 = @[@"http://ppt360.com/background/UploadFiles_6733/201012/2010122016291897.jpg",
                           @"http://img15.3lian.com/2015/f1/173/89.jpg",
                           @"http://img2.3lian.com/2014/c7/76/13.jpg"];
    ZYLoopScrollView *loopScrollView2 = [ZYLoopScrollView scrollViewWithFrame:CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.height/2) urlArr:imageArr2];
    loopScrollView2.havePageControl = NO;
    loopScrollView2.havePageControl = YES;
    loopScrollView2.subImgViewContentModel = UIViewContentModeScaleToFill;
    [loopScrollView2 setTime:7];
    [self.view addSubview:loopScrollView2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
