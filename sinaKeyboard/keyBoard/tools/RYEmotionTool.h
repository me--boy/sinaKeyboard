//
//  RYEmotionTool.h
//  MK
//
//  Created by mkq on 15/6/3.
//  Copyright (c) 2015年 mkq. All rights reserved.
//
//  管理表情数据：加载表情数据、存储表情使用记录

#import <Foundation/Foundation.h>
@class RYEmotion;

@interface RYEmotionTool : NSObject
/**
 *  默认表情
 */
+ (NSArray *)defaultEmotions;
/**
 *  emoji表情
 */
+ (NSArray *)emojiEmotions;
/**
 *  浪小花表情
 */
+ (NSArray *)lxhEmotions;
/**
 *  最近表情
 */
+ (NSArray *)recentEmotions;

/**
 *  根据表情的文字描述找出对应的表情对象
 */
+ (RYEmotion *)emotionWithDesc:(NSString *)desc;

/**
 *  保存最近使用的表情
 */
+ (void)addRecentEmotion:(RYEmotion *)emotion;
@end
