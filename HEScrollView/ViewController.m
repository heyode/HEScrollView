//
//  ViewController.m
//  HEScrollView
//
//  Created by heyode on 16/8/10.
//  Copyright © 2016年 heyode. All rights reserved.
//

#import "ViewController.h"
#import "HEScrollView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    HEScrollView *view = [[HEScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    NSMutableArray *images = [NSMutableArray array];
   NSMutableArray *pageImgs = [NSMutableArray array];
    NSMutableArray *pageCurrentImgs = [NSMutableArray array];
    for (int i = 0; i < 9; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"image-%d",i]];
        UIImage *pageImg = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        UIImage *pageCurrentImg = [UIImage imageNamed:[NSString stringWithFormat:@"%d_filled",i]];
        [images addObject:image];
        [pageImgs addObject:pageImg];
        [pageCurrentImgs addObject:pageCurrentImg];
    }
    
    // 设置图片
    view.images = images;
    // 设置页码高亮背景图
    view.pageLightImgs = pageCurrentImgs;
    // 设置页码普通背景图
    view.pageImgs = pageImgs;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
