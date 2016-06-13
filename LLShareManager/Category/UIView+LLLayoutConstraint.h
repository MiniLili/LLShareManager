//
//  UIView+LLLayoutConstraint.h
//  shareMenuDemo
//
//  Created by Lin on 16/6/8.
//  Copyright © 2016年 apple.lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LLLayoutConstraint)

/**
 *  self.attr = item.attr + c;
 */
- (NSLayoutConstraint *)addConstrantAttribute:(NSLayoutAttribute)attr equalToItem:(UIView *)item constant:(CGFloat)c;

/**
 *  self.attr = c;
 */
- (NSLayoutConstraint *)addConstrantAttribute:(NSLayoutAttribute)attr constant:(CGFloat)c;

/**
 *  self.attr = item.attr * multiplier + c;
 */
- (NSLayoutConstraint *)addConstrantAttribute:(NSLayoutAttribute)attr equalToItem:(UIView *)item multiplier:(CGFloat)multiplier constant:(CGFloat)c;

/**
 *  self.attr = item.attr1 * multiplier + c;
 */
- (NSLayoutConstraint *)addConstrantAttribute:(NSLayoutAttribute)attr equalToItem:(UIView *)item attribute:(NSLayoutAttribute)attr1 multiplier:(CGFloat)multiplier constant:(CGFloat)c;
@end
