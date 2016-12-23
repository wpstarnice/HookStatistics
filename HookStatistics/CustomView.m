//
//  CustomView.m
//  HookStatistics
//
//  Created by wpstarnice on 2016/12/23.
//  Copyright © 2016年 yd. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

-(void)doSomething{
    
     [self.delegate  someDelegateTriggerWithArg:[UIColor yellowColor]];
}

@end
