//
//  ViewController.m
//  ShareManagerDemo
//
//  Created by Lin on 16/6/13.
//  Copyright © 2016年 aa. All rights reserved.
//

#import "ViewController.h"
#import "LLShareManager.h"

@interface ViewController ()<LLShareManagerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)share:(id)sender {
    [[LLShareManager shareInstance] shareURLWithURL:@"https://www.baidu.com" shareTitle:@"这是分享的标题" shareDetail:@"这是分享的详细说明" shareIcon:[UIImage imageNamed:@"Logo.jpg"] platform:LLSharePlatformAll];
    [LLShareManager shareInstance].delegate = self;
}

#pragma mark LLShareManagerDelegate
- (void)didFinishShareWithResponse:(LLShareResponse *)response
{
    /**
     *  处理回调
     */
    NSLog(@"%@", response.errMessage);
}



@end
