//
//  RJContentView.h
//  RJLineGraphView
//
//  Created by Po on 2016/10/19.
//  Copyright © 2016年 Po. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RJDrawView.h"
#import "HorizonLabelView.h"
#import "VerticalLabelView.h"

UIKIT_EXTERN NSString * const rjBackGounrdColor;                    //背景颜色
UIKIT_EXTERN NSString * const rjBackLineColor;                      //背景线条颜色
UIKIT_EXTERN NSString * const rjBackLineWidth;                      //背景线条宽度
UIKIT_EXTERN NSString * const rjHorizonBorderColor;                 //背景边框颜色x
UIKIT_EXTERN NSString * const rjVerticalBorderColor;                //背景边框颜色y


UIKIT_EXTERN NSString * const rjVerticalWidth;                      //y轴宽度
UIKIT_EXTERN NSString * const rjHorizonHeight;                      //x轴高度

UIKIT_EXTERN NSString * const rjHorizonBackgroundColor;             //x轴背景颜色
UIKIT_EXTERN NSString * const rjHorizonInterval;                    //x轴标签间隔
UIKIT_EXTERN NSString * const rjHorizonLabelFont;                   //x轴标签字体
UIKIT_EXTERN NSString * const rjHorizonLabelColor;                  //x轴标签颜色

UIKIT_EXTERN NSString * const rjVerticalBackgroundColor;            //y轴背景颜色
UIKIT_EXTERN NSString * const rjVerticalLabelFont;                  //y轴标签字体
UIKIT_EXTERN NSString * const rjVerticalLabelColor;                 //y轴标签颜色
UIKIT_EXTERN NSString * const rjVerticalMinValue;                   //y轴最低值
UIKIT_EXTERN NSString * const rjVerticalMaxValue;                   //y轴最大值
UIKIT_EXTERN NSString * const rjVerticalRankNum;                    //等级个数
UIKIT_EXTERN NSString * const rjVerticalHeight;                     //y轴高度
UIKIT_EXTERN NSString * const rjVerticalTopMargin;                  //y轴上边距（默认20）

UIKIT_EXTERN NSString * const rjHorizontalLabelsTitle;              //水平个标签标题数组

@interface RJContentView : UIView

@property (strong, nonatomic) RJDrawView                    * mainView;         //主要绘图区
@property (strong, nonatomic) HorizonLabelView              * hView;            //水平标签区域
@property (strong, nonatomic) VerticalLabelView             * vView;            //垂直标签区域
@property (assign, nonatomic, readonly) CGRect mainViewNormalFrame;             //默认折线图区域大小
@property (assign, nonatomic, readonly) CGRect hViewNormalFrame;                //默认水平标签栏大小
@property (assign, nonatomic, readonly) CGRect vViewNormalFrame;                //默认垂直标签栏大小


@property (assign, nonatomic) BOOL showPointBtn;                    //显示原点
@property (assign, nonatomic) BOOL showPointDetailBtn;              //显示原点详情
@property (assign, nonatomic) BOOL isCircular;                      //折线圆角



- (instancetype)initWithFrame:(CGRect)frame withAttribut:(NSDictionary *)attribut;

- (void)setData:(NSArray *)data;

- (void)build;



@end
