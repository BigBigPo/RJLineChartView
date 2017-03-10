//
//  ViewController.m
//  RJLineGraphViewExample
//
//  Created by Po on 2017/3/9.
//  Copyright © 2017年 Po. All rights reserved.
//

#import "ViewController.h"
#import "RJLineGraphView.h"

#define RJRGB(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface ViewController ()
@property (weak, nonatomic) IBOutlet RJLineGraphView *graphView;
@property (weak, nonatomic) IBOutlet RJLineGraphView *graphView1;
@property (weak, nonatomic) IBOutlet RJLineGraphView *graphView2;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidth;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_contentWidth setConstant:[UIScreen mainScreen].bounds.size.width];
    [self initData];
    [self initInterface];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - user-define initialization
- (void)initData {

}

- (void)initInterface {
    
    [self configGraphView];
    [self configGraphView1];
    [self configGraphView2];
}

#pragma mark - event

#pragma mark - function

#pragma mark - delegate

#pragma mark - notification

#pragma mark - setter
- (void)configGraphView {
   NSDictionary * attributs = @{
      rjBackGounrdColor:[UIColor whiteColor],
      rjBackLineColor:RJRGB(224, 224, 224, 1),
      rjBackLineWidth:@1,
      rjHorizonInterval:@45,
      rjHorizonLabelFont:@9,
      rjHorizonLabelColor:RJRGB(153, 153, 153, 1),
      rjHorizonHeight:@20,
      rjHorizontalLabelsTitle:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"],
      rjVerticalLabelFont:@9,
      rjVerticalLabelColor:RJRGB(153, 153, 153, 1),
      rjVerticalMinValue:@0,
      rjVerticalMaxValue:@100,
      rjVerticalRankNum:@5,
      rjVerticalHeight:@120,
      rjVerticalWidth:@25,
      rjVerticalBackgroundColor:[UIColor whiteColor],
      rjHorizonBackgroundColor:[UIColor whiteColor],
      rjVerticalBorderColor:[UIColor clearColor],
      rjHorizonBorderColor:RJRGB(224, 224, 224, 1)
      };
    
    [_graphView setAttribut:attributs];
    [_graphView addLineWithValue:@[@50,@40,@36,@32,@40,@44,@40] attributs:attributs];
    [_graphView reBuild];
}

- (void)configGraphView1 {
    NSDictionary * attributs = @{
                                 rjBackGounrdColor:[UIColor lightGrayColor],
                                 rjBackLineColor:RJRGB(224, 224, 224, 1),
                                 rjBackLineWidth:@1,
                                 rjHorizonInterval:@50,
                                 rjHorizonLabelFont:@9,
                                 rjHorizonLabelColor:RJRGB(153, 153, 153, 1),
                                 rjHorizonHeight:@20,
                                 rjHorizontalLabelsTitle:@[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l"],
                                 rjVerticalLabelFont:@9,
                                 rjVerticalLabelColor:[UIColor redColor],
                                 rjVerticalMinValue:@0,
                                 rjVerticalMaxValue:@200,
                                 rjVerticalRankNum:@5,
                                 rjVerticalHeight:@300,
                                 rjVerticalWidth:@25,
                                 rjVerticalBackgroundColor:[UIColor blueColor],
                                 rjHorizonBackgroundColor:[UIColor greenColor],
                                 rjVerticalBorderColor:RJRGB(224, 224, 224, 1),
                                 rjHorizonBorderColor:RJRGB(224, 224, 224, 1)
                                 };
    
    [_graphView1 setAttribut:attributs];
    _graphView1.isCircular = NO;
    _graphView1.scaleBtn = YES;
    _graphView1.showPointBtn = YES;
    _graphView1.showPointDetailBtn = YES;
    [_graphView1 addLineWithValue:@[@15,@100,@59,@80,@20,@73,@168,@111,@99,@200,@30,@50]
                        attributs:@{rjLineColor:[UIColor redColor]
                                    }];
    [_graphView1 addLineWithValue:@[@50,@50,@50,@100,@90,@173,@150,@100,@89,@99,@100,@90]
                        attributs:@{rjLineColor:[UIColor magentaColor],
                                    rjLinePointBackColor:[UIColor redColor]
                                    }];
    [_graphView1 addLineWithValue:@[@135,@120,@180,@50,@100,@133,@150,@140,@70,@180,@150,@150]
                        attributs:@{rjLineColor:[UIColor whiteColor],
                                    rjLinePointBackColor:[UIColor yellowColor]
                                    }];
    [_graphView1 reBuild];
}

- (void)configGraphView2 {
    NSDictionary * attributs = @{
                                 rjBackGounrdColor:[UIColor whiteColor],
                                 rjBackLineColor:RJRGB(224, 224, 224, 1),
                                 rjBackLineWidth:@1,
                                 rjHorizonInterval:@35,
                                 rjHorizonLabelFont:@9,
                                 rjHorizonLabelColor:RJRGB(153, 153, 153, 1),
                                 rjHorizonHeight:@20,
                                 rjHorizontalLabelsTitle:@[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l"],
                                 rjVerticalLabelFont:@9,
                                 rjVerticalLabelColor:RJRGB(153, 153, 153, 1),
                                 rjVerticalMinValue:@0,
                                 rjVerticalMaxValue:@200,
                                 rjVerticalRankNum:@5,
                                 rjVerticalHeight:@300,
                                 rjVerticalWidth:@25,
                                 rjVerticalBackgroundColor:[UIColor whiteColor],
                                 rjHorizonBackgroundColor:[UIColor whiteColor],
                                 rjVerticalBorderColor:RJRGB(224, 224, 224, 1),
                                 rjHorizonBorderColor:RJRGB(224, 224, 224, 1)
                                 };
    
    [_graphView2 setAttribut:attributs];
    _graphView2.isCircular = YES;
    _graphView2.showPointBtn = YES;
    _graphView2.showPointDetailBtn = YES;
    _graphView2.scaleBtn = YES;
    [_graphView2 addLineWithValue:@[@15,@10,@49,@40,@40,@43,@68,@129,@109,@133,@130,@150]
                        attributs:@{rjLineColor:[UIColor cyanColor],
                                    rjLineBackColor:RJRGB(100, 100, 255, 0.2)
                                    }];
    [_graphView2 addLineWithValue:@[@135,@20,@80,@0,@10,@33,@50,@40,@10,@0,@15,@50]
                        attributs:@{rjLineColor:[UIColor magentaColor],
                                    rjLinePointBackColor:[UIColor yellowColor],
                                    rjLineBackColor:RJRGB(23, 230, 169, 0.2)
                                    }];
    
    [_graphView2 reBuild];
}


#pragma mark - getter



@end
