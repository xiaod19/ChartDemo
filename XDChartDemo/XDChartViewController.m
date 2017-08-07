//
//  XDChartViewController.m
//  XDChartDemo
//
//  Created by xiaodan on 16/3/22.
//  Copyright © 2016年 hxd. All rights reserved.
//

#import "XDChartViewController.h"

@interface XDChartViewController ()

@end

@implementation XDChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    XDCircleChart *circleChart = [[XDCircleChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2, self.view.bounds.size.height/2) totalValue:100.0 currentValue:60.0];
    circleChart.center = self.view.center;
    [self.view addSubview:circleChart];
    circleChart.countLabelColor = [UIColor colorWithRed:32/255.0 green:32/255.0 blue:205/255.0 alpha:1];
    [circleChart performSelector:@selector(stroke) withObject:nil afterDelay:2];
//    [circleChart stroke];
    
   
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
