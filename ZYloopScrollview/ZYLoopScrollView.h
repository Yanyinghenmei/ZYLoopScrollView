//
//  ZYLoopScrollView.h
//  ZYMyScrollView
//
//  Created by Daniel on 16/2/22.
//  Copyright © 2016年 Yanyinghenmei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImageArrType) {
    ImageArrTypeName,
    ImageArrTypeUrl
};

#define IMAGE_VIEW_CONTENT_MODEL UIViewContentModeScaleAspectFit

@interface ZYLoopScrollView : UIScrollView

// 图片显示模式
@property (nonatomic, assign)UIViewContentMode subImgViewContentModel;

@property (nonatomic, strong)UIPageControl *pageControl;

// 是否有小点
@property (nonatomic, assign)BOOL havePageControl;

// 显示本地图片
+ (ZYLoopScrollView *)scrollViewWithFrame:(CGRect)frame urlArr:(NSArray *)urlArr;

// 显示网络图片
+ (ZYLoopScrollView *)scrollViewWithFrame:(CGRect)frame nameArr:(NSArray *)nameArr;

// 是否定时滚动
- (void)setTime:(NSTimeInterval)ti;

@end
