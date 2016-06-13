//
//  LLShareManagerConfig.h
//  shareMenuDemo
//
//  Created by Lin on 16/6/8.
//  Copyright © 2016年 apple.lin. All rights reserved.
//

#ifndef LLShareManagerConfig_h
#define LLShareManagerConfig_h

typedef NS_ENUM(NSInteger, LLSharePlatform) {
    LLSharePlatformQQ = 1,                      //qq
    LLSharePlatformQQZom = 1 << 1,              //qq空间
    LLSharePlatformWechat = 1 << 2,             //微信
    LLSharePlatformWeiXinCircleFriend = 1 << 3, //微信朋友圈
    LLSharePlatformWeibo = 1 << 4,              //微博
    LLSharePlatformMessage = 1 << 5,            //消息
    LLSharePlatformEmail = 1 << 6,              //email
    LLSharePlatformCopyURL = 1 << 7,
    LLSharePlatformAll = 1 << 10,                //所有
};


static const CGFloat kDefaultButtonW = 57;
static const CGFloat kDefaultButtonH = 80;
#define kTextColor [UIColor colorWithRed:0.4126 green:0.4126 blue:0.4126 alpha:1.0]


#endif /* LLShareManagerConfig_h */
