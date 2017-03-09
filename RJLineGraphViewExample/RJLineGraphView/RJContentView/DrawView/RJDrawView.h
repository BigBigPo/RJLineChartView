//
//  RJDrawView.h
//  RJLineGraphView
//
//  Created by Po on 2016/10/19.
//  Copyright © 2016年 Po. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJDrawView : UIView

@property (assign, nonatomic) NSInteger yRankNum;                //Y轴等级个数
@property (assign, nonatomic) CGFloat horizonItemWidth;          //X轴单位长度
@property (assign, nonatomic) CGFloat horizonItemHeight;         //X轴高度
@property (assign, nonatomic) CGFloat verticalItemHeight;        //Y轴单位长度
@property (assign, nonatomic) CGFloat verticalItemWidth;         //Y轴宽度

@property (assign, nonatomic) CGFloat backLineWidth;             //背景线宽度
@property (strong, nonatomic) UIColor * backLineColor;           //背景线颜色

@property (assign, nonatomic) CGFloat pixelSpace;                //真实距离
@property (assign, nonatomic) CGFloat valueSpace;                //值距离
@property (assign, nonatomic) CGFloat minValue;
@property (assign, nonatomic) CGFloat maxValue;

@property (assign, nonatomic) BOOL showPointBtn;                 //显示原点
@property (assign, nonatomic) BOOL showPointDetailBtn;           //显示原点详情
@property (assign, nonatomic) BOOL isCircular;                   //圆角


- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data;
- (void)build;
- (void)changeFrame:(CGRect)frame;
@end
