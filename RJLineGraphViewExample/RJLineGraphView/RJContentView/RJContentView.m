//
//  RJContentView.m
//  RJLineGraphView
//
//  Created by Po on 2016/10/19.
//  Copyright © 2016年 Po. All rights reserved.
//

#import "RJContentView.h"
@interface RJContentView ()

@property (strong, nonatomic) NSDictionary                  * attributDic;      //样式
@property (strong, nonatomic) NSArray                       * lineArray;        //折线数据数组



@end

@implementation RJContentView

- (instancetype)initWithFrame:(CGRect)frame withAttribut:(NSDictionary *)attribut
{
    self = [super initWithFrame:frame];
    if (self) {
        _attributDic = attribut;
        _showPointBtn = NO;
        _showPointDetailBtn = NO;
        _isCircular = YES;
    }
    return self;
}

#pragma mark - user-define initialization

#pragma mark - event

#pragma mark - function
- (void)build {
    [self addSubview:[self getDrawView]];
    [self addSubview:[self getHorizonLabelView]];
    [self addSubview:[self getVerticalLabelView]];
}

#pragma mark - delegate

#pragma mark - notification

#pragma mark - setter
- (void)setData:(NSArray *)data {
    _lineArray = [NSArray arrayWithArray:data];
}

#pragma mark - getter
- (RJDrawView *)getDrawView {
    if (!_mainView) {
        CGFloat Hheight = [_attributDic[rjHorizonHeight] floatValue];
        CGFloat Vwidth = [_attributDic[rjVerticalWidth] floatValue];
        _mainViewNormalFrame = CGRectMake(Vwidth, 0, self.bounds.size.width - Vwidth, self.bounds.size.height - Hheight);
        _mainView = [[RJDrawView alloc] initWithFrame:_mainViewNormalFrame
                                                 data:_lineArray];
        NSInteger rank = [_attributDic[rjVerticalRankNum] integerValue];
        CGFloat height = [_attributDic[rjVerticalHeight] floatValue];
        CGFloat eachHeight = height / (rank - 1);
        _mainView.yRankNum = rank;
        _mainView.verticalItemHeight = eachHeight;
        
        
        _mainView.horizonItemHeight = Hheight;
        
        CGFloat Hwidth = [_attributDic[rjHorizonInterval] floatValue];
        _mainView.horizonItemWidth = Hwidth;
        
        _mainView.verticalItemWidth = Vwidth;
        
        CGFloat minValue = [_attributDic[rjVerticalMinValue] floatValue];
        CGFloat maxValue = [_attributDic[rjVerticalMaxValue] floatValue];
        _mainView.minValue = minValue;
        _mainView.maxValue = maxValue;
        _mainView.valueSpace = maxValue - minValue;
        
        CGFloat yHeight = [_attributDic[rjVerticalHeight] floatValue];
        CGFloat xHeight = [_attributDic[rjHorizonHeight] floatValue];
        _mainView.pixelSpace = yHeight - xHeight + [_attributDic[rjVerticalTopMargin] floatValue];
        
        UIColor * backColor = _attributDic[rjBackGounrdColor];
        [_mainView setBackgroundColor:backColor];
        
        _mainView.showPointBtn = _showPointBtn;
        _mainView.showPointDetailBtn = _showPointDetailBtn;
        _mainView.isCircular = _isCircular;
        [_mainView build];
    }
    return _mainView;
}

- (VerticalLabelView *)getVerticalLabelView {
    if (!_vView) {
        CGFloat width = [_attributDic[rjVerticalWidth] floatValue];
        _vViewNormalFrame = CGRectMake(0, 0, width, self.frame.size.height);
        _vView = [[VerticalLabelView alloc] initWithFrame:_vViewNormalFrame];
        
        _vView.fontSize = [_attributDic[rjVerticalLabelFont] floatValue];
        _vView.fontColor = _attributDic[rjVerticalLabelColor];
        _vView.mborderColor = _attributDic[rjVerticalBorderColor];
        _vView.bottomMargin = [_attributDic[rjHorizonHeight] floatValue];
        
        NSInteger min = [_attributDic[rjVerticalMinValue] integerValue];
        NSInteger max = [_attributDic[rjVerticalMaxValue] integerValue];
        CGFloat rank = [_attributDic[rjVerticalRankNum] integerValue];
        CGFloat height = [_attributDic[rjVerticalHeight] floatValue];
        if (rank < 2) {
            rank = 2;
        }
        
        //计算间距
        CGFloat eachHeight = height / (rank - 1);
        _vView.interval = eachHeight;
        
        //获取标题
        NSInteger sumValue = max - min;
        NSInteger eachValue = sumValue / (rank - 1);
        NSMutableArray * titles = [NSMutableArray array];
        for (NSInteger i = 0; i < rank; i ++) {
            if (i == 0) {
                [titles addObject:[NSString stringWithFormat:@"%ld",min]];
            } else if (i == rank - 1) {
                [titles addObject:[NSString stringWithFormat:@"%ld",max]];
            } else  {
                NSInteger value = min + eachValue * i;
                [titles addObject:[NSString stringWithFormat:@"%ld", value]];
            }
        }
        _vView.titles = titles;
        [_vView build];
    }
    
    UIColor * color = _attributDic[rjVerticalBackgroundColor];
    [_vView setBackgroundColor:color];
    return _vView;
}

- (HorizonLabelView *)getHorizonLabelView {
    if (!_hView) {
        CGFloat width = [_attributDic[rjVerticalWidth] floatValue];
        CGFloat height = [_attributDic[rjHorizonHeight] floatValue];
        _hViewNormalFrame = CGRectMake(width,
                                       self.frame.size.height - height,
                                       self.frame.size.width - width,
                                       height);
        _hView = [[HorizonLabelView alloc] initWithFrame:_hViewNormalFrame];
        UIColor * color = _attributDic[rjHorizonBackgroundColor];
        [_hView setBackgroundColor:color];
        _hView.fontSize = [_attributDic[rjHorizonLabelFont] floatValue];
        _hView.fontColor = _attributDic[rjHorizonLabelColor];
        _hView.titles = _attributDic[rjHorizontalLabelsTitle];
        _hView.interval = [_attributDic[rjHorizonInterval] floatValue];
        _hView.mborderColor = _attributDic[rjHorizonBorderColor];
        [_hView build];
    }
    return _hView;
}



@end

NSString * const rjBackGounrdColor      = @"rjBackGounrdColor";                    //背景颜色
NSString * const rjBackLineColor        = @"rjBackLineColor";                      //背景线条颜色
NSString * const rjBackLineWidth        = @"rjBackLineWidth";                      //背景线条宽度
NSString * const rjHorizonBorderColor   = @"rjHorizonBorderColor";                 //x标签边框颜色
NSString * const rjVerticalBorderColor  = @"rjVerticalBorderColor";                //y标签边框颜色
NSString * const rjVerticalWidth        = @"rjVerticalWidth";                      //y轴宽度
NSString * const rjVerticalHeight       = @"rjVerticalHeight";                     //y轴高度


NSString * const rjHorizonHeight        = @"rjHorizonHeight";                      //x轴高度
NSString * const rjHorizontalLabelsTitle= @"rjHorizontalLabelsTitle";              //x轴标签标题
NSString * const rjHorizonBackgroundColor= @"rjHorizonBackgroundColor";            //x轴背景（默认透明）
NSString * const rjHorizonInterval      = @"rjHorizonInterval";                    //x轴标签间隔
NSString * const rjHorizonLabelFont     = @"rjHorizonLabelFont";                   //x轴标签字体
NSString * const rjHorizonLabelColor    = @"rjHorizonLabelColor";                  //x轴标签颜色


NSString * const rjVerticalBackgroundColor= @"rjVerticalBackgroundColor";          //y轴背景颜色
NSString * const rjVerticalLabelFont    = @"rjVerticalLabelFont";                  //y轴标签字体
NSString * const rjVerticalLabelColor   = @"rjVerticalLabelColor";                 //y轴标签颜色
NSString * const rjVerticalMinValue     = @"rjVerticalMinValue";                   //y轴最低值
NSString * const rjVerticalMaxValue     = @"rjVerticalMaxValue";                   //y轴最高值
NSString * const rjVerticalTopMargin    = @"rjVerticalTopMargin";                  //y轴上边距
NSString * const rjVerticalRankNum      = @"rjVerticalRankNum";                    //等级个数 (包括最低和最高 >= 2)










