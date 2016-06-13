//
//  ShareManagerDemo.m
//  ShareManagerDemo
//
//  Created by Lin on 16/6/8.
//  Copyright © 2016年 aa. All rights reserved.
//

#import "LLShareManager.h"
#import "UIViewController+TopestViewController.h"
#import <WeiboSDK.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApiRequestHandler.h"
#import <MessageUI/MessageUI.h>
#import "WXApi.h"


#import "LLShareView.h"
#import "UIView+LLLayoutConstraint.h"
#import "UIImage+LLSScaleImage.h"


static const CGFloat TranslationY = 300.f;

@interface LLShareManager ()<LLShareViewDelegate, MFMessageComposeViewControllerDelegate,
MFMailComposeViewControllerDelegate, QQApiInterfaceDelegate, WXApiDelegate, WeiboSDKDelegate>
@property (nonatomic, weak) UIView *shadowView;
@property (nonatomic, strong) LLShareView *shareView;


@property (nonatomic, copy) NSString *shareTitle;
@property (nonatomic, copy) NSString *shareDetail;
@property (nonatomic, copy) NSString *shareURL;
@property (nonatomic, strong) UIImage *shareIcon;

@end

@implementation LLShareResponse


@end

@implementation LLShareManager

static LLShareManager *_instance;

+ (instancetype)shareInstance
{
    if (nil == _instance) {
        _instance = [[super allocWithZone:NULL] init];
    }
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
#pragma mark - getter setter
- (void)setShareIcon:(UIImage *)shareIcon
{
    _shareIcon = [shareIcon LLSsaleImagetoKB:32];
}

#pragma mark - 注册
#pragma mark qq注册
- (void)registQQWithAppKey:(NSString *)appKey {
    [[TencentOAuth alloc]initWithAppId:appKey andDelegate:nil];
}
#pragma mark 微博注册
- (void)registWeiboWithAppKey:(NSString *)appKey {
    [WeiboSDK registerApp:appKey];
}
#pragma mark 微信注册
- (void)regitWechatWithAppKey:(NSString *)appKey {
    [WXApi registerApp:appKey];
}


#pragma mark -
#pragma mark 回调处理
- (BOOL)handleURL:(NSURL *)url {
    [self hideShareView];
    
    NSString *head=url.scheme;
    if ([head containsString:@"wx"]) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    if ([head containsString:@"tencent"]) {
        return [QQApiInterface handleOpenURL:url delegate:self];
    }
    
    if ([head containsString:@"wb"]) {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }
    
    /**
     *  重置数据
     */
    self.shareURL = nil;
    self.shareIcon = nil;
    self.shareDetail = nil;
    self.shareTitle = nil;
    
    return NO;
}

/**
 *  分享
 *
 *  @param url        地址[[TencentOAuth alloc]initWithAppId:@"your appID" andDelegate:nil]
 *  @param shareTitle 标题
 *  @param detail     分享详细
 *  @param shareIcon  分享icon
 *  @param platform   分享平台数组
 */
- (void)shareURLWithURL:(NSString *)url shareTitle:(NSString *)shareTitle shareDetail:(NSString *)detail shareIcon:(UIImage *)shareIcon platform:(LLSharePlatform)platform {
    
    NSMutableArray *platforms = [NSMutableArray array];
    /**
     *  参数检查
     */
    if (platform & LLSharePlatformAll) {
        platform = LLSharePlatformQQ |LLSharePlatformQQZom|LLSharePlatformWechat|LLSharePlatformWeiXinCircleFriend|LLSharePlatformWeibo|LLSharePlatformMessage|LLSharePlatformEmail|LLSharePlatformCopyURL;
    }
    
    if ((platform & LLSharePlatformQQ) && [QQApiInterface isQQInstalled] ) {
        [platforms addObject:@(LLSharePlatformQQ)];
    }
    if (platform & LLSharePlatformQQZom  && [QQApiInterface isQQInstalled] ) {
        [platforms addObject:@(LLSharePlatformQQZom)];
    }
    if (platform & LLSharePlatformWechat && [WXApi isWXAppInstalled]) {
        [platforms addObject:@(LLSharePlatformWechat)];
    }
    if (platform & LLSharePlatformWeiXinCircleFriend && [WXApi isWXAppInstalled]) {
        [platforms addObject:@(LLSharePlatformWeiXinCircleFriend)];
    }
    if (platform & LLSharePlatformWeibo && [WeiboSDK isWeiboAppInstalled]) {
        [platforms addObject:@(LLSharePlatformWeibo)];
    }
    if (platform & LLSharePlatformMessage) {
        [platforms addObject:@(LLSharePlatformMessage)];
    }
    if (platform & LLSharePlatformEmail) {
        [platforms addObject:@(LLSharePlatformEmail)];
    }
    if (platform & LLSharePlatformCopyURL) {
        [platforms addObject:@(LLSharePlatformCopyURL)];
    }
    
    
    self.shareIcon = shareIcon;
    self.shareTitle = shareTitle;
    self.shareDetail = detail;
    self.shareURL = url;
    
    
    LLShareView *shareView = [[LLShareView alloc]initWithPlatforms:platforms];
    shareView.delegate = self;
    _shareView = shareView;
    
    [self showShareView];
}



#pragma mark - 试图效果
#pragma mark 显示ShareView
- (void)showShareView {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    if (!self.shadowView) {
        UIView *shadowView = [UIView new];
        [shadowView setBackgroundColor:[UIColor blackColor]];
        [shadowView setAlpha:0];
        [keyWindow addSubview:shadowView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideShareView)];
        [shadowView addGestureRecognizer:tap];
        self.shadowView = shadowView;
    }
    
    [self.shadowView addConstrantAttribute:NSLayoutAttributeTop equalToItem:keyWindow constant:0];
    [self.shadowView addConstrantAttribute:NSLayoutAttributeBottom equalToItem:keyWindow constant:0];
    [self.shadowView addConstrantAttribute:NSLayoutAttributeTrailing equalToItem:keyWindow constant:0];
    [self.shadowView addConstrantAttribute:NSLayoutAttributeLeading equalToItem:keyWindow constant:0];
    
    
    [keyWindow addSubview:self.shareView];
    NSLayoutConstraint *bottom = [self.shareView addConstrantAttribute:NSLayoutAttributeBottom equalToItem:keyWindow constant:TranslationY];
    [self.shareView addConstrantAttribute:NSLayoutAttributeCenterX equalToItem:keyWindow constant:0];
    [self.shareView layoutIfNeeded];
    bottom.constant = 0;
    
    [UIView animateWithDuration:0.35f animations:^{
        [self.shadowView setAlpha:0.3];
        [self.shareView layoutIfNeeded];
    }];
}
#pragma mark 收回
- (void)hideShareView {
    
    [UIView animateWithDuration:0.35 animations:^{
        [self.shadowView setAlpha:0];
        [self.shareView setTransform:CGAffineTransformMakeTranslation(0, TranslationY)];
    } completion:^(BOOL finished) {
        [self.shadowView removeFromSuperview];
        [self.shareView removeFromSuperview];
    }];
}
#pragma mark 分享
- (void)shareURLByCustomViewWithURL:(NSString *)url shareTitle:(NSString *)shareTitle shareDetail:(NSString *)detail shareIcon:(UIImage *)shareIcon platform:(LLSharePlatform)platform {
    switch (platform) {
        case LLSharePlatformQQ: {
            if ([QQApiInterface isQQSupportApi]) {
                //分享跳转URL
                NSData* data = UIImagePNGRepresentation(shareIcon);
                QQApiNewsObject* newsObj =
                [QQApiNewsObject objectWithURL:[NSURL URLWithString:url]
                                         title:shareTitle
                                   description:detail
                              previewImageData:data];
                
                SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:newsObj];
                //将内容分享到qq
                QQApiSendResultCode sent = [QQApiInterface sendReq:req];
                
                if (sent != EQQAPISENDSUCESS) {
                    NSLog(@"QQ分享失败");
                }
            } else {
                UIAlertView* alert = [[UIAlertView alloc]
                                      initWithTitle:@"QQ分享失败"
                                      message:@"当前QQ版本不支持分享,"
                                      @"请更新到最新版本"
                                      delegate:nil
                                      cancelButtonTitle:@"好"
                                      otherButtonTitles:nil, nil];
                [alert show];
            }
            
            
            break;
        }
        case LLSharePlatformQQZom: {
            if ([QQApiInterface isQQSupportApi]) {
                //分享跳转URL
                NSData* data = UIImagePNGRepresentation(shareIcon);
                QQApiNewsObject* newsObj =
                [QQApiNewsObject objectWithURL:[NSURL URLWithString:url]
                                         title:shareTitle
                                   description:detail
                              previewImageData:data];
                
                SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:newsObj];
                //将内容分享到qzone
                QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
                if (sent != EQQAPISENDSUCESS) {
                    NSLog(@"LLShareManager：QQ空间分享失败");
                    LLShareResponse *response = [[LLShareResponse alloc]init];
                    response.statue = LLShareStatueFailed;
                    response.errMessage = @"分享失败";
                    [self.delegate didFinishShareWithResponse:response];
                }
            } else {
                UIAlertView* alert = [[UIAlertView alloc]
                                      initWithTitle:@"QQ分享失败"
                                      message:
                                      @"当QQ版本不支持分享,请更新到最新版本"
                                      delegate:nil
                                      cancelButtonTitle:@"好"
                                      otherButtonTitles:nil, nil];
                [alert show];
            }
            
            break;
        }
        case LLSharePlatformWechat: {
            if ([WXApi isWXAppSupportApi]) {
                BOOL shareSuccess = [WXApiRequestHandler sendLinkURL:url
                                                             TagName:shareTitle
                                                               Title:shareTitle
                                                         Description:detail
                                                          ThumbImage:shareIcon
                                                             InScene:WXSceneSession];
                if (!shareSuccess) {
                    NSLog(@"LLShareManager：微信分享失败！");
                    LLShareResponse *response = [[LLShareResponse alloc]init];
                    response.statue = LLShareStatueFailed;
                    response.errMessage = @"分享失败";
                    [self.delegate didFinishShareWithResponse:response];
                }
                
            } else {
                UIAlertView* alert = [[UIAlertView alloc]
                                      initWithTitle:@"微信分享失败"
                                      message:@"当前微信版本不支持分享,"
                                      @"请更新到最新版本"
                                      delegate:nil
                                      cancelButtonTitle:@"好"
                                      otherButtonTitles:nil, nil];
                [alert show];
            }
            break;
        }
        case LLSharePlatformWeiXinCircleFriend: {
            if ([WXApi isWXAppSupportApi]) {
                BOOL shareSuccess = [WXApiRequestHandler sendLinkURL:url
                                                             TagName:shareTitle
                                                               Title:shareTitle
                                                         Description:detail
                                                          ThumbImage:shareIcon
                                                             InScene:WXSceneTimeline];
                
                if (!shareSuccess) {
                    NSLog(@"LLShareManager：朋友圈分享失败！");
                    LLShareResponse *response = [[LLShareResponse alloc]init];
                    response.statue = LLShareStatueFailed;
                    response.errMessage = @"分享失败";
                    [self.delegate didFinishShareWithResponse:response];
                }
            } else {
                UIAlertView* alert = [[UIAlertView alloc]
                                      initWithTitle:@"微信分享失败"
                                      message:@"当前微信版本不支持分享,"
                                      @"请更新到最新版本"
                                      delegate:nil
                                      cancelButtonTitle:@"好"
                                      otherButtonTitles:nil, nil];
                [alert show];
            }
            
            break;
        }
        case LLSharePlatformWeibo: {
            if ([WeiboSDK isCanShareInWeiboAPP]) {
                NSData* data = UIImagePNGRepresentation(shareIcon);
                WBWebpageObject* pageObject = [WBWebpageObject new];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"YYYYMMDDHHmmss"];
                pageObject.objectID = [dateFormatter stringFromDate:[NSDate date]];
                pageObject.webpageUrl = url;
                pageObject.thumbnailData = data;
                pageObject.title = shareTitle;
                pageObject.description = detail;
                
                WBMessageObject* messageObj = [WBMessageObject message];
                messageObj.mediaObject = pageObject;
                
                WBSendMessageToWeiboRequest* sendRequest =
                [WBSendMessageToWeiboRequest requestWithMessage:messageObj];
                BOOL isSucess = [WeiboSDK sendRequest:sendRequest];
                if (!isSucess) {
                    NSLog(@"LLShareManager：微博分享失败！");
                    LLShareResponse *response = [[LLShareResponse alloc]init];
                    response.statue = LLShareStatueFailed;
                    response.errMessage = @"分享失败";
                    [self.delegate didFinishShareWithResponse:response];
                }
                
            } else {
                UIAlertView* alert = [[UIAlertView alloc]
                                      initWithTitle:@"微博分享失败"
                                      message:@"当微博版本不支持分享,"
                                      @"请更新到最新版本"
                                      delegate:nil
                                      cancelButtonTitle:@"好"
                                      otherButtonTitles:nil, nil];
                [alert show];
            }
            break;
        }
        case LLSharePlatformMessage: {
            MFMessageComposeViewController* msgc =
            [[MFMessageComposeViewController alloc] init];
            //短信内容
            msgc.body = [NSString stringWithFormat:@"%@：%@", shareTitle, detail];
            msgc.messageComposeDelegate = self;
            [[[UIApplication sharedApplication].keyWindow.rootViewController TVCTopestViewController] presentViewController:msgc animated:YES completion:nil];
            break;
        }
        case LLSharePlatformEmail: {
            if ([MFMailComposeViewController canSendMail]) {
                dispatch_after(
                               dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)),
                               dispatch_get_main_queue(), ^{
                                   MFMailComposeViewController* mailVC =
                                   [[MFMailComposeViewController alloc] init];
                                   // 设置邮件主题
                                   [mailVC setSubject:shareTitle];
                                   // 设置邮件内容
                                   [mailVC setMessageBody:[NSString stringWithFormat:@"%@：%@", detail, url]isHTML:YES];
                                   
                                   mailVC.mailComposeDelegate = self;
                                   // 显示控制器
                                   [[[UIApplication sharedApplication].keyWindow.rootViewController TVCTopestViewController] presentViewController:mailVC animated:YES completion:nil];
                               });
            } else {
                UIAlertView* alert = [[UIAlertView alloc]
                                      initWithTitle:@"无邮件账号"
                                      message:@"请设置邮件账户来发送电子邮件"
                                      delegate:nil
                                      cancelButtonTitle:@"好"
                                      otherButtonTitles:nil, nil];
                [alert show];
            }
            
            break;
        }
        case LLSharePlatformCopyURL: {
            UIPasteboard* pasteBoard = [UIPasteboard generalPasteboard];
            pasteBoard.string = url;
            LLShareResponse *response = [[LLShareResponse alloc]init];
            response.statue = LLShareStatueSuccess;
            response.errMessage = @"链接已复制";
            [self.delegate didFinishShareWithResponse:response];
            [self hideShareView];
            break;
        }
        default:
            break;
    }
    
}

#pragma mark - delegate
#pragma mark LLShareViewDeleagate
- (void)didCancelShare:(LLShareView *)shareView {
    [self hideShareView];
}

- (void)shareView:(LLShareView *)shareView sharePlatform:(LLSharePlatform)platform {
    
    [self shareURLByCustomViewWithURL:self.shareURL shareTitle:self.shareTitle shareDetail:self.shareDetail shareIcon:self.shareIcon platform:platform];
    
}

#pragma mark MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController*)controller
                 didFinishWithResult:(MessageComposeResult)result {
    [[[UIApplication sharedApplication].keyWindow.rootViewController TVCTopestViewController] dismissViewControllerAnimated:YES completion:nil];
    
    LLShareResponse *response = [[LLShareResponse alloc]init];
    switch (result) {
        case MessageComposeResultCancelled: {
            response.statue = LLShareStatueCancel;
            response.errMessage = @"消息发送取消！";
            break;
        }
        case MessageComposeResultSent: {
            response.statue = LLShareStatueSuccess;
            response.errMessage = @"消息发送成功！";
            break;
        }
        case MessageComposeResultFailed: {
            response.statue = LLShareStatueFailed;
            response.errMessage = @"消息发送失败！";
            break;
        }
    }
    [self.delegate didFinishShareWithResponse:response];
}
#pragma mark MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error {
    [[[UIApplication sharedApplication].keyWindow.rootViewController TVCTopestViewController] dismissViewControllerAnimated:YES
                                                                                                                 completion:^{
                                                                                                                     
                                                                                                                 }];
    LLShareResponse *response = [[LLShareResponse alloc]init];
    switch (result) {
        case MFMailComposeResultCancelled: {
            response.statue = LLShareStatueCancel;
            response.errMessage = @"邮件发送取消！";
            break;
        }
        case MFMailComposeResultSaved: {
            response.statue = LLShareStatueCancel;
            response.errMessage = @"邮件发送取消，邮件被保存。";
            break;
        }
        case MFMailComposeResultSent: {
            response.statue = LLShareStatueSuccess;
            response.errMessage = @"邮件发送成功！";
            break;
        }
        case MFMailComposeResultFailed: {
            response.statue = LLShareStatueFailed;
            response.errMessage = @"邮件发送失败！";
            break;
        }
    }
    
    [self.delegate didFinishShareWithResponse:response];
}

#pragma mark QQApiInterfaceDelegate
/**
 处理来至QQ的请求
 */
- (void)onReq:(QQBaseReq *)req{
    
}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response{
    
}

#pragma mark QQ和微信回调
- (void)onResp:(id)resp {
    
    if ([resp isKindOfClass:[QQBaseResp class]]) {
        QQBaseResp *qqResp = (QQBaseResp *)resp;
        LLShareResponse *response = [[LLShareResponse alloc]init];
        switch ([qqResp.result integerValue]) {
            case 0:{//成功
                response.statue = LLShareStatueSuccess;
                response.errMessage = @"分享成功";
                break;
            }
            case -4:{
                response.statue = LLShareStatueCancel;
                response.errMessage = @"分享取消";
                break;
            }
                
            default:{
                response.statue = LLShareStatueFailed;
                response.errMessage = @"分享失败";
                break;
            }
        }
        NSLog(@"%@, %@", qqResp.result, qqResp.errorDescription);
        [self.delegate didFinishShareWithResponse:response];
        return;
    }
    if ([resp isKindOfClass:[BaseResp class]]) {
        BaseResp *wcResp = (BaseResp *)resp;
        LLShareResponse *response = [[LLShareResponse alloc]init];
        switch (wcResp.errCode) {
            case 0:{//成功
                response.statue = LLShareStatueSuccess;
                response.errMessage = @"分享成功";
                break;
            }
            case -2:{
                response.statue = LLShareStatueCancel;
                response.errMessage = @"分享取消";
                break;
            }
                
            default:{
                response.statue = LLShareStatueFailed;
                response.errMessage = @"分享失败";
                break;
            }
        }
        NSLog(@"%d, %@", wcResp.errCode, wcResp.errStr);
        [self.delegate didFinishShareWithResponse:response];
    }
}
#pragma mark - 微博回调代理
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}

/**
 收到一个来自微博客户端程序的响应
 
 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 WBBaseResponse.userInfo 中的数据完成自己的功能
 @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    
    LLShareResponse *llResponse = [[LLShareResponse alloc]init];
    switch (response.statusCode) {
        case WeiboSDKResponseStatusCodeSuccess: {
            llResponse.statue = LLShareStatueSuccess;
            llResponse.errMessage = @"微博分享成功";
            break;
        }
        case WeiboSDKResponseStatusCodeUserCancel: {
            llResponse.statue = LLShareStatueCancel;
            llResponse.errMessage = @"微博分享取消";
            break;
        }
        case WeiboSDKResponseStatusCodeShareInSDKFailed: {
            llResponse.statue = LLShareStatueFailed;
            llResponse.errMessage = @"微博分享失败!";
            break;
        }
        default:{
            llResponse.statue = LLShareStatueFailed;
            llResponse.errMessage = @"微博分享失败!";
            break;
        }
    }
    [self.delegate didFinishShareWithResponse:llResponse];
}




@end
