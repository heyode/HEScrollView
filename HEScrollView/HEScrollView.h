//
//  HEScrollView.h
//  HEScrollView
//
//  Created by heyode on 16/8/10.
//  Copyright © 2016年 heyode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HEScrollView : UIView
/** 图片数组 */
@property (nonatomic,strong) NSArray *images;
/** 页码正常状态的图片 */
@property (nonatomic,strong) NSArray *pageImgs;
/** 页码高亮状态的图片 */
@property (nonatomic,strong) NSArray *pageLightImgs;
@end
