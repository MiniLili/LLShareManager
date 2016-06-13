# LLShareManager
##使用方法
  在APPDelegate.m中做如下操作
#####1、`didFinishLaunchingWithOptions`注册分享appkey
  
```Objective-C
  - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /**
     *  注册 qq 微博 微信 的appKey
     */
    [[LLShareManager shareInstance] registQQWithAppKey:@"your appkey"];
    [[LLShareManager shareInstance] regitWechatWithAppKey:@"your appkey"];
    [[LLShareManager shareInstance] registWeiboWithAppKey:@"your appkey"];
    
    return YES;
}
```

#####2、`application:openURL:sourceApplication:annotation:`方法中处理回调

```Objective-C
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{

    if (![[LLShareManager shareInstance] handleURL:url]) {
        //处理别的App回调
    }
    return YES;
}
```

#####3、在需要使用的页面调用分享和实现回调

```Objective-C
 [[LLShareManager shareInstance] shareURLWithURL:@"https://www.baidu.com" shareTitle:@"这是分享的标题" shareDetail:@"这是分享的详细说明" shareIcon:[UIImage imageNamed:@"Logo.jpg"] platform:LLSharePlatformAll];
 [LLShareManager shareInstance].delegate = self;
```
实现代理`LLShareManagerDelegate`

```Objective-C
#pragma mark LLShareManagerDelegate
- (void)didFinishShareWithResponse:(LLShareResponse *)response
{
    /**
     *  处理回调
     */
    NSLog(@"%@", response.errMessage);
}
```

##添加第三方SDK
* 微信SDK添加 [微信SDK开发资源](https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list&t=resource/res_list&verify=1&lang=zh_CN&tab=dev) ：

	* 下载微信SDK：[微信SDK下载地址](https://res.wx.qq.com/open/zh_CN/htmledition/res/dev/download/sdk/WeChatSDK1.7.1.zip)
	* 将libWeChatSDK.a、WXApi.h、WXApiObject.h 三个文件拖入工程中。
	
* QQSDK添加 [QQ iOS API 说明](http://wiki.open.qq.com/wiki/IOS_API调用说明) ：
	* 下载QQSDK：[QQSDK下载地址](http://qzonestyle.gtimg.cn/qzone/vas/opensns/res/doc/iOS_SDK_V3.1.0.zip)
	* 将SDK中的TencentOpenAPI.framework和TencentOpenApi_IOS_Bundle.bundle文件拖入工程中。
	* 添加SDK依赖系统库文件。分别是`Security.framework`,`libiconv.dylib`，`SystemConfiguration.framework`，`CoreGraphics.Framework`、`libsqlite3.dylib`、`CoreTelephony.framework`、`libstdc++.dylib`、`libz.dylib`。
	* 在工程配置中的`Build Settings`一栏中找到`Linking`配置区，给`Other Linker Flags`配置项添加属性值`-fobjc-arc`。
* 微博SDK添加：
	* 用cocoaPod导入 Podfile文件如下
	
```ruby
platform :ios,’8.0’
use_frameworks!
target ‘ShareManagerDemo’ do
pod 'WeiboSDK', :podspec => 'https://raw.githubusercontent.com/liu3399shuai/weibo_podspec/master/WeiboSDK.podspec'
end
```

##修改工程配置文件
#####添加URL scheme
在你的工程设置项,targets 一栏下,选中自己的 target,在 Info->URL Types 中添加 URL Schemes。如果使用的是Xcode3或更低版本，则需要在plist文件中添加。

* 新浪微博平台url scheme设置格式：“wb”+新浪appkey，例如“wb126663232”。

* 微信平台url scheme设置格式：微信应用appId，例如“wxd9a39c7122aa6516。

* QQ、QQ空间url scheme设置格式 ：需要添加两个URL schemes 1. “QQ”+腾讯QQ互联应用appId转换成十六进制（不足8位前面补0），例如“QQ05FC5B14”,注意大写，生成十六进制方法：点击链接，2.“tencent“+腾讯QQ互联应用Id，例如“tencent100424468" 。

#####iOS9适配
######1.HTTP传输安全
以iOS9 SDK编译的工程会默认以SSL安全协议进行网络传输，即HTTPS，如果依然使用HTTP协议请求网络会报系统异常并中断请求。 

在info.plist中加入安全域名白名单(右键info.plist用source code打开)

```Objective-C
<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSExceptionDomains</key>
		<dict>
			<key>sina.cn</key>
			<dict>
				<key>NSIncludesSubdomains</key>
				<true/>
				<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
				<false/>
			</dict>
			<key>weibo.cn</key>
			<dict>
				<key>NSIncludesSubdomains</key>
				<true/>
				<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
				<false/>
			</dict>
			<key>weibo.com</key>
			<dict>
				<key>NSIncludesSubdomains</key>
				<true/>
				<key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
				<true/>
				<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
				<false/>
			</dict>
			<key>sinaimg.cn</key>
			<dict>
				<key>NSIncludesSubdomains</key>
				<true/>
				<key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
				<true/>
				<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
				<false/>
			</dict>
			<key>sinajs.cn</key>
			<dict>
				<key>NSIncludesSubdomains</key>
				<true/>
				<key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
				<true/>
				<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
				<false/>
			</dict>
			<key>sina.com.cn</key>
			<dict>
				<key>NSIncludesSubdomains</key>
				<true/>
				<key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
				<true/>
				<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
				<false/>
			</dict>
			<key>qq.com</key>
			<dict>
				<key>NSIncludesSubdomains</key>
				<true/>
				<key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
				<true/>
				<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
				<false/>
			</dict>
		</dict>
	</dict>
```


在info.plist的NSAppTransportSecurity下新增NSAllowsArbitraryLoads并设置为YES，指定所有HTTP连接都可正常请求。

```Objective-C
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

######2、应用白名单
>如果你的应用使用了如SSO授权登录或跳转分享功能，在iOS9下就需要增加一个可跳转的白名单，指定对应跳转App的URL Scheme，否则将在第三方平台判断是否跳转时用到的canOpenURL时返回NO，进而只进行webview授权或授权/分享失败。

同样在info.plist增加：

```Objective-C
<key>LSApplicationQueriesSchemes</key>
	<array>
		<string>wechat</string>
		<string>weibo</string>
		<string>weixin</string>
		<string>sinaweibohd</string>
		<string>sinaweibo</string>
		<string>sinaweibosso</string>
		<string>weibosdk</string>
		<string>weibosdk2.5</string>
		<string>mqqapi</string>
		<string>mqq</string>
		<string>mqqOpensdkSSoLogin</string>
		<string>mqqconnect</string>
		<string>mqqopensdkdataline</string>
		<string>mqqopensdkgrouptribeshare</string>
		<string>mqqopensdkfriend</string>
		<string>mqqopensdkapi</string>
		<string>mqqopensdkapiV2</string>
		<string>mqqopensdkapiV3</string>
		<string>mqzoneopensdk</string>
		<string>wtloginmqq</string>
		<string>wtloginmqq2</string>
		<string>mqqwpa</string>
		<string>mqzone</string>
		<string>mqzonev2</string>
		<string>mqzoneshare</string>
		<string>wtloginqzone</string>
		<string>mqzonewx</string>
		<string>mqzoneopensdkapiV2</string>
		<string>mqzoneopensdkapi19</string>
		<string>mqzoneopensdkapi</string>
		<string>mqqbrowser</string>
		<string>mttbrowser</string>
		<string>alipay</string>
		<string>alipayshare</string>
	</array>
```
