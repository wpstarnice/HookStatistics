//
//  StatisticManager.h
//  SuperCalculator
//
//  Created by Peng Wang on 2016/12/6.
//  Copyright © 2016年 youdao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatisticManager : NSObject

+ (instancetype)sharedInstance;

/**
 @description batch add hook methods 
 
 Apply to simple statistics without business logic...
 if referring to more business logic，use class-category to achieve ，such as ViewController+Hook.m
 
 */
- (void)setupStatisticsByHookObjects:(NSDictionary *)hookObjects;

@end
