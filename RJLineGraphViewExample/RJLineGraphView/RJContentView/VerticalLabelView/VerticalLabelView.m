//
//  VerticalLabelView.m
//  RJLineGraphView
//
//  Created by Po on 2016/10/19.
//  Copyright © 2016年 Po. All rights reserved.
//

#import "VerticalLabelView.h"
@interface VerticalLabelView()


@property (strong, nonatomic) NSArray * labels;

@end

@implementation VerticalLabelView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _interval = 40;
        _titles = @[];
        _fontSize = 12;
        _bottomMargin = 0;
        _fontColor = [UIColor blackColor];
        [self setClipsToBounds:YES];
    }
    return self;
}

- (void)changeFrame:(CGRect)frame scaleValue:(CGFloat)scaleValue{
    [self setFrame:frame];
    [_rightBorderLayer setFrame:CGRectMake(frame.size.width - 1, 0, 1, frame.size.height - _bottomMargin)];
    for (NSInteger i = 0; i < _labels.count; i ++) {
        UILabel * label = _labels[i];
        [label setFrame:CGRectMake(0, 0, self.frame.size.width - 1, _fontSize + 1)];
        CGFloat centerX = self.frame.size.width / 2;
        CGFloat centerY = self.frame.size.height - _interval * i - _bottomMargin;
        [label setCenter:CGPointMake(centerX, centerY)];
        [label setFont:[UIFont systemFontOfSize:_fontSize / scaleValue]];
    }
}

- (void)build {
    [self getRightBorderLine];
    NSMutableArray * array = [NSMutableArray array];
    for (NSInteger i = 0; i < _titles.count; i ++) {
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, _fontSize + 1)];
        [label setTextAlignment:NSTextAlignmentRight];
        [label setFont:[UIFont systemFontOfSize:_fontSize]];
        [label setTextColor:_fontColor];
        [label setText:_titles[i]];
        
        CGFloat centerX = self.frame.size.width / 2;
        CGFloat centerY = self.frame.size.height - _interval * i - _bottomMargin;
        [label setCenter:CGPointMake(centerX, centerY)];
        [self addSubview:label];
        [array addObject:label];
    }
    _labels = [NSArray arrayWithArray:array];
    
}

- (void)getRightBorderLine {
    _rightBorderLayer = [CALayer layer];
    [_rightBorderLayer setFrame:CGRectMake(self.frame.size.width - 1, 0, 1, self.frame.size.height - _bottomMargin)];
    [_rightBorderLayer setBackgroundColor:_mborderColor.CGColor];
    [self.layer addSublayer:_rightBorderLayer];
}
@end
