//
//  UIImage+resize.h
//  MK
//
//  Created by mkq on 15/5/26.
//  Copyright (c) 2015年 mkq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (resize)
/**
 *  返回一个拉伸过后的图片
 *
 *  @param imageName 图片名字
 */
+ (UIImage *)resizeImageWithName:(NSString *)imageName;

@end
