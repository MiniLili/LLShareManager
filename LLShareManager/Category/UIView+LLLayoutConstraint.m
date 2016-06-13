//
//  UIView+LLLayoutConstraint.m
//  shareMenuDemo
//
//  Created by Lin on 16/6/8.
//  Copyright © 2016年 apple.lin. All rights reserved.
//

#import "UIView+LLLayoutConstraint.h"

@implementation UIView (LLLayoutConstraint)
- (NSLayoutConstraint *)addConstrantAttribute:(NSLayoutAttribute)attr equalToItem:(UIView *)item constant:(CGFloat)c {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attr relatedBy:NSLayoutRelationEqual toItem:item attribute:attr multiplier:1 constant:c];
    constraint.active = YES;
    return constraint;
}

- (NSLayoutConstraint *)addConstrantAttribute:(NSLayoutAttribute)attr equalToItem:(UIView *)item multiplier:(CGFloat)multiplier constant:(CGFloat)c {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attr relatedBy:NSLayoutRelationEqual toItem:item attribute:attr multiplier:multiplier constant:c];
    constraint.active = YES;
    return constraint;
}

- (NSLayoutConstraint *)addConstrantAttribute:(NSLayoutAttribute)attr constant:(CGFloat)c {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attr relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:c];
    constraint.active = YES;
    return constraint;
}

- (NSLayoutConstraint *)addConstrantAttribute:(NSLayoutAttribute)attr equalToItem:(UIView *)item attribute:(NSLayoutAttribute)attr1 multiplier:(CGFloat)multiplier constant:(CGFloat)c {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attr relatedBy:NSLayoutRelationEqual toItem:item attribute:attr1 multiplier:multiplier constant:c];
    constraint.active = YES;
    return constraint;
}
@end
