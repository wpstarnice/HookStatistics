//
//  StatisticManager.h
//  SuperCalculator
//
//  Created by Peng Wang on 2016/12/6.
//  Copyright © 2016年 youdao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Hook.h"

@interface StatisticManager : NSObject

+ (instancetype)sharedInstance;

/**
 @description batch add hook methods 
 */
- (void)setupStatisticsByHookObjects:(NSDictionary *)hookObjects;

@end
