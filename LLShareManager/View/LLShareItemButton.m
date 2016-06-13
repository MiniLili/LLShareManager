//
//  LLShareItemButton.m
//  shareMenuDemo
//
//  Created by Lin on 16/6/8.
//  Copyright © 2016年 apple.lin. All rights reserved.
//

#import "LLShareItemButton.h"
#import "LLShareManagerConfig.h"


@interface LLShareItemButton ()
@property (nonatomic, copy) NSString *title;
@end

@implementation LLShareItemButton
+ (instancetype)itemButtonWithNormalStateImageName:(NSString *)normalName HightLightStateImageName:(NSString *)hightLightName andTitle:(NSString *)title {
    
    LLShareItemButton *button = [LLShareItemButton buttonWithType:UIButtonTypeCustom];
    button.title = title;
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"shareManager.bundle/%@", normalName]] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"shareManager.bundle/%@", hightLightName]] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitleColor:kTextColor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    
    return button;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGRect titleRect = [self sizeWithFontSize:13 SpaceWidth:MAXFLOAT];
    
    return CGRectMake((contentRect.size.width - titleRect.size.width) / 2, contentRect.size.height - titleRect.size.height, titleRect.size.width, titleRect.size.height);
    
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.width);
}

- (CGRect)sizeWithFontSize:(float)fontSize SpaceWidth:(float)wideth
{
    
    NSString* message = _title;
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:message];
    
    NSRange allRange = [message rangeOfString:message];
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:fontSize]
                    range:allRange];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor blackColor]
                    range:allRange];
    
    CGFloat titleHeight;
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(wideth, CGFLOAT_MAX)
                                        options:options
                                        context:nil];
    
    titleHeight = ceilf(rect.size.height) + 2;
    rect.size.height = titleHeight;
    return rect;
}

@end
