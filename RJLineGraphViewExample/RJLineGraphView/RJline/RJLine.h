//
//  RJLine.h
//  RJLineGraphView
//
//  Created by Po on 2016/10/19.
//  Copyright © 2016年 Po. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const rjLineColor;                                    //线条颜色
UIKIT_EXTERN NSString * const rjLineWidth;                                    //线条宽度
UIKIT_EXTERN NSString * const rjLineBackColor;                                //线条背景色

UIKIT_EXTERN NSString * const rjLinePointBackColor;                           //点的颜色
UIKIT_EXTERN NSString * const rjLinePointBorderColor;                         //点的边界颜色
UIKIT_EXTERN NSString * const rjLinePointBorderWidth;                         //点的边界宽度



@interface RJLine : NSObject

@property (strong, nonatomic) NSArray               * values;                 //值
@property (strong, nonatomic) NSMutableDictionary   * attributDic;            //属性

@property (strong, nonatomic) NSString              * userLabel;              //自定义标示

- (void)setAttribut:(NSDictionary *)attributDic;
@end
