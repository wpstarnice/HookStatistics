//
//  StatisticManager.m
//  SuperCalculator
//
//  Created by Peng Wang on 2016/12/6.
//  Copyright © 2016年 youdao. All rights reserved.
//

#import "StatisticManager.h"
#import "AppDelegate.h"
#import "NSObject+Hook.h"

@implementation StatisticManager

+ (void)load{
    
    __weak typeof(self) weakself = self;
    
    __block __weak id token = [[NSNotificationCenter defaultCenter]
                               addObserverForName:UIApplicationDidFinishLaunchingNotification
                                           object:nil
                                            queue:nil
                                       usingBlock:^(NSNotification *note) {
                                           __strong typeof(weakself)strongself = weakself;;
                                           [strongself initTracker];
                                           [[NSNotificationCenter defaultCenter] removeObserver:token];
                                       }];
}

+ (instancetype)sharedInstance {
    
    static StatisticManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (void)initTracker{
    //custom... such as init database for statistics
    NSLog(@"custom your tracker ");
}

#pragma mark - Life cycle

/** batch load methods
 @description hooks by datasource:hookObjects
 hookObjects is a dictionary  such as:
    @{@"ViewController1":@[@"method1",@"method2"],
      @"ViewController2":@[@"method3",@"method4"]
    }
 */
- (void)setupStatisticsByHookObjects:(NSDictionary *)hookObjects{

    [hookObjects enumerateKeysAndObjectsUsingBlock:^(NSString *className, NSArray *selectors,
                                                          BOOL *_Nonnull stop) {
        
        [self setupStatisticsClass:className selectors:selectors];
    }];
}

- (void)setupStatisticsClass:(NSString *)className selectors:(NSArray *)selectors{
    
    Class kClass = NSClassFromString(className);
    [selectors
     enumerateObjectsUsingBlock:^(NSString *selector, NSUInteger idx, BOOL *_Nonnull stop) {
         
         SEL sel = NSSelectorFromString(selector);
         SEL hk_sel = NSSelectorFromString([NSString stringWithFormat:@"hk_%@",selector]);
         
          [kClass swizzlingInstanceSelector:sel withMethod:hk_sel];
     }];
}

@end
