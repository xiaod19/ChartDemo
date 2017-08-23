//
//  XDChartViewController.m
//  XDChartDemo
//
//  Created by xiaodan on 16/3/22.
//  Copyright © 2016年 hxd. All rights reserved.
//

#import "XDChartViewController.h"

@interface XDChartViewController ()
@property (strong, nonatomic) XDCircleChart *circleChart;
@end

@implementation XDChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(self.circleChart.frame) + 100, self.view.bounds.size.width - 50, 30)];
    [self.view addSubview:label];
    label.text = @"进度";
    UISlider *slider =  [[UISlider alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(self.circleChart.frame) + 100, self.view.bounds.size.width - 50, 30)];
    [self.view addSubview:slider];
    [slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)sliderValueChange:(UISlider *)slider
{
    NSLog(@"%f",slider.value);
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self.circleChart stroke];
}

-(XDCircleChart *)circleChart{
    if (_circleChart == nil) {
        _circleChart = [[XDCircleChart alloc] initWithFrame:CGRectMake(50, 64, self.view.bounds.size.width - 100, 300) totalValue:100.0 currentValue:60.0];
        _circleChart.countLabelColor = [UIColor colorWithRed:32/255.0 green:32/255.0 blue:205/255.0 alpha:1];
        [self.view addSubview:_circleChart];
    }
    return _circleChart;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
