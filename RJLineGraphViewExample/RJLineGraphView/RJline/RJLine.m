//
//  RJLine.m
//  RJLineGraphView
//
//  Created by Po on 2016/10/19.
//  Copyright © 2016年 Po. All rights reserved.
//

#import "RJLine.h"

@implementation RJLine

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getNormalAttribut];
    }
    return self;
}

- (void)getNormalAttribut {
    _attributDic = [NSMutableDictionary dictionaryWithDictionary:@{rjLineColor : [UIColor blackColor],
                                                                   rjLineWidth : @1,
                                                                   rjLineBackColor:[UIColor clearColor],
                                                                   rjLinePointBackColor:[UIColor greenColor],
                                                                   rjLinePointBorderColor:[UIColor whiteColor],
                                                                   rjLinePointBorderWidth:@1}];
    
}

- (void)setAttribut:(NSDictionary *)attributDic {
    NSArray * keys = @[rjLineColor, rjLineWidth,rjLineBackColor,rjLinePointBackColor,rjLinePointBorderWidth,rjLinePointBorderColor];
    for (NSString * key in attributDic) {
        if ([keys indexOfObject:key] != NSNotFound) {
            [_attributDic setObject:attributDic[key] forKey:key];
        }
    }
}

@end

NSString * const rjLineColor            = @"rjLineColor";                          //线条颜色
NSString * const rjLineWidth            = @"rjLineWidth";                          //线条宽度
NSString * const rjLineBackColor        = @"rjLineBackColor";                      //线条背景色

NSString * const rjLinePointBackColor   = @"rjLinePointBackColor";                 //点的颜色
NSString * const rjLinePointBorderColor = @"rjLinePointBorderColor";               //点的边界颜色
NSString * const rjLinePointBorderWidth = @"rjLinePointBorderWidth";               //点的边界宽度

