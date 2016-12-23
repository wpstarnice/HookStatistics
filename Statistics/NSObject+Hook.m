//
//  NSObject+Hook.m
//  SuperCalculator
//
//  Created by Peng Wang on 2016/12/7.
//  Copyright © 2016年 youdao. All rights reserved.
//

#import "NSObject+Hook.h"
#import <objc/runtime.h>

@implementation NSObject (Hook)

+ (IMP)getClassMethodImpletionWith:(SEL)sel{

    Method method = class_getClassMethod([self class], sel);
    IMP  imp = method_getImplementation(method);
    
    return  imp;
}

+ (IMP)getInstanceMethodImpletionWith:(SEL)sel{
    
    Method method = class_getInstanceMethod([self class], sel);
    IMP  imp = method_getImplementation(method);
    
    return  imp;
}

+ (void)swizzlingClassSelector:(SEL)sel1 withMethod:(SEL )sel2  {
        
        SEL originalSelector = sel1;
        SEL swizzledSelector = sel2;
        
        Class class = object_getClass((id)self);
        Method originalMethod = class_getClassMethod(class, originalSelector);
        Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
}

+ (void)swizzlingInstanceSelector:(SEL)sel1 withMethod:(SEL )sel2  {
        
        Class class = [self class];
        
        SEL originalSelector = sel1;
        SEL swizzledSelector = sel2;
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
}

@end
