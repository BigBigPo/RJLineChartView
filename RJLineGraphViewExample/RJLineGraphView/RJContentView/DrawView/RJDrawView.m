//
//  RJDrawView.m
//  RJLineGraphView
//
//  Created by Po on 2016/10/19.
//  Copyright © 2016年 Po. All rights reserved.
//

#import "RJDrawView.h"
#import "RJLine.h"

#import "RJLineGraphConst.h"
@interface RJDrawView ()

@property (strong, nonatomic) UILabel * presentLabel;            //弹出框
@property (assign, nonatomic) BOOL isShowLabel;

@property (strong, nonatomic) CALayer * contentLayer;            //容器layer
@property (strong, nonatomic) NSArray * lineDataArray;           //线条数据

@property (strong, nonatomic) NSMutableArray * lineArray;        //线条数组
@property (strong, nonatomic) NSMutableArray * lineBackArray;    //线条背景数组
@property (strong, nonatomic) NSMutableArray * pointBtnArray;    //点数组


@end

@implementation RJDrawView

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RJChangeLineNotificationID" object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data{
    self = [super initWithFrame:frame];
    if (self) {
        _lineDataArray = [NSArray arrayWithArray:data];
        _pointBtnArray = [NSMutableArray array];
        _lineArray = [NSMutableArray array];
        _lineBackArray = [NSMutableArray array];
        _backLineColor = [UIColor grayColor];
        _backLineWidth = 0.5;
        _yRankNum = 3;
        _isShowLabel = NO;
        _isCircular = YES;
        
        [self setClipsToBounds:YES];
        _contentLayer = [CALayer layer];
        [_contentLayer setFrame:self.bounds];
        [self.layer addSublayer:_contentLayer];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RJChangeLineNotification:) name:@"RJChangeLineNotificationID" object:nil];
    }
    return self;
}

#pragma mark - user-define initialization
- (void)initData {
    
}

- (void)initInterface {
    
}

#pragma mark - event
- (void)pressDownPointButton:(UIButton *)sender {
    
    NSLog(@"点击了");
    if (_showPointDetailBtn) {
        if (_presentLabel) {
            [_presentLabel removeFromSuperview];
            _presentLabel = nil;
        }
        CGRect rect = [self convertRect:sender.frame toView:RJ_Window];
        CGFloat centerX = rect.origin.x + rect.size.width / 2;
        CGFloat centerY = rect.origin.y + rect.size.height / 2 - 60;
        
        [self getPresentLabel];
        [_presentLabel setCenter:CGPointMake(centerX, centerY)];
        [RJ_Window addSubview:_presentLabel];
    }
}

- (void)touchUpInsidePointButton:(UIButton *)sender {
    NSLog(@"松开了");
    if (_showPointDetailBtn) {
        if (_presentLabel) {
            [_presentLabel removeFromSuperview];
            _presentLabel = nil;
        }
    }
}

#pragma mark - function
- (void)build {
    [self configAllBackLine];
    [self buildAllLines];
}

- (void)changeFrame:(CGRect)frame {
    [self setFrame:frame];
}

- (void)buildAllLines {
    for (RJLine * line in _lineDataArray) {
        CGFloat selfHeight = self.frame.size.height;
        CAShapeLayer * layer = [CAShapeLayer layer];
        [layer setFrame:self.bounds];
        //线条样式设置
        UIColor * lineColor = line.attributDic[rjLineColor];
        [layer setStrokeColor:lineColor.CGColor];
        CGFloat lineWidth = [line.attributDic[rjLineWidth] floatValue];
        [layer setLineWidth:lineWidth];
        [layer setFillColor:[UIColor clearColor].CGColor];

        //初始化折线图原点，即折线图的(0,0)点
        CGFloat zeroX = 0;
        CGFloat zeroY = selfHeight;

        NSMutableArray * buttons = [NSMutableArray array];
        NSMutableArray * linePointsArray = [NSMutableArray array];
        [linePointsArray addObject:[NSValue valueWithCGPoint:CGPointMake(zeroX, zeroY)]];
        //遍历折线数据，整理出point数组，并获取其他相关数据
        for (NSInteger i = 0; i < line.values.count; i ++) {
            CGFloat num = [line.values[i] floatValue];
            CGFloat trueNum = fabs(_pixelSpace / _valueSpace * num);
            CGFloat x = zeroX + _horizonItemWidth * (i + 1);
            CGFloat y = (num < _minValue ? zeroY + trueNum: zeroY - trueNum);
            [linePointsArray addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
            //生成按钮
            if (_showPointBtn) {
                UIButton * button = [self createButtonWithCenter:CGPointMake(x, y)
                                                           radio:5
                                                       backColor:line.attributDic[rjLinePointBackColor]
                                                     borderColor:line.attributDic[rjLinePointBorderColor]
                                                     borderWidth:[line.attributDic[rjLinePointBorderWidth] floatValue]];
                [buttons addObject:button];
                [self addSubview:button];
            }
        }
        [_pointBtnArray addObject:buttons];
        
        UIBezierPath * path = [self getPathDataWithData:linePointsArray];
        path.lineWidth = lineWidth;
        [layer setPath:path.CGPath];
        
        
        //线条背景
        UIColor * backColor = line.attributDic[rjLineBackColor];
        if (!CGColorEqualToColor(backColor.CGColor, [UIColor clearColor].CGColor)) {
            [self getLineBackLayerWithColor:backColor path:path pointData:linePointsArray];
        }
        
        [_lineArray addObject:layer];
    }
    
    for (CALayer * layer in _lineArray) {
        //线条动画
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration = 1;
        animation.fromValue = @(0.0);
        animation.toValue = @(1.0);
        [layer addAnimation:animation forKey:@"strokeEnd"];
        [_contentLayer addSublayer:layer];
    }
}

- (UIBezierPath *)getPathDataWithData:(NSArray *)data {
    //曲线
    if (_isCircular) {
        return [self getCurvedPathWithData:data];
    }
    //折线
    return [self getLineGraphWithData:data];
}


/**
 生成折线数据

 @param data 点数据
 */
- (UIBezierPath *)getLineGraphWithData:(NSArray *)data {
    if (data.count == 0) {
        return [UIBezierPath bezierPath];
    }
    UIBezierPath * path = [UIBezierPath bezierPath];
    CGPoint zeroPoint = [data[0] CGPointValue];
    [path moveToPoint:zeroPoint];
    for (NSInteger i = 1; i < data.count; i ++) {
        CGPoint point = [data[i] CGPointValue];
        [path addLineToPoint:point];
    }
    return path;
}


/**
 生成曲线数据

 @param data 点数据
 */
- (UIBezierPath *)getCurvedPathWithData:(NSArray *)data
{
    if (data.count == 0) {
        return [UIBezierPath bezierPath];
    }
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSValue *value = data[0];
    CGPoint p1 = [value CGPointValue];
    [path moveToPoint:p1];
    
    if (data.count == 2) {
        value = data[1];
        CGPoint p2 = [value CGPointValue];
        [path addLineToPoint:p2];
        return path;
    }
    
    for (NSUInteger i = 1; i < data.count; i++) {
        value = data[i];
        CGPoint p2 = [value CGPointValue];
        
        CGPoint midPoint = midPointForPoints(p1, p2);
        [path addQuadCurveToPoint:midPoint controlPoint:controlPointForPoints(midPoint, p1)];
        [path addQuadCurveToPoint:p2 controlPoint:controlPointForPoints(midPoint, p2)];
        
        p1 = p2;
    }
    return path;
}

- (void)setLineWithCount:(NSInteger)count withAlpha:(CGFloat)alpha{
    ///目前只有显示隐藏功能
    BOOL hidden = alpha == 0;
    //线条
    CALayer * layer = _lineArray[count];
    [layer setHidden:hidden];
    
    //线条背景
    if (count < _lineBackArray.count) {
        CALayer * backLayer = _lineBackArray[count];
        [backLayer setHidden:hidden];
    }
    
    //按钮
    if (count < _pointBtnArray.count) {
        NSArray * array = _pointBtnArray[count];
        for (UIButton * button in array) {
            [button setHidden:hidden];
        }
    }
}

#pragma mark - notification
- (void)RJChangeLineNotification:(NSNotification *)notification {
    NSDictionary * userDic = notification.userInfo;
    NSString * userLabel = userDic[@"label"];
    NSString * alpha = userDic[@"alpha"];
    for (NSInteger i = 0; i < _lineDataArray.count; i ++) {
        RJLine * line = _lineDataArray[i];
        if ([line.userLabel isEqualToString:userLabel]) {
            [self setLineWithCount:i withAlpha:[alpha floatValue]];
        }
    }
}
#pragma mark - setter
- (UIButton *)createButtonWithCenter:(CGPoint)center
                               radio:(CGFloat)radio
                           backColor:(UIColor *)backColor
                         borderColor:(UIColor *)borderColor
                         borderWidth:(CGFloat)borderWidth {
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, radio * 2, radio * 2)];
    [button setCenter:center];
    [button setBackgroundColor:backColor];
    [button.layer setCornerRadius:radio];
    [button.layer setBorderColor:borderColor.CGColor];
    [button.layer setBorderWidth:borderWidth];
    [button addTarget:self action:@selector(pressDownPointButton:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(touchUpInsidePointButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - getter
- (UILabel *)getPresentLabel {
    if (!_presentLabel) {
        _presentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
        [_presentLabel setTextColor:[UIColor whiteColor]];
        [_presentLabel setBackgroundColor:[UIColor colorWithRed:30/255.0f green:32/255.0f blue:40/255.0f alpha:0.8]];
    }
    return _presentLabel;
}
/**背景线条*/
- (void)configAllBackLine {
    for (NSInteger i = 1; i < _yRankNum; i ++) {
        CALayer * layer = [CALayer layer];
        CGFloat y = self.frame.size.height  - _verticalItemHeight * i;
        [layer setFrame:CGRectMake(0, y, self.frame.size.width, _backLineWidth)];
        [layer setBackgroundColor:_backLineColor.CGColor];
        [self.layer insertSublayer:layer atIndex:0];
    }
}

/**显示线条背景*/
- (void)getLineBackLayerWithColor:(UIColor *)color path:(UIBezierPath *)path pointData:(NSArray *)pointData{
    CGPoint firstPoint = [[pointData firstObject] CGPointValue];
    CGPoint lastPoint = [[pointData lastObject] CGPointValue];
    
    CAShapeLayer * backLayer = [CAShapeLayer layer];
    [backLayer setFrame:self.bounds];
    //线条背景
    [backLayer setStrokeColor:[UIColor clearColor].CGColor];
    [backLayer setLineWidth:0.5];
    
    [backLayer setFillColor:color.CGColor];
    UIBezierPath * backPath = [UIBezierPath bezierPathWithCGPath:path.CGPath];
    [backPath moveToPoint:lastPoint];
    [backPath addLineToPoint:CGPointMake(lastPoint.x, firstPoint.y)];
    [backPath addLineToPoint:firstPoint];
    [backPath closePath];
    [backLayer setPath:backPath.CGPath];
    [_lineBackArray addObject:backLayer];
    [_contentLayer addSublayer:backLayer];
}


static CGPoint midPointForPoints(CGPoint p1, CGPoint p2) {
    return CGPointMake((p1.x + p2.x) / 2, (p1.y + p2.y) / 2);
}

static CGPoint controlPointForPoints(CGPoint p1, CGPoint p2) {
    CGPoint controlPoint = midPointForPoints(p1, p2);
    CGFloat diffY = fabs(p2.y - controlPoint.y);
    
    if (p1.y < p2.y)
        controlPoint.y += diffY;
    else if (p1.y > p2.y)
        controlPoint.y -= diffY;
    
    return controlPoint;
}
@end
