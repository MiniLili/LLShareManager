//
//  UIImage+LLSScaleImage.h
//  ShareManagerDemo
//
//  Created by Lin on 16/6/13.
//  Copyright © 2016年 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LLSScaleImage)
/**
 *  压缩到小于指定的大小
 *
 *  @param k 指定大小
 *
 *  @return 压缩后的图片
 */
- (UIImage *)LLSsaleImagetoKB:(NSInteger)k;
@end
