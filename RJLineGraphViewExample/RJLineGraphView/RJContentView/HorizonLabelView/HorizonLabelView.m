//
//  HorizonLabelView.m
//  RJLineGraphView
//
//  Created by Po on 2016/10/19.
//  Copyright © 2016年 Po. All rights reserved.
//

#import "HorizonLabelView.h"
@interface HorizonLabelView ()

@property (strong, nonatomic) CALayer * topBorderLayer;           //上方边界线
@property (strong, nonatomic) NSArray * labels;

@end

@implementation HorizonLabelView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _interval = 40;
        _titles = @[];
        _fontSize = 12;
        _fontColor = [UIColor blackColor];
        [self setClipsToBounds:YES];
        
    }
    return self;
}

- (void)changeFrame:(CGRect)frame scaleValue:(CGFloat)scaleValue{
    [self setFrame:frame];
    [_topBorderLayer setFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    for (NSInteger i = 0; i < _labels.count; i ++) {
        UILabel * label = _labels[i];
        [label setFrame:CGRectMake(0, 0, self.frame.size.width, _fontSize + 1)];
        CGFloat centerX = _interval * (i + 1);
        CGFloat centerY = _fontSize / 2 + 5;
        [label setCenter:CGPointMake(centerX, centerY)];
        [label setFont:[UIFont systemFontOfSize:_fontSize / scaleValue]];
    }
}

- (void)build {
    [self getTopBorderLine];
    NSMutableArray * array = [NSMutableArray array];
    for (NSInteger i = 0; i < _titles.count; i ++) {
        CGFloat centerX = _interval * (i + 1);
        CGFloat centerY = _fontSize / 2 + 5;
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _interval, _fontSize + 1)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont systemFontOfSize:_fontSize]];
        [label setTextColor:_fontColor];
        [label setText:_titles[i]];
        [label setCenter:CGPointMake(centerX, centerY)];
        [self addSubview:label];
        [array addObject:label];
    }
    
    _labels = [NSArray arrayWithArray:array];
}

- (void)getTopBorderLine {
    _topBorderLayer = [CALayer layer];
    [_topBorderLayer setFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    [_topBorderLayer setBackgroundColor:_mborderColor.CGColor];
    [self.layer addSublayer:_topBorderLayer];
}

@end
