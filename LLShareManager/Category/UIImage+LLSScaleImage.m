//
//  UIImage+LLSScaleImage.m
//  ShareManagerDemo
//
//  Created by Lin on 16/6/13.
//  Copyright © 2016年 aa. All rights reserved.
//

#import "UIImage+LLSScaleImage.h"

@implementation UIImage (LLSScaleImage)

- (UIImage *)LLSsaleImagetoKB:(NSInteger)k {
    static const CGFloat kMESImageQuality = 0.5;
    NSData *imageData = UIImageJPEGRepresentation(self, kMESImageQuality);
    double factor = 1.0;
    double adjustment = 1.0 / sqrt(2.0);  // or use 0.8 or whatever you want
    CGSize size = self.size;
    CGSize currentSize = size;
    UIImage *currentImage = self;
    
    while (imageData.length >= (k * 1024))
    {
        factor *= adjustment;
        currentSize  = CGSizeMake(roundf(size.width * factor), roundf(size.height * factor));
        currentImage = [self LLSimagescaledToSize:currentSize];
        imageData = UIImageJPEGRepresentation(currentImage, kMESImageQuality);
    }
    return currentImage;
}

- (UIImage *)LLSimagescaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
