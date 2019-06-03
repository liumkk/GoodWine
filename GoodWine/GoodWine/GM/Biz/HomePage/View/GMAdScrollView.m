//
//  GMAdScrollView.m
//  GoodWine
//
//  Created by LMK on 2019/5/28.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMAdScrollView.h"

#define Height    150.f*Auto_Size_Scale

@interface GMAdScrollView () <UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, strong) UIPageControl *pageControl;


@end

@implementation GMAdScrollView

- (instancetype)initWithFrame:(CGRect)frame pageNum:(NSInteger)pageNum {
    self = [super init];
    if (self) {
        self.pageNum = pageNum;
        self.contentSize = CGSizeMake(Width_Screen*pageNum, Height);
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.contentOffset = CGPointMake(0, 0);
        self.delegate = self;
        [self addImageButton];
        
        [self addTimer];
    }
    return self;
}

- (void)clickAdvertisingWithButton:(UIButton *)btn {
    MKNSLog(@"点击了%ld",(long)btn.tag);
    self.pageControl.numberOfPages = self.pageNum;
}

- (void)moving:(NSTimer *)timer {
    [self setContentOffset:CGPointMake(self.contentOffset.x + Width_Screen, 0) animated:YES];
}

- (void)addTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(moving:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)addImageButton {
    for (int i = 0; i < 5; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(Width_Screen * i, 0, Width_Screen, Height);
        button.tag = i + 1;
        [button setBackgroundImage:[UIImage imageNamed:@"test"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickAdvertisingWithButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

//有动画，并且动画结束的时候调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x >= Width_Screen * 4) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
//    _pageControl.currentPage = scrollView.contentOffset.x / _scrollView.frame.size.width;
    
}

//已经结束减速，只调用一次
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == self){
        NSLog(@"scrollview已经结束减速");
        
        //因为（手拖动）从最后一个跳到第0张的时候没有动画，不回去调用animation代理方法，所以需要我们手动从最后一张跳转到第0张
        if (scrollView.contentOffset.x >= Width_Screen * self.pageNum) {
            [scrollView setContentOffset:CGPointMake(0, 0)];
        }
        
//        _pageControl.currentPage = scrollView.contentOffset.x / _scrollView.frame.size.width;
    }else
    {
        NSLog(@"collection结束减速");
    }
}

- (void)pageChange:(UIPageControl* )page {
    //点击pageControl的时候改变scrollView的（偏移量）页面
    NSLog(@"%ld",(long)page.currentPage);
    //_scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width * page.currentPage, 0);
    [self setContentOffset:CGPointMake(Width_Screen * page.currentPage, 0) animated:YES];
}

- (UIPageControl *)pageControl {
    if (! _pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 120, Width_Screen, 30)];
        _pageControl.backgroundColor = [UIColor blackColor];
        _pageControl.numberOfPages = self.pageNum;
        //选中第几个按钮
        _pageControl.currentPage = 0;
        //单张图片的时候隐藏pageControl
        _pageControl.hidesForSinglePage = YES;
        //pageControl的按钮颜色
        _pageControl.pageIndicatorTintColor = [UIColor redColor];
        //设置选中按钮的颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
        //给pageControl绑定事件
        [_pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

@end
