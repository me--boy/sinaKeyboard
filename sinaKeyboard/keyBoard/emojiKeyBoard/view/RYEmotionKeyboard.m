//
//  RYEmotionKeyboard.m
//  MK
//
//  Created by mkq on 15/6/3.
//  Copyright (c) 2015年 mkq. All rights reserved.
//
//

#import "RYEmotionKeyboard.h"
#import "RYEmotionListView.h"
#import "RYEmotionToolbar.h"
#import "MJExtension.h"
#import "RYEmotionTool.h"
#import "UIView+Frame.h"
@interface RYEmotionKeyboard() <RYEmotionToolbarDelegate>
/** 表情列表 */
@property (nonatomic, weak) RYEmotionListView *listView;
/** 表情工具条 */
@property (nonatomic, weak) RYEmotionToolbar *toollbar;
@end

@implementation RYEmotionKeyboard

+ (instancetype)keyboard
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];
        
        // 1.添加表情列表
        RYEmotionListView *listView = [[RYEmotionListView alloc] init];
        [self addSubview:listView];
        self.listView = listView;
        
        // 2.添加表情工具条
        RYEmotionToolbar *toollbar = [[RYEmotionToolbar alloc] init];
        toollbar.delegate = self;
        [self addSubview:toollbar];
        self.toollbar = toollbar;
//        toollbar.hidden = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置工具条的frame
    self.toollbar.width = self.width;
    self.toollbar.height = 35;
    self.toollbar.y = self.height - self.toollbar.height;
    
    // 2.设置表情列表的frame
    self.listView.width = self.width;
    self.listView.height = self.toollbar.y;
}

#pragma mark - RYEmotionToolbarDelegate
- (void)emotionToolbar:(RYEmotionToolbar *)toolbar didSelectedButton:(RYEmotionType)emotionType
{
    switch (emotionType) {
        case RYEmotionTypeDefault:// 默认
//            self.listView.emotions = [RYEmotionTool defaultEmotions];
            self.listView.emotions = [RYEmotionTool defaultEmotions];
            break;
            
        case RYEmotionTypeEmoji: // Emoji
            self.listView.emotions = [RYEmotionTool emojiEmotions];
            break;
            
        case RYEmotionTypeLxh: // 浪小花
            self.listView.emotions = [RYEmotionTool lxhEmotions];
            break;
            
        case RYEmotionTypeRecent: // 最近
            self.listView.emotions = [RYEmotionTool recentEmotions];
            break;
    }
}
@end
