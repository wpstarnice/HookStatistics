//
//  CustomView.h
//  HookStatistics
//
//  Created by wpstarnice on 2016/12/23.
//  Copyright © 2016年 yd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomViewDelegate <NSObject>

-(void)someDelegateTriggerWithArg:(UIColor *)color;

@end

@interface CustomView : UIView

@property(nonatomic,weak)id<CustomViewDelegate>delegate;

-(void)doSomething;

@end
