//
//  UIImage+MKAdditions.h
//  GoodWine
//
//  Created by LMK on 2019/6/10.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (MKAdditions)

/**
 循环压缩图片到指定大小
 
 @param imageBase64 base64格式图片
 @param maxFileSize 指定大小
 @return base64格式
 */
+ (NSString *)compressBase64EncondeImage:(NSString *)imageBase64 toMaxFileSize:(NSInteger)maxFileSize;

/**
 获取bundle中的图片
 
 @param imageName imageName
 @return image
 */
+ (UIImage *)getBundleImageWithImageName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
