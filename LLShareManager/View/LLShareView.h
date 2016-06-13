//
//  LLShareView.h
//  shareMenuDemo
//
//  Created by Lin on 16/6/8.
//  Copyright © 2016年 apple.lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLShareManagerConfig.h"

@class LLShareView;
@protocol LLShareViewDelegate <NSObject>

@required
/**
 *  取消分享
 *
 */
- (void)didCancelShare:(LLShareView *)shareView;

/**
 *  分享
 *
 *  @param shareView 分享视图
 *  @param platform  分享平台
 */
- (void)shareView:(LLShareView *)shareView sharePlatform:(LLSharePlatform)platform;

@end

@interface LLShareView : UIView

@property (nonatomic, weak) id <LLShareViewDelegate> delegate;

- (instancetype)initWithPlatforms:(NSArray *)platfroms;

@end
