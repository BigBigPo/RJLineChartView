//
//  RJLineGraphView.m
//  RJLineGraphView
//
//  Created by Po on 2016/10/18.
//  Copyright © 2016年 Po. All rights reserved.
//

#import "RJLineGraphView.h"


#import "RJLineGraphConst.h"
#import "RJLineGraphHelper.h"
@interface RJLineGraphView () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView * scrollView;
@property (strong, nonatomic) RJContentView * contentView;                 //视图容器

@property (strong, nonatomic) RJLineGraphHelper * helper;

@end

@implementation RJLineGraphView

- (instancetype)initWithFrame:(CGRect)frame attribut:(NSDictionary *)attribut
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self setNoramlAttribut];
        [self setAttribut:attribut];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initData];
        [self setNoramlAttribut];
        [self setAttribut:@{}];
    }
    return self;
}


#pragma mark - user-define initialization
- (void)initData {
    _helper = [[RJLineGraphHelper alloc] init];
    _showPointBtn = NO;
    _showPointDetailBtn = NO;
    _scaleBtn = NO;
    _scrollBtn = YES;
    _isCircular = YES;
}

#pragma mark - event

#pragma mark - function
- (void)build {
    [self getScrollViewWithFrame:self.bounds];
    [_scrollView addSubview:[self getContentView]];
    [self updateWithScaleValue:1];
}

- (void)reBuild {
    [_contentView removeFromSuperview];
    _contentView = nil;
    [_scrollView removeFromSuperview];
    _scrollView = nil;
    [self build];
}

- (void)setLine:(RJLine *)line withAlpha:(CGFloat)alpha {
    NSString * label = line.userLabel;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RJChangeLineNotificationID" object:nil userInfo:@{@"label":label,@"alpha":@(alpha)}];
}

- (void)updateWithScaleValue:(CGFloat)scaleValue {
    if (!_yLabelViewFollowScroll) {
        CGRect rect = _contentView.vViewNormalFrame;
        rect.origin.x = _scrollView.contentOffset.x / scaleValue;
        rect.size.width = rect.size.width / scaleValue;
        [_contentView.vView changeFrame:rect scaleValue:scaleValue];
    }
    
    if (!_xLabelViewFollowScroll) {
        CGRect rect = _contentView.hViewNormalFrame;
        rect.origin.y = (_scrollView.contentOffset.y + _scrollView.frame.size.height)/ scaleValue - rect.size.height;
        rect.origin.x = rect.origin.x /scaleValue;
        [_contentView.hView changeFrame:rect scaleValue:scaleValue];
    }
}

#pragma mark - delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scaleValue = scrollView.zoomScale;
    [self updateWithScaleValue:scaleValue];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _contentView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat scaleValue = scrollView.zoomScale;
    CGRect yRect = _contentView.vViewNormalFrame;
    if (!_yLabelViewFollowScroll) {
        yRect.origin.x = scrollView.contentOffset.x / scaleValue;
        yRect.size.width = yRect.size.width / scaleValue;
        [_contentView.vView changeFrame:yRect scaleValue:scaleValue];
    }
    
    CGRect xRect = _contentView.hViewNormalFrame;
    if (!_xLabelViewFollowScroll) {
        xRect.origin.y = (scrollView.contentOffset.y + scrollView.frame.size.height)/ scaleValue - xRect.size.height;
        xRect.origin.x = xRect.origin.x /scaleValue;
        
        [_contentView.hView changeFrame:xRect scaleValue:scaleValue];
    }
    
    CGRect mainViewRect = _contentView.mainViewNormalFrame;
    mainViewRect.origin.x = mainViewRect.origin.x / scaleValue;
    mainViewRect.origin.y = mainViewRect.origin.y / scaleValue;
    [_contentView.mainView changeFrame:mainViewRect];
}


#pragma mark - notification

#pragma mark - setter
- (void)setAttribut:(NSDictionary *)attribut {
    NSArray * keys = @[rjBackGounrdColor,
                       rjBackLineColor,
                       rjBackLineWidth,
                       rjHorizonInterval,
                       rjHorizonLabelFont,
                       rjHorizonLabelColor,
                       rjHorizonHeight,
                       rjHorizontalLabelsTitle,
                       rjVerticalLabelFont,
                       rjVerticalLabelColor,
                       rjVerticalMinValue,
                       rjVerticalMaxValue,
                       rjVerticalRankNum,
                       rjVerticalHeight,
                       rjVerticalWidth,
                       rjVerticalBorderColor,
                       rjHorizonBorderColor,
                       rjVerticalBackgroundColor,
                       rjHorizonBackgroundColor,
                       rjVerticalTopMargin
                       ];
    for (NSString * key in [attribut allKeys]) {
        if ([keys indexOfObject:key] != NSNotFound) {
            NSObject * value = attribut[key];
            [_helper.panelAttributDic setObject:value forKey:key];
        }
    }
}

- (BOOL)addLine:(RJLine *)line {
    if (!line) {
        return NO;
    }
    
    NSInteger count = [_helper.panelAttributDic[rjHorizontalLabelsTitle] count];
    if (line.values.count != count) {
        return NO;
    }
    
    [_helper.linesArray addObject:line];
    return YES;
}

- (RJLine *)addLineWithValue:(NSArray *)values attributs:(NSDictionary *)attributs {
    NSString * label = [NSString stringWithFormat:@"%@",@(_helper.linesArray.count + 1)];
    RJLine * line = [self addLineWithValue:values attributs:attributs userLabel:label];
    return line;
}

- (RJLine *)addLineWithValue:(NSArray *)values attributs:(NSDictionary *)attributs userLabel:(NSString *)userLabel {
    NSInteger count = [_helper.panelAttributDic[rjHorizontalLabelsTitle] count];
    if (values.count != count) {
        NSLog(@"折线数据不完整");
        return nil;
    }
    
    RJLine * line = [[RJLine alloc] init];
    line.values = [NSArray arrayWithArray:values];
    
    if (attributs) {
        [line setAttribut:attributs];
    }
    line.userLabel = userLabel;
    [_helper.linesArray addObject:line];
    return line;
}

#pragma mark - getter
- (UIScrollView *)getScrollViewWithFrame:(CGRect)frame {
    if (!_scrollView) {
        NSArray * hLabels = _helper.panelAttributDic[rjHorizontalLabelsTitle];
        NSInteger hLabelsCount = hLabels.count;
        CGFloat hInterval = [_helper.panelAttributDic[rjHorizonInterval] floatValue];
        CGFloat width = [_helper.panelAttributDic[rjVerticalWidth] floatValue] + hInterval * (hLabelsCount + 1);
        CGFloat topMargin = [_helper.panelAttributDic[rjVerticalTopMargin] floatValue];
        
        CGFloat height = [_helper.panelAttributDic[rjVerticalHeight] floatValue] + [_helper.panelAttributDic[rjHorizonHeight] floatValue] + topMargin;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_scrollView setDelegate:self];
        [_scrollView setContentSize:CGSizeMake(width, height)];
        [_scrollView setContentOffset:CGPointMake(0, height - self.frame.size.height)];
        [_scrollView setBounces:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setScrollEnabled:_scrollBtn];
        if (_scaleBtn) {
            [_scrollView setMinimumZoomScale:1];
            [_scrollView setMaximumZoomScale:1.5];
        }
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (RJContentView *)getContentView {
    if (!_contentView) {
        CGSize size = _scrollView.contentSize;
        _contentView = [[RJContentView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height) withAttribut:_helper.panelAttributDic];
        [_contentView setData:_helper.linesArray];
        _contentView.showPointBtn = _showPointBtn;
        _contentView.showPointDetailBtn = _showPointDetailBtn;
        _contentView.isCircular = _isCircular;
        [_contentView build];
    }
    return _contentView;
}

- (void)setNoramlAttribut {
    _helper.panelAttributDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                   rjBackGounrdColor:[UIColor whiteColor],
                                                                   rjBackLineColor:[UIColor grayColor],
                                                                   rjBackLineWidth:@1,
                                                                   rjHorizonBackgroundColor:[UIColor clearColor],
                                                                   rjHorizonInterval:@40,
                                                                   rjHorizonLabelFont:@12,
                                                                   rjHorizonLabelColor:[UIColor blackColor],
                                                                   rjHorizonHeight:@50,
                                                                   rjHorizontalLabelsTitle:@[],
                                                                   rjVerticalBackgroundColor:[UIColor clearColor],
                                                                   rjVerticalLabelFont:@12,
                                                                   rjVerticalLabelColor:[UIColor grayColor],
                                                                   rjVerticalMinValue:@0,
                                                                   rjVerticalMaxValue:@100,
                                                                   rjVerticalRankNum:@5,
                                                                   rjVerticalHeight:@200,
                                                                   rjVerticalWidth:@50,
                                                                   rjVerticalBorderColor:[UIColor grayColor],
                                                                   rjHorizonBorderColor:[UIColor grayColor],
                                                                   rjVerticalTopMargin:@20
                                                                   }
                                                                   
                    ];
}

- (NSArray *)getAllLines {
    return _helper.linesArray;
}

- (void)removeAllLineData {
    [_helper.linesArray removeAllObjects];
}

- (void)setScaleBtn:(BOOL)scaleBtn {
    _scaleBtn = scaleBtn;
    [_scrollView setScrollEnabled:_scrollBtn];
    if (_scaleBtn) {
        [_scrollView setMinimumZoomScale:1];
        [_scrollView setMaximumZoomScale:1.5];
    } else {
        [_scrollView setMinimumZoomScale:1];
        [_scrollView setMaximumZoomScale:1.5];
    }
}
@end



































