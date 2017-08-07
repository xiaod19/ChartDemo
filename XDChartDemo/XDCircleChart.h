//
//  XDCircleChart.h
//  XDChartDemo
//
//  Created by xiaodan on 16/3/21.
//  Copyright © 2016年 hxd. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEGREES_TO_RADIANS(angle) ((angle) * 2 * M_PI)

@interface XDCircleChart : UIView

@property (assign, nonatomic) CGFloat        total;
@property (assign, nonatomic) CGFloat        current;
@property (assign, nonatomic) CGFloat        lineWidth;
@property (assign, nonatomic) NSTimeInterval duration;

@property (strong, nonatomic) UIColor        *countLabelColor;
@property (strong, nonatomic) NSTimer        *timer;
@property (strong, nonatomic) UILabel        *countLabel;
@property (strong, nonatomic) CAShapeLayer   *circel;
@property (strong, nonatomic) CAShapeLayer   *circelbackgound;


/**
 开始渲染
 */
- (void)stroke;

/**
 CircleChart初始化

 @param frame 位置，大小
 @param total 总进度
 @param current 当前进度
 @return return value description
 */
- (id) initWithFrame:(CGRect)frame totalValue:(CGFloat)total currentValue:(CGFloat)current;

@end
