//
//  ViewController+Hook.m
//  HookStatistics
//
//  Created by wpstarnice on 2016/12/23.
//  Copyright © 2016年 yd. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Swizzling.h"

#warning at  the postion of sentence "insert arg to statistic database" ,need logging data

static IMP originBlockMethodImp = NULL;

@implementation ViewController (Hook)

+(void)load{

    [self swizzleClassSelector:NSSelectorFromString(@"privateClassMethod") andSelector:NSSelectorFromString(@"hk_privateClassMethod")];
    
    [self swizzleInstanceSelector:NSSelectorFromString(@"privateInstanceMethod") andSelector:NSSelectorFromString(@"hk_privateInstanceMethod")];
    
    [self swizzleInstanceSelector:NSSelectorFromString(@"clickTestNormal") andSelector:NSSelectorFromString(@"hk_clickTestNormal")];
    
    [self swizzleInstanceSelector:NSSelectorFromString(@"someDelegateTriggerWithArg:") andSelector:NSSelectorFromString(@"hk_someDelegateTriggerWithArg:")];
    
    
    originBlockMethodImp = [self instanceMethodIMPForSelector:NSSelectorFromString(@"clickTestBlockCompletion:")];
    
    [self swizzleInstanceSelector:NSSelectorFromString(@"clickTestBlockCompletion:") andSelector:NSSelectorFromString(@"hk_clickTestBlockCompletion:")];
}

#pragma mark - different methods

/**
 class method
 */
+(void)hk_privateClassMethod{
    
    NSLog(@"method:%s", __func__);
    
    [self hk_privateClassMethod];
    
    //insert arg to statistic database;
}

/**
 instance method
 */
-(void)hk_privateInstanceMethod{
    
    NSLog(@"method:%s", __func__);
    
    [self hk_privateInstanceMethod];
    
    //insert arg to statistic database;
}

/**
 click method
 */
-(void)hk_clickTestNormal{
    
    NSLog(@"method:%s", __func__);
    
    [self hk_clickTestNormal];
    
    //insert arg to statistic database;
}

/**
 protocol method

 @param color arg
 */
-(void)hk_someDelegateTriggerWithArg:(UIColor *)color{

    NSLog(@"delegate method:%s", __func__);
    
    [self hk_someDelegateTriggerWithArg:color];
    
    //insert color to statistic database;
}

/**
  statistic arg which is in block scope

 @param block ClickCompletion
 */
-(void)hk_clickTestBlockCompletion:(ClickCompletion)block{

    NSLog(@"block arg method:%s", __func__);
    
    //replacement
    ClickCompletion hookBlock = ^(NSString *text){
        
        block(text);
        
        //insert color to statistic database;
    };
    
    //method-imp
    
    ((void (*)(id, SEL, void *))originBlockMethodImp)(self, NSSelectorFromString(@"clickTestBlockCompletion:"),(__bridge void *)hookBlock);
}

@end
