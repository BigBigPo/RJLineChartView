//
//  RJLineGraphView.h
//  RJLineGraphView
//
//  Created by Po on 2016/10/18.
//  Copyright © 2016年 Po. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RJContentView.h"
#import "RJLine.h"


@interface RJLineGraphView : UIView

@property (assign, nonatomic) BOOL scaleBtn;                        //是否可缩放(默认:NO)
@property (assign, nonatomic) BOOL xLabelViewFollowScroll;          //X轴跟随滚动
@property (assign, nonatomic) BOOL yLabelViewFollowScroll;          //y轴跟随滚动
@property (assign, nonatomic) BOOL scrollBtn;                       //是否可以滚动

@property (assign, nonatomic) BOOL showPointBtn;                    //显示原点
@property (assign, nonatomic) BOOL showPointDetailBtn;              //显示原点详情
@property (assign, nonatomic) BOOL isCircular;                      //折线圆角


/**
 唯一初始化方式
 */
- (instancetype)initWithFrame:(CGRect)frame attribut:(NSDictionary *)attribut;

/**添加一条折线*/
- (BOOL)addLine:(RJLine *)line;
- (RJLine *)addLineWithValue:(NSArray *)values attributs:(NSDictionary *)attributs;
- (RJLine *)addLineWithValue:(NSArray *)values attributs:(NSDictionary *)attributs userLabel:(NSString *)userLabel;
/**设置样式*/
- (void)setAttribut:(NSDictionary *)attribut;

/**建立*/
- (void)build;
- (void)reBuild;


/**设置指定线条透明度*/
- (void)setLine:(RJLine *)line withAlpha:(CGFloat)alpha;
/**获取所有线条数组*/
- (NSArray *)getAllLines;
/**清空数据*/
- (void)removeAllLineData;
@end
