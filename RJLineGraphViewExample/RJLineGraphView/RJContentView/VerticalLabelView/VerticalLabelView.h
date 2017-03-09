//
//  VerticalLabelView.h
//  RJLineGraphView
//
//  Created by Po on 2016/10/19.
//  Copyright © 2016年 Po. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerticalLabelView : UIView
@property (strong, nonatomic) CALayer * rightBorderLayer;

@property (assign, nonatomic) CGFloat interval;
@property (strong, nonatomic) NSArray * titles;
@property (assign, nonatomic) CGFloat fontSize;
@property (strong, nonatomic) UIColor * fontColor;
@property (strong, nonatomic) UIColor * mborderColor;

@property (assign, nonatomic) CGFloat bottomMargin;




- (void)build;
- (void)changeFrame:(CGRect)frame scaleValue:(CGFloat)scaleValue;
@end
