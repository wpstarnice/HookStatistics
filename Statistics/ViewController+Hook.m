//
//  ViewController+Hook.m
//  HookStatistics
//
//  Created by wpstarnice on 2016/12/23.
//  Copyright © 2016年 yd. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Hook.h"

#warning at  the postion of sentence "insert arg to statistic database" ,need logging data

static IMP originBlockMethodImp = NULL;

@implementation ViewController (Hook)

+(void)load{

    [self swizzlingClassSelector:NSSelectorFromString(@"privateClassMethod") withMethod:NSSelectorFromString(@"hk_privateClassMethod")];
    
    [self swizzlingInstanceSelector:NSSelectorFromString(@"privateInstanceMethod") withMethod:NSSelectorFromString(@"hk_privateInstanceMethod")];
    
    [self swizzlingInstanceSelector:NSSelectorFromString(@"clickTestNormal") withMethod:NSSelectorFromString(@"hk_clickTestNormal")];
    
    [self swizzlingInstanceSelector:NSSelectorFromString(@"someDelegateTriggerWithArg:") withMethod:NSSelectorFromString(@"hk_someDelegateTriggerWithArg:")];
    
    
    originBlockMethodImp = [self getInstanceMethodImpletionWith:NSSelectorFromString(@"clickTestBlockCompletion:")];
    
    [self swizzlingInstanceSelector:NSSelectorFromString(@"clickTestBlockCompletion:") withMethod:NSSelectorFromString(@"hk_clickTestBlockCompletion:")];
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
