//
//  ShareManagerDemo.h
//  ShareManagerDemo
//
//  Created by Lin on 16/6/8.
//  Copyright © 2016年 aa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LLShareManagerConfig.h"

typedef NS_ENUM(NSInteger, LLShareStatue) {
    LLShareStatueSuccess = 0,
    LLShareStatueCancel,
    LLShareStatueFailed,
};

@interface LLShareResponse : NSObject
@property (nonatomic, assign) LLShareStatue statue;
@property (nonatomic, strong) NSString *errMessage;
@end


@protocol LLShareManagerDelegate <NSObject>

-(void)didFinishShareWithResponse:(LLShareResponse *)response;

@end


@interface LLShareManager : NSObject


+ (instancetype)shareInstance;

@property (nonatomic, weak) id <LLShareManagerDelegate> delegate; /**< 分享回调代理 */

/**
 *  注册QQ
 *
 *  @param appKey 申请的Appkey
 */
- (void)registQQWithAppKey:(NSString *)appKey;
/**
 *  注册微信
 *
 *  @param appKey 微信Appkey
 */
- (void)regitWechatWithAppKey:(NSString *)appKey;

/**
 *  注册微博
 *
 *  @param appKey 微博Appkey
 */
- (void)registWeiboWithAppKey:(NSString *)appKey;

- (BOOL)handleURL:(NSURL *)url;


/**
 *  分享
 *
 *  @param url        地址
 *  @param shareTitle 标题
 *  @param detail     分享详细
 *  @param shareIcon  分享icon
 *  @param platform   分享平台可选
 */
- (void)shareURLWithURL:(NSString *)url shareTitle:(NSString *)shareTitle shareDetail:(NSString *)detail shareIcon:(UIImage *)shareIcon platform:(LLSharePlatform)platform;

/**
 *  自定义View的分享
 *
 *  @param url        url
 *  @param shareTitle 标题
 *  @param detail     分享详细
 *  @param shareIcon  分享icon
 *  @param platform   固定单一分享平台（注意）
 */
- (void)shareURLByCustomViewWithURL:(NSString *)url shareTitle:(NSString *)shareTitle shareDetail:(NSString *)detail shareIcon:(UIImage *)shareIcon platform:(LLSharePlatform)platform;

@end