//
//  ZYLoopView.h
//  ZYMyScrollView
//
//  Created by WeiLuezh on 2017/11/8.
//  Copyright © 2017年 Yanyinghenmei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IMAGE_VIEW_CONTENT_MODEL UIViewContentModeScaleAspectFit

@interface ZYLoopView : UIView

// 图片显示模式
@property (nonatomic, assign)UIViewContentMode subImgViewContentModel;

@property (nonatomic, strong)UIPageControl *pageControl;

// 是否有小点
@property (nonatomic, assign)BOOL havePageControl;

// 点击回调
@property (nonatomic, copy)void(^imageClickBlock)(NSInteger index);


/**
 工厂模式初始化轮播图

 @param imageArr 源数据
 @param block 显示图片回调
 @return 轮播图
 */
+ (ZYLoopView *)loopViewWithFrame:(CGRect)frame
                         imageArr:(NSArray *)imageArr
                        showImage:(void(^)(UIImageView *imageView, id element))block;

- (void)setImageArr:(NSArray *)imageArr
          showImage:(void(^)(UIImageView *imageView, id element))block;

// 是否定时滚动
- (void)setTime:(NSTimeInterval)ti;
@end

