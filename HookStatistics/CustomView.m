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
    
    NSArray *colors = @[[UIColor orangeColor],[UIColor redColor],[UIColor yellowColor]];
    int index= (arc4random() % 3);
    
    [self.delegate  someDelegateTriggerWithArg:colors[index]];
}

@end
