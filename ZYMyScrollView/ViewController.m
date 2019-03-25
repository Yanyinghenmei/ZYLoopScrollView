//
//  ViewController.m
//  ZYMyScrollView
//
//  Created by qianfeng on 15/4/7.
//  Copyright (c) 2015年 Yanyinghenmei. All rights reserved.
//

#import "ViewController.h"
#import "ZYLoopView.h"
#import "UIImageView+WebCache.h"
#define selfWidth self.view.frame.size.width
#define selfHeight (self.view.frame.size.height-50)
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 本地图片
    NSArray *imageArr1 = @[@"0", @"1", @"2", @"3", @"4"];
    
    ZYLoopView *loopView = [ZYLoopView loopViewWithFrame:CGRectMake(0, 0, selfWidth, selfHeight/2)
                                                imageArr:imageArr1
                                               showImage:^(UIImageView *imageView, id element) {
        imageView.image = [UIImage imageNamed:element];
    }];
    loopView.havePageControl = true;
    loopView.subImgViewContentModel = UIViewContentModeScaleAspectFill;
    
    // 重复设置时间
    [loopView setTime:4];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [loopView setTime:4];
    });
    loopView.imageClickBlock = ^(NSInteger index) {
        NSLog(@"%ld", index);
    };
    [self.view addSubview:loopView];
    
    
    // 网络图片
    NSArray *imageArr2 = @[@"http://ppt360.com/background/UploadFiles_6733/201012/2010122016291897.jpg",
                           @"http://img15.3lian.com/2015/f1/173/89.jpg",
                           @"http://img2.3lian.com/2014/c7/76/13.jpg",
                           @"http://img15.3lian.com/2015/f1/173/89.jpg",
                           @"http://img15.3lian.com/2015/f1/173/89.jpg",
                           @"http://img2.3lian.com/2014/c7/76/13.jpg",
                           @"http://img2.3lian.com/2014/c7/76/13.jpg",
                           @"http://img2.3lian.com/2014/c7/76/13.jpg",
                           @"http://img2.3lian.com/2014/c7/76/13.jpg",
                           @"http://img2.3lian.com/2014/c7/76/13.jpg",];

    ZYLoopView *loopView2 = [[ZYLoopView alloc] initWithFrame:CGRectMake(0, selfHeight/2, selfWidth, selfHeight/2)];
    loopView2.havePageControl = true;
    loopView2.subImgViewContentModel = UIViewContentModeScaleAspectFill;
    [loopView2 setTime:4];
    [self.view addSubview:loopView2];
    
    [loopView2 setImageArr:imageArr2 showImage:^(UIImageView *imageView, id element) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:element]];
    }];
    
    // 重置
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray *imageArr2 = @[@"http://ppt360.com/background/UploadFiles_6733/201012/2010122016291897.jpg",
                      @"http://img15.3lian.com/2015/f1/173/89.jpg",
                      @"http://img2.3lian.com/2014/c7/76/13.jpg"];
        
        [loopView2 setImageArr:imageArr2 showImage:^(UIImageView *imageView, id element) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:element]];
        }];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
