//
//  NSObject+Hook.h
//  SuperCalculator
//
//  Created by Peng Wang on 2016/12/7.
//  Copyright © 2016年 youdao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Hook)


/**
 get the certain class method imp

 @param sel sel

 @return imp
 */
+ (IMP)getClassMethodImpletionWith:(SEL)sel;

/**
 @description get the certain instance method imp
 
 @param  sel sel
 
 @return IMP
 */
+ (IMP)getInstanceMethodImpletionWith:(SEL)sel;

/**
 @description exchange two class method
 
 @param sel1 original sel
 @param sel2 replacement
 */
+ (void)swizzlingClassSelector:(SEL)sel1 withMethod:(SEL )sel2;

/**
 @description exchange two instance method
 
 @param sel1 original sel
 @param sel2 replacement
 */
+ (void)swizzlingInstanceSelector:(SEL)sel1 withMethod:(SEL )sel2;

@end
