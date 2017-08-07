//
//  XDCircleChart.m
//  XDChartDemo
//
//  Created by xiaodan on 16/3/21.
//  Copyright © 2016年 hxd. All rights reserved.
//

#import "XDCircleChart.h"

@implementation XDCircleChart
{
    CGFloat _num;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id) initWithFrame:(CGRect)frame totalValue:(CGFloat)total currentValue:(CGFloat)current;
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _total     = total;
        _current   = current;
        _duration  = 1.0;
        _lineWidth = 30.0;
        _countLabelColor = [UIColor blackColor];
        CGFloat position_x = frame.size.width/2;
        
        
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:self.center
                                                                  radius:position_x
                                                              startAngle: - M_PI/2
                                                                endAngle:3 * M_PI/2
                                                               clockwise:YES];

        CAGradientLayer *rightGradLayer = [CAGradientLayer layer];
        rightGradLayer.locations = @[@0.1];
        [rightGradLayer setColors:@[(id)[UIColor redColor].CGColor,(id)[UIColor yellowColor].CGColor]];
        rightGradLayer.bounds = CGRectMake(0, 0, 320, 320);
        rightGradLayer.position = self.center;
        
        
        _circel           = [CAShapeLayer layer];
        _circel.position = CGPointMake(50,0);
        _circel.frame = self.bounds;
        _circel.lineWidth = _lineWidth;
        _circel.path      = circlePath.CGPath;
        _circel.lineCap   = kCALineCapRound;
        _circel.fillColor = [UIColor clearColor].CGColor;
        _circel.lineCap   = kCALineCapRound;
        _circel.lineJoin  = kCALineJoinRound;
        _circel.zPosition = 1;
        _circel.frame = [_circel convertRect:_circel.bounds toLayer:rightGradLayer];
        rightGradLayer.mask = _circel;
        
        _circelbackgound             = [CAShapeLayer layer];
        _circelbackgound.frame       = self.bounds;
        _circelbackgound.lineWidth   = _lineWidth;
        _circelbackgound.path        = circlePath.CGPath;
        _circelbackgound.lineCap     = kCALineCapRound;
        _circelbackgound.fillColor   = [UIColor clearColor].CGColor;
        _circelbackgound.strokeColor = [UIColor lightGrayColor].CGColor;
        _circelbackgound.zPosition   = -1;
        _circelbackgound.strokeEnd   = 1;
 
        [self.layer addSublayer:_circelbackgound];
        [self.layer addSublayer:rightGradLayer];


        //进度百分数
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , frame.size.width, 14)];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.center = self.center;
        _countLabel.font = [UIFont boldSystemFontOfSize:15];
        _countLabel.textColor = _countLabelColor;
        _countLabel.text = [NSString stringWithFormat:@"%.0f%%",0.0];
        [self addSubview:_countLabel];
        
        
         }
    return self;
}

- (void)stroke{
    
    _circel.strokeEnd = _current / _total;
    _circel.strokeColor = [UIColor blackColor].CGColor;
    
    [self animationStart];
}

- (void)animationStart
{
//    CGAffineTransform transform1 = CGAffineTransformIdentity; //create a new transform
//    transform1 = CGAffineTransformScale(transform1, 2.0, 2.0); //scale by 50%
//    _circel.affineTransform = transform1;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.duration          = _duration;
    pathAnimation.fromValue         = [NSNumber numberWithFloat:0];
    pathAnimation.toValue           = [NSNumber numberWithFloat:0.6];
 
    
    CABasicAnimation *narrowAnimation   = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.beginTime           = 0;
    narrowAnimation.fromValue           = [NSNumber numberWithFloat:0.5f];
    narrowAnimation.duration            = _duration;
    narrowAnimation.removedOnCompletion = NO;
    narrowAnimation.delegate            = self;
    narrowAnimation.toValue             = [NSNumber numberWithFloat:1.0f];
    narrowAnimation.fillMode            = kCAFillModeForwards;
    /*
    kCAFillModeRemoved 这个是默认值,也就是说当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态
    kCAFillModeForwards 当动画结束后,layer会一直保持着动画最后的状态
    kCAFillModeBackwards 这个和kCAFillModeForwards是相对的,就是在动画开始前,你只要将动画加入了一个layer,layer便立即进入动画的初始状态并等待动画开始.你可以这样设定测试代码,将一个动画加入一个layer的时候延迟5秒执行.然后就会发现在动画没有开始的时候,只要动画被加入了layer,layer便处于动画初始状态
    kCAFillModeBoth 理解了上面两个,这个就很好理解了,这个其实就是上面两个的合成.动画加入后开始之前,layer便处于动画初始状态,动画结束后layer保持动画最后的状态.
     */
    
    
    CASpringAnimation *springAnimation = [CASpringAnimation animationWithKeyPath:@"strokeEnd"];
    springAnimation.damping            = 5;//阻尼系数，阻止弹簧伸缩的系数
    springAnimation.stiffness          = 100;//刚度系数(劲度系数/弹性系数)
    springAnimation.initialVelocity    = 1;//初始速率，动画视图的初始速度大小
    springAnimation.mass               = 1;//质量，影响图层运动时
    springAnimation.duration           = 1.5;
    springAnimation.beginTime          = 2;
    springAnimation.fromValue          = [NSNumber numberWithFloat:1.0f];
    springAnimation.toValue            = [NSNumber numberWithFloat:1.5f];
    
    
    
    
    CAAnimationGroup *groups   = [CAAnimationGroup animation];
    groups.animations          = @[pathAnimation];
    groups.duration            = _duration + 0.5;
    groups.removedOnCompletion = NO;
    groups.fillMode            = kCAFillModeForwards;
    groups.delegate            = self;
    [_circel addAnimation:groups forKey:@"group"];
    
    
    
//    CASpringAnimation *springAnimation2 = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
//    springAnimation2.damping            = 5;//阻尼系数，阻止弹簧伸缩的系数
//    springAnimation2.stiffness          = 100;//刚度系数(劲度系数/弹性系数)
//    springAnimation2.initialVelocity    = 1;//初始速率，动画视图的初始速度大小
//    springAnimation2.mass               = 1;//质量，影响图层运动时
//    springAnimation2.duration           = 1.5;
//    springAnimation2.beginTime          = 2;
//    springAnimation2.fromValue          = [NSNumber numberWithFloat:1.0f];
//    springAnimation2.toValue            = [NSNumber numberWithFloat:2.0f];

    
//    CGAffineTransform transform1 = CGAffineTransformIdentity; //create a new transform
//    transform1 = CGAffineTransformScale(transform1, 1.2, 1.2); //scale by 50%
//    _circel.affineTransform = transform1;
//
    [_circel addAnimation:springAnimation forKey:@"spring"];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_duration/100 target:self selector:@selector(labelChange) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)labelChange
{
    CGFloat scale = _current/_total;
    _num = _num + scale;
    _countLabel.text = [NSString stringWithFormat:@"%.0f%%",_num];
    if (_num >= _current) {
        _countLabel.text = [NSString stringWithFormat:@"%.0f%%",_current];
        
        [_timer invalidate];
        _timer = nil;
        return;
    }

}

@end
