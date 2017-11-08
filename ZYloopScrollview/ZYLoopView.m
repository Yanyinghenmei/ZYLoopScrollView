//
//  ZYLoopView.m
//  ZYMyScrollView
//
//  Created by WeiLuezh on 2017/11/8.
//  Copyright © 2017年 Yanyinghenmei. All rights reserved.
//

#import "ZYLoopView.h"
#import "UIImageView+WebCache.h"

@interface ZYLoopView ()<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, assign)ImageArrType imageArrType;

@property (nonatomic, strong)NSArray *imageArr;

@property (nonatomic, strong)UIImageView *leftImageView;
@property (nonatomic, strong)UIImageView *middleImageView;
@property (nonatomic, strong)UIImageView *rightImageView;

@property (nonatomic, assign)int aCount;
@end

@implementation ZYLoopView

{
    CGFloat width;
    CGFloat height;
    NSTimer *timer;
}

+ (ZYLoopView *)loopViewWithFrame:(CGRect)frame nameArr:(NSArray *)nameArr {
    
    ZYLoopView *loopView = [[ZYLoopView alloc] initWithFrame:frame];
    loopView.imageArr = [loopView reSetImageArr:nameArr];
    loopView.imageArrType = ImageArrTypeName;
    [loopView setImageWithName];
    return loopView;
}

+ (ZYLoopView *)loopViewWithFrame:(CGRect)frame urlArr:(NSArray *)urlArr {
    
    ZYLoopView *loopView = [[ZYLoopView alloc] initWithFrame:frame];
    loopView.imageArr = [loopView reSetImageArr:urlArr];
    loopView.imageArrType = ImageArrTypeUrl;
    [loopView setImageWithUrl];
    return loopView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        width = frame.size.width;
        height = frame.size.height;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [self addSubview:_scrollView];
        
        _scrollView.contentSize = CGSizeMake(width * 3, height);
        _scrollView.contentOffset = CGPointMake(width, 0);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        //设置初始图片
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        _middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + width, 0, width, height)];
        _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + width *2, 0, width, height)];
        
        _leftImageView.contentMode = IMAGE_VIEW_CONTENT_MODEL;
        _middleImageView.contentMode = IMAGE_VIEW_CONTENT_MODEL;
        _rightImageView.contentMode = IMAGE_VIEW_CONTENT_MODEL;
        
        _leftImageView.clipsToBounds = true;
        _middleImageView.clipsToBounds = true;
        _rightImageView.clipsToBounds = true;
        
        [_scrollView addSubview:_leftImageView];
        [_scrollView addSubview:_middleImageView];
        [_scrollView addSubview:_rightImageView];
        
        _middleImageView.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(middleImageClick:)];
        [_middleImageView addGestureRecognizer:tap];
        
        //标记最左边的图片名再数组中的index
        _aCount = 0;
    }
    return self;
}

- (void)middleImageClick:(UIGestureRecognizer *)ges {
    if (_imageClickBlock) {
        _imageClickBlock(_aCount);
    }
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
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString: _imageArr[_aCount]] placeholderImage:_tempImage?_tempImage:nil];
    [_middleImageView sd_setImageWithURL:[NSURL URLWithString: _imageArr[_aCount+1]] placeholderImage:_tempImage?_tempImage:nil];
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString: _imageArr[_aCount+2]] placeholderImage:_tempImage?_tempImage:nil];
}

- (void)noData {
    NSLog(@"没有数据");
}

- (NSArray *)reSetImageArr:(NSArray *)arr {
    
    if (!arr.count) {
        [self noData];
        return nil;
    }
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
    [runloop addTimer:scrollTimer forMode:NSDefaultRunLoopMode];
}

- (void)timerAciton {
    [_scrollView scrollRectToVisible:CGRectMake(width * 2, 0, width, height) animated:YES];
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
    if (havePageControl) {
        if (!_pageControl) {
            _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, height - 44, width, 44)];
            _pageControl.alpha = .5;
            _pageControl.backgroundColor = [UIColor blackColor];
            _pageControl.numberOfPages = _imageArr.count - 2;
            _pageControl.currentPage = 0;
            
            [self addSubview:_pageControl];
        }
        _pageControl.hidden = NO;
    } else if (!havePageControl) {
        if (_pageControl) {
            _pageControl.hidden = YES;
        }
    }
}

- (void)addPageControlInSuperView {
    if (self.superview) {
        [self.superview addSubview:_pageControl];
        [timer invalidate];
    }
}


@end
