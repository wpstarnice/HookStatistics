//
//  NSObject+Swizzling.h
//  SuperCalculator
//
//  Created by Peng Wang on 2016/12/7.
//  Copyright © 2016年 youdao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)

/**
 get the certain class method imp

 @param sel sel

 @return imp
 */
+ (IMP)classMethodIMPForSelector:(SEL)sel;

/**
 @description get the certain instance method imp
 
 @param  sel sel
 
 @return IMP
 */
+ (IMP)instanceMethodIMPForSelector:(SEL)sel;

/**
 @description exchange two class method
 
 @param sel1 original sel
 @param sel2 replacement
 */
+ (void)swizzleClassSelector:(SEL)sel1 andSelector:(SEL )sel2;

/**
 @description exchange two instance method
 
 @param sel1 original sel
 @param sel2 replacement
 */
+ (void)swizzleInstanceSelector:(SEL)sel1 andSelector:(SEL )sel2;

@end
