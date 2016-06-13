//
//  LLShareItemButton.h
//  shareMenuDemo
//
//  Created by Lin on 16/6/8.
//  Copyright © 2016年 apple.lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLShareItemButton : UIButton
/**
 *  分享按钮
 *
 *  @param normalName     正常图片
 *  @param hightLightName 高亮图片
 *  @param title          标题
 *
 *  @return 分享按钮
 */
+ (instancetype)itemButtonWithNormalStateImageName:(NSString *)normalName HightLightStateImageName:(NSString *)hightLightName andTitle:(NSString *)title;

@end
