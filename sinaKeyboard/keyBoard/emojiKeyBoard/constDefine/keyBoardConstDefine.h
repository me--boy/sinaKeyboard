//
//  keyBoardConstDefine.h
//  KeyBoardDemo
//
//  Created by mkq on 15/6/24.
//  Copyright (c) 2015年 mkq. All rights reserved.
//

#ifndef KeyBoardDemo_keyBoardConstDefine_h
#define KeyBoardDemo_keyBoardConstDefine_h

#ifdef __OBJC__

#import "UIView+Frame.h"

//通知中心
#define RYNotificationCenter [NSNotificationCenter defaultCenter]

//自定义log
#ifdef DEBUG
#define RYLog(...) NSLog(__VA_ARGS__)
#else
#define RYLog(...)
#endif

//当前设备的宽度
#define kScreenW      [UIScreen mainScreen].bounds.size.width
//当前设备的高度
#define kScreenH      [UIScreen mainScreen].bounds.size.height
//keyWindow
#define kKeyWindow    [UIApplication sharedApplication].keyWindow

//判断是否是 iOS7以上版本
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
/**
 *  版本号
 */
#define iOSEdition  ([[UIDevice currentDevice].systemVersion doubleValue])
//获得 RGB 的颜色(普通的10进制)
#define RYColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//16 进制
#define RYColorFromRGB(rgbValue)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f green:((float)((rgbValue & 0xFF00) >> 8))/255.0f blue:((float)(rgbValue & 0xFF))/255.0f alpha:1.0f]
/** 表情相关 */
// 表情的最大行数
#define RYEmotionMaxRows 3
// 表情的最大列数
#define RYEmotionMaxCols 7
// 每页最多显示多少个表情
#define RYEmotionMaxCountPerPage (RYEmotionMaxRows * RYEmotionMaxCols - 1)

// 通知
// 表情选中的通知
#define RYEmotionDidSelectedNotification @"RYEmotionDidSelectedNotification"
// 点击删除按钮的通知
#define RYEmotionDidDeletedNotification @"RYEmotionDidDeletedNotification"
// 通知里面取出表情用的key
#define RYSelectedEmotion @"RYSelectedEmotion"

#endif


#endif
