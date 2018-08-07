//
//  HEScrollView.m
//  HEScrollView
//
//  Created by heyode on 16/8/10.
//  Copyright © 2016年 heyode. All rights reserved.
//

#import "HEScrollView.h"
#define COMMONMARGIN 10
static int const imageViewCount = 3;
static int const tagBase = 700;
#define ANIMATIONTIME 1.25
@interface HEScrollView()<UIScrollViewDelegate>
/** scrollView */
@property (nonatomic,weak) UIScrollView *scrollView;

/** 定时器 */
@property (nonatomic,strong) NSTimer *timer;

/** 页码 */
@property (nonatomic,weak) UIPageControl *pageControl;

@end

@implementation HEScrollView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        _scrollView = scrollView;
        for (int i = 0; i < imageViewCount; i++) {
            UIImageView *imageV = [[UIImageView alloc] init];
            [self.scrollView addSubview:imageV];
        }
        UIPageControl *pagcontrol = [[UIPageControl alloc] init];
        [self addSubview:pagcontrol];
        _pageControl = pagcontrol;
        [self addTimer];
        
    }
    return self;
}
- (void)stopTimer
{
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (void)addTimer
{
   self.timer =  [NSTimer timerWithTimeInterval:ANIMATIONTIME target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
- (void)nextPage
{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width*2, 0) animated:YES];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    self.scrollView.contentSize = CGSizeMake(imageViewCount * self.scrollView.frame.size.width, 0);
    
    for (int i = 0; i < imageViewCount; i++) {
        UIImageView *imageV = self.scrollView.subviews[i];
        imageV.frame = CGRectMake(i * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        
    }
    CGFloat pageControlH = 20;
    CGFloat pageControlW = self.scrollView.frame.size.width;
    CGFloat pageControlX = (self.scrollView.frame.size.width - pageControlW)/2;
    CGFloat pageControlY = self.scrollView.frame.size.height - pageControlH - COMMONMARGIN;
    
    self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
    [self refreshViewContent];
}

- (void)setImages:(NSArray *)images
{
    _images = images;
    
    self.pageControl.numberOfPages = images.count;
    self.pageControl.currentPage = 0;
    
    [self refreshViewContent];
}

- (void)setPageImgs:(NSArray *)pageImgs
{
    _pageImgs = pageImgs;
    
    [self.pageControl setValue:pageImgs forKey:@"_pageImages"];
    
}

- (void)setPageLightImgs:(NSArray *)pageLightImgs
{
    _pageLightImgs = pageLightImgs;
    [self.pageControl setValue:pageLightImgs forKey:@"_currentPageImages"];
}

- (void)refreshViewContent
{
    for (int i = 0; i < imageViewCount; i++) {
        NSInteger index = self.pageControl.currentPage;
        if (0 == i) { // 第一个图片控件设置为当前页的上一页内容
            index--;
        }else if (2 == i){ // 最后一个图片控件放下一页的内容
            index++;
        }
        if (index < 0) {
            index = self.pageControl.numberOfPages - 1;
        }else if (index >=self.pageControl.numberOfPages){
            index = 0;
        }
        UIImageView *imgV= self.scrollView.subviews[i];
        imgV.tag = index + tagBase;
        imgV.image = self.images[index];
        
    }
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
}

#pragma - <srcollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat minDistance = MAXFLOAT;
    NSInteger page = 0;
    for (int i = 0; i < imageViewCount; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        int distance = ABS(imageView.frame.origin.x - self.scrollView.contentOffset.x);
        if (distance < minDistance) {
            minDistance = distance;
           page = imageView.tag - tagBase;
        }
    }
    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
     [self addTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self refreshViewContent];
   
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self refreshViewContent];
}

@end
