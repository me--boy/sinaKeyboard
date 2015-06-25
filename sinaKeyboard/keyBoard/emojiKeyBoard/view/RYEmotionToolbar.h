//
//  RYEmotionToolbar.h
//  MK
//
//  Created by mkq on 15/6/3.
//  Copyright (c) 2015年 mkq. All rights reserved.
//
//  表情底部的工具条

#import <UIKit/UIKit.h>
@class RYEmotionToolbar;

typedef enum{
    RYEmotionTypeRecent, // 最近
    RYEmotionTypeDefault, // 默认
    RYEmotionTypeEmoji, // Emoji
    RYEmotionTypeLxh // 浪小花
} RYEmotionType;

@protocol RYEmotionToolbarDelegate <NSObject>

@optional
- (void)emotionToolbar:(RYEmotionToolbar *)toolbar didSelectedButton:(RYEmotionType)emotionType;
@end

@interface RYEmotionToolbar : UIView
@property (nonatomic, weak) id<RYEmotionToolbarDelegate> delegate;
@end
