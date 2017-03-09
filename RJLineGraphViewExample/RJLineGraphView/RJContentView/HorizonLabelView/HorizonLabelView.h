//
//  HorizonLabelView.h
//  RJLineGraphView
//
//  Created by Po on 2016/10/19.
//  Copyright © 2016年 Po. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizonLabelView : UIView

@property (assign, nonatomic) CGFloat interval;
@property (strong, nonatomic) NSArray * titles;
@property (assign, nonatomic) CGFloat fontSize;
@property (strong, nonatomic) UIColor * fontColor;
@property (strong, nonatomic) UIColor * mborderColor;

- (void)build;
- (void)changeFrame:(CGRect)frame scaleValue:(CGFloat)scaleValue;
@end
