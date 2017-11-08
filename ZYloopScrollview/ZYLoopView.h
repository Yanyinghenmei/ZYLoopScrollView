//
//  ZYLoopView.h
//  ZYMyScrollView
//
//  Created by WeiLuezh on 2017/11/8.
//  Copyright © 2017年 Yanyinghenmei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImageArrType) {
    ImageArrTypeName,
    ImageArrTypeUrl
};

#define IMAGE_VIEW_CONTENT_MODEL UIViewContentModeScaleAspectFit

@interface ZYLoopView : UIView

// 图片显示模式
@property (nonatomic, assign)UIViewContentMode subImgViewContentModel;

@property (nonatomic, strong)UIPageControl *pageControl;

// 是否有小点
@property (nonatomic, assign)BOOL havePageControl;

// 替换图片
@property (nonatomic, strong)UIImage *tempImage;

// 点击回调
@property (nonatomic, copy)void(^imageClickBlock)(NSInteger index);

// 显示网络图片
+ (ZYLoopView *)loopViewWithFrame:(CGRect)frame urlArr:(NSArray *)urlArr;

// 显示本地图片
+ (ZYLoopView *)loopViewWithFrame:(CGRect)frame nameArr:(NSArray *)nameArr;

// 是否定时滚动
- (void)setTime:(NSTimeInterval)ti;
@end

