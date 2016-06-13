//
//  UIViewController+TopestViewController.m
//  ShareManagerDemo
//
//  Created by Lin on 16/6/8.
//  Copyright © 2016年 aa. All rights reserved.
//

#import "UIViewController+TopestViewController.h"

@implementation UIViewController (TopestViewController)
- (UIViewController *)TVCTopestViewController
{
    if (self.presentedViewController)
    {
        return [self.presentedViewController TVCTopestViewController];
    }
    if ([self isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tab = (UITabBarController *)self;
        return [[tab selectedViewController] TVCTopestViewController];
    }
    if ([self isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *nav = (UINavigationController *)self;
        return [[nav visibleViewController] TVCTopestViewController];
    }
    return self;
}
@end
