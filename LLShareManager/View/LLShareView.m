//
//  LLShareView.m
//  shareMenuDemo
//
//  Created by Lin on 16/6/8.
//  Copyright © 2016年 apple.lin. All rights reserved.
//

#import "LLShareView.h"
#import "LLShareItemButton.h"
#import "UIView+LLLayoutConstraint.h"

static const NSInteger ShareViewPlatformBaseTag = 323232;/**< 分享基础tag */

static NSString *const weixinFriendNormal = @"more_weixin";
static NSString *const weixinFriendHighlighted = @"more_weixin_highlighted";

static NSString *const weixinCircleFriendNormal = @"more_circlefriends";
static NSString *const weixinCirlcleFriendHighlighted = @"more_circlefriends_highlighted";

static NSString *const QQFriendNormal = @"more_icon_qq";
static NSString *const QQFriendHighlighted = @"more_icon_qq_highlighted";

static NSString *const QQZoomNormal = @"more_icon_qzone";
static NSString *const QQZoomHighlighted = @"more_icon_qzone_highlighted";

static NSString *const weiBoNormal = @"more_weibo";
static NSString *const weiBoHighlighted = @"more_weibo_highlighted";

static NSString *const messageNormal = @"more_mms";
static NSString *const messageHighlighted = @"more_mms_highlighted";

static NSString *const emailNormal = @"more_email";
static NSString *const emailHighlighted = @"more_email_highlighted";

static NSString *const backHomeNormal = @"more_icon_back";
static NSString *const backHomeHighlighted = @"more_icon_back_highlighted";

static NSString *const copyLinkHomeNormal = @"more_icon_link";
static NSString *const copyLinkHomeHighlighted = @"more_icon_link_highlighted";

static const CGFloat defaultSpacing = 15.f;
static const CGFloat DefaultBackgroundAlpha = 0.8;


@implementation LLShareView

- (instancetype)initWithPlatforms:(NSArray *)platfroms{
    self = [super init];
    if (self) {
        
        
        //背景半透明白色
        UIView *backgroundView = [UIView new];
        backgroundView.alpha = DefaultBackgroundAlpha;
        backgroundView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
        [self addSubview:backgroundView];
        [backgroundView addConstrantAttribute:NSLayoutAttributeLeft equalToItem:self constant:0];
        [backgroundView addConstrantAttribute:NSLayoutAttributeRight equalToItem:self constant:0];
        [backgroundView addConstrantAttribute:NSLayoutAttributeTop equalToItem:self constant:0];
        [backgroundView addConstrantAttribute:NSLayoutAttributeBottom equalToItem:self constant:0];
        
        UILabel *shareTipLab = [UILabel new];
        [shareTipLab setFont:[UIFont systemFontOfSize:14]];
        [shareTipLab setText:@"分享到"];
        [shareTipLab setTextColor:kTextColor];
        [self addSubview:shareTipLab];
        [shareTipLab addConstrantAttribute:NSLayoutAttributeTop equalToItem:self constant:20];
        [shareTipLab addConstrantAttribute:NSLayoutAttributeLeft equalToItem:self constant:defaultSpacing];
        
        UIScrollView *topScrollView = [UIScrollView new];
        [topScrollView setShowsHorizontalScrollIndicator:YES];
        [topScrollView setShowsVerticalScrollIndicator:NO];
        [self addSubview:topScrollView];
        [topScrollView addConstrantAttribute:NSLayoutAttributeLeft equalToItem:self constant:0];
        [topScrollView addConstrantAttribute:NSLayoutAttributeRight equalToItem:self constant:0];
        [topScrollView addConstrantAttribute:NSLayoutAttributeTop equalToItem:shareTipLab attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        [topScrollView addConstrantAttribute:NSLayoutAttributeHeight constant:kDefaultButtonH + 20];
        
        UIView *topContentView = [UIView new];
        [topScrollView addSubview:topContentView];
        [topContentView addConstrantAttribute:NSLayoutAttributeLeft equalToItem:topScrollView constant:0];
        [topContentView addConstrantAttribute:NSLayoutAttributeTrailing equalToItem:topScrollView multiplier:1 constant:0];
        [topContentView addConstrantAttribute:NSLayoutAttributeTop equalToItem:topScrollView constant:0];
        [topContentView addConstrantAttribute:NSLayoutAttributeBottom equalToItem:topScrollView constant:0];
        [topContentView addConstrantAttribute:NSLayoutAttributeHeight equalToItem:topScrollView constant:0];
        
        UIView *lineView = [UIView new];
        [lineView setBackgroundColor:[UIColor colorWithRed: 220.0/255.0 green: 220.0/255.0 blue: 220.0/255.0 alpha:1]];
        [self addSubview:lineView];
        [lineView addConstrantAttribute:NSLayoutAttributeLeft equalToItem:self constant:0];
        [lineView addConstrantAttribute:NSLayoutAttributeRight equalToItem:self constant:0];
        [lineView addConstrantAttribute:NSLayoutAttributeTop equalToItem:topScrollView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        [lineView addConstrantAttribute:NSLayoutAttributeHeight constant:1.f];
        
        
        UIScrollView *bottomScrollView = [UIScrollView new];
        [bottomScrollView setShowsHorizontalScrollIndicator:YES];
        [bottomScrollView setShowsVerticalScrollIndicator:NO];
        [self addSubview:bottomScrollView];
        [bottomScrollView addConstrantAttribute:NSLayoutAttributeLeft equalToItem:self constant:0];
        [bottomScrollView addConstrantAttribute:NSLayoutAttributeRight equalToItem:self constant:0];
        [bottomScrollView addConstrantAttribute:NSLayoutAttributeTop equalToItem:lineView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        [bottomScrollView addConstrantAttribute:NSLayoutAttributeHeight constant:kDefaultButtonH + 20];
        
        UIView *bottomContentView = [UIView new];
        [bottomScrollView addSubview:bottomContentView];
        [bottomContentView addConstrantAttribute:NSLayoutAttributeLeft equalToItem:bottomScrollView constant:0];
        [bottomContentView addConstrantAttribute:NSLayoutAttributeTop equalToItem:bottomScrollView constant:0];
        [bottomContentView addConstrantAttribute:NSLayoutAttributeBottom equalToItem:bottomScrollView constant:0];
        [bottomContentView addConstrantAttribute:NSLayoutAttributeHeight equalToItem:bottomScrollView constant:0];
        [bottomContentView addConstrantAttribute:NSLayoutAttributeTrailing equalToItem:bottomScrollView multiplier:1 constant:0];
        
        
        UIView *topLastView = nil;
        UIView *bottomLastView = nil;
        
        for (NSNumber *number in platfroms) {
            LLSharePlatform platform = [number integerValue];
            
            LLShareItemButton *shareBtn = nil;
            BOOL isTop = YES;
            
            switch (platform) {
                case LLSharePlatformQQ: {
                    shareBtn = [LLShareItemButton itemButtonWithNormalStateImageName:QQFriendNormal HightLightStateImageName:QQFriendHighlighted andTitle:@"QQ"];
                    break;
                }
                case LLSharePlatformQQZom: {
                    shareBtn = [LLShareItemButton itemButtonWithNormalStateImageName:QQZoomNormal HightLightStateImageName:QQZoomHighlighted andTitle:@"QQ空间"];
                    break;
                }
                case LLSharePlatformWechat: {
                    shareBtn = [LLShareItemButton itemButtonWithNormalStateImageName:weixinFriendNormal HightLightStateImageName:weixinFriendHighlighted andTitle:@"微信好友"];
                    break;
                }
                case LLSharePlatformWeiXinCircleFriend: {
                    shareBtn = [LLShareItemButton itemButtonWithNormalStateImageName:weixinCircleFriendNormal HightLightStateImageName:weixinCirlcleFriendHighlighted andTitle:@"朋友圈"];
                    break;
                }
                case LLSharePlatformWeibo: {
                    shareBtn = [LLShareItemButton itemButtonWithNormalStateImageName:weiBoNormal HightLightStateImageName:weiBoHighlighted andTitle:@"微博"];
                    break;
                }
                case LLSharePlatformMessage: {
                    shareBtn = [LLShareItemButton itemButtonWithNormalStateImageName:messageNormal HightLightStateImageName:messageHighlighted andTitle:@"短信"];
                    break;
                }
                case LLSharePlatformEmail: {
                    shareBtn = [LLShareItemButton itemButtonWithNormalStateImageName:emailNormal HightLightStateImageName:emailNormal andTitle:@"邮件"];
                    break;
                }
                case LLSharePlatformCopyURL:{
                    shareBtn = [LLShareItemButton itemButtonWithNormalStateImageName:copyLinkHomeNormal HightLightStateImageName:copyLinkHomeHighlighted andTitle:@"复制链接"];
                    isTop = NO;
                    break;
                }
                default:
                    break;
            }
            
            [shareBtn setTag:ShareViewPlatformBaseTag + platform];
            [shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
            
            UIView *contentView = isTop ? topContentView : bottomContentView;
            UIView *lastView = isTop ? topLastView : bottomLastView;
            
            [contentView addSubview:shareBtn];
            if (!lastView) {
                [shareBtn addConstrantAttribute:NSLayoutAttributeLeft equalToItem:contentView constant:defaultSpacing];
                
            }else {
                [shareBtn addConstrantAttribute:NSLayoutAttributeLeft equalToItem:lastView attribute:NSLayoutAttributeRight multiplier:1 constant:defaultSpacing];
            }
            [shareBtn addConstrantAttribute:NSLayoutAttributeHeight constant:kDefaultButtonH];
            [shareBtn addConstrantAttribute:NSLayoutAttributeWidth constant:kDefaultButtonW];
            [shareBtn addConstrantAttribute:NSLayoutAttributeCenterY equalToItem:contentView multiplier:1 constant:0];
            topLastView = isTop ? shareBtn : topLastView;
            bottomLastView = isTop? bottomLastView : shareBtn;
        }
        
        if (topLastView) {
            [topContentView addConstrantAttribute:NSLayoutAttributeRight equalToItem:topLastView multiplier:1 constant:defaultSpacing];
        }
        if (bottomLastView) {
            [bottomContentView addConstrantAttribute:NSLayoutAttributeRight equalToItem:bottomLastView multiplier:1 constant:defaultSpacing];
        }
        
        //取消
        UIButton *cancelBtn = [UIButton new];
        [cancelBtn setBackgroundColor:[UIColor whiteColor]];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [cancelBtn addTarget:self action:@selector(cancelShare) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setTitleColor:kTextColor forState:UIControlStateNormal];
        [self addSubview:cancelBtn];
        [cancelBtn addConstrantAttribute:NSLayoutAttributeHeight constant:40];
        [cancelBtn addConstrantAttribute:NSLayoutAttributeLeft equalToItem:self constant:0];
        [cancelBtn addConstrantAttribute:NSLayoutAttributeRight equalToItem:self constant:0];
        [cancelBtn addConstrantAttribute:NSLayoutAttributeTop equalToItem:bottomScrollView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        [self addConstrantAttribute:NSLayoutAttributeBottom equalToItem:cancelBtn constant:0];
        [self addConstrantAttribute:NSLayoutAttributeWidth constant:[UIScreen mainScreen].bounds.size.width];
        
    }
    return self;
}

/**
 *  取消
 */
- (void)cancelShare{
    if (self.delegate) {
        [self.delegate didCancelShare:self];
    }
}

/**
 *  分享
 */

- (void)share:(UIButton *)sender {
    if (self.delegate) {
        [self.delegate shareView:self sharePlatform:sender.tag-ShareViewPlatformBaseTag];
    }
}

@end
