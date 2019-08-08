//
//  UIImage+MKAdditions.m
//  GoodWine
//
//  Created by LMK on 2019/6/10.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "UIImage+MKAdditions.h"

@implementation UIImage (MKAdditions)

+ (NSString *)compressBase64EncondeImage:(NSString *)imageBase64 toMaxFileSize:(NSInteger)maxFileSize {
    if (imageBase64.length > maxFileSize) {
        NSData* data = [[NSData alloc] initWithBase64EncodedString:imageBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage* image = [UIImage imageWithData:data];
        imageBase64 = [UIImage compressImage:image toMaxFileSize:maxFileSize];
    }
    return imageBase64;
}

+ (NSString *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    CGFloat compression = 1.0f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    
    NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    while ([encodedImageStr length] > maxFileSize && compression > maxCompression) {
        compression -= 0.01;
        imageData = UIImageJPEGRepresentation(image, compression);
        encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    return encodedImageStr;
}

+ (UIImage *)getBundleImageWithImageName:(NSString *)imageName {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"com.baidu.idl.face.faceSDK" ofType:@"bundle"];
    NSString *imagePath = [[NSBundle bundleWithPath:bundlePath] pathForResource:imageName ofType:@"png"];
    return [UIImage imageWithContentsOfFile:imagePath];
}

@end
