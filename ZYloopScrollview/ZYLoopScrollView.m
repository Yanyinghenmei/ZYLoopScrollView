//
//  ZYLoopScrollView.m
//  ZYMyScrollView
//
//  Created by Daniel on 16/2/22.
//  Copyright © 2016年 Yanyinghenmei. All rights reserved.
//

#import "ZYLoopScrollView.h"
#import "UIImageView+WebCache.h"

@interface ZYLoopScrollView ()<UIScrollViewDelegate>

@property (nonatomic, assign)ImageArrType imageArrType;

@property (nonatomic, strong)NSArray *imageArr;

@property (nonatomic, strong)UIImageView *leftImageView;
@property (nonatomic, strong)UIImageView *middleImageView;
@property (nonatomic, strong)UIImageView *rightImageView;

@property (nonatomic, assign)int aCount;
@end

@implementation ZYLoopScrollView {
    CGFloat width;
    CGFloat height;
    NSTimer *timer;
}

+ (ZYLoopScrollView *)scrollViewWithFrame:(CGRect)frame nameArr:(NSArray *)nameArr {
    ZYLoopScrollView *loopScrollView = [[ZYLoopScrollView alloc] initWithFrame:frame];
    loopScrollView.imageArr = [loopScrollView reSetImageArr:nameArr];
    loopScrollView.imageArrType = ImageArrTypeName;
    [loopScrollView setImageWithName];
    return loopScrollView;
}

+ (ZYLoopScrollView *)scrollViewWithFrame:(CGRect)frame urlArr:(NSArray *)urlArr {
    ZYLoopScrollView *loopScrollView = [[ZYLoopScrollView alloc] initWithFrame:frame];
    loopScrollView.imageArr = [loopScrollView reSetImageArr:urlArr];
    loopScrollView.imageArrType = ImageArrTypeUrl;
    [loopScrollView setImageWithUrl];
    return loopScrollView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        width = frame.size.width;
        height = frame.size.height;
        
        self.contentSize = CGSizeMake(width * 3, height);
        self.contentOffset = CGPointMake(width, 0);
        self.delegate = self;
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        //设置初始图片
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        _middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + width, 0, width, height)];
        _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + width *2, 0, width, height)];
        
        _leftImageView.contentMode = IMAGE_VIEW_CONTENT_MODEL;
        _middleImageView.contentMode = IMAGE_VIEW_CONTENT_MODEL;
        _rightImageView.contentMode = IMAGE_VIEW_CONTENT_MODEL;
        
        [self addSubview:_leftImageView];
        [self addSubview:_middleImageView];
        [self addSubview:_rightImageView];
        
        //标记最左边的图片名再数组中的index
        _aCount = 0;
    }
    return self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == width * 2&&_aCount < _imageArr.count - 3) {
        _aCount++;
    } else if (scrollView.contentOffset.x == width * 2&&_aCount == _imageArr.count - 3) {
        _aCount = 0;
    } else if (scrollView.contentOffset.x == 0&&_aCount >= 1) {
        _aCount--;
    } else if (scrollView.contentOffset.x == 0&&_aCount == 0){
        _aCount = (int)_imageArr.count - 3;
    }
    
    scrollView.contentOffset = CGPointMake(width, 0);
    [self reSetImage];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    _aCount ++;
    if (_aCount == _imageArr.count - 2) {
        _aCount = 0;
    }
    
    scrollView.contentOffset = CGPointMake(width, 0);
    [self reSetImage];
}

- (void)setImageWithName {
    _leftImageView.image = [UIImage imageNamed:_imageArr[_aCount]];
    _middleImageView.image = [UIImage imageNamed:_imageArr[_aCount+1]];
    _rightImageView.image = [UIImage imageNamed:_imageArr[_aCount+2]];
}
- (void)setImageWithUrl {
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString: _imageArr[_aCount]]];
    [_middleImageView sd_setImageWithURL:[NSURL URLWithString: _imageArr[_aCount]]];
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString: _imageArr[_aCount]]];
}

- (NSArray *)reSetImageArr:(NSArray *)arr {
    NSMutableArray *newArr = arr.mutableCopy;
    [newArr addObject:arr.firstObject];
    [newArr insertObject:arr.lastObject atIndex:0];
    return newArr;
}

- (void)reSetImage {
    if (self.imageArrType==ImageArrTypeName) {
        [self setImageWithName];
    } else {
        [self setImageWithUrl];
    }
    
    if (_pageControl) {
        _pageControl.currentPage = _aCount;
    }
}

// 计时器
/*––––––––––––––––––––––––––––––––––––––––––––––––––––*/
- (void)setTime:(NSTimeInterval)ti {
    NSTimer *scrollTimer = [NSTimer timerWithTimeInterval:ti target:self selector:@selector(timerAciton) userInfo:nil repeats:YES];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:scrollTimer forMode:NSRunLoopCommonModes];
}

- (void)timerAciton {
    [self scrollRectToVisible:CGRectMake(width * 2, 0, width, height) animated:YES];
}

// 图片显示模式
- (void)setSubImgViewContentModel:(UIViewContentMode)subImgViewContentModel {
    _leftImageView.contentMode = subImgViewContentModel;
    _middleImageView.contentMode = subImgViewContentModel;
    _rightImageView.contentMode = subImgViewContentModel;
}

//
/*––––––––––––––––––––––––––––––––––––––––––––––––––––*/
- (void)setHavePageControl:(BOOL)havePageControl {
    if (havePageControl&&!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y+height - 44, width, 44)];
        _pageControl.alpha = .5;
        _pageControl.backgroundColor = [UIColor blackColor];
        _pageControl.numberOfPages = _imageArr.count - 2;
        _pageControl.currentPage = 0;
        
        timer = [NSTimer timerWithTimeInterval:.1 target:self selector:@selector(addPageControlInSuperView) userInfo:nil repeats:YES];
        NSRunLoop *currRL = [NSRunLoop currentRunLoop];
        [currRL addTimer:timer forMode:NSRunLoopCommonModes];
        [timer fire];
    }
}

- (void)addPageControlInSuperView {
    if (self.superview) {
        [self.superview addSubview:_pageControl];
        [timer invalidate];
    }
}


@end
