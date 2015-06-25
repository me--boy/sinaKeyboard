//
//  RYEmotionAttachment.m
//  黑马微博
//
//  Created by apple on 14-7-18.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "RYEmotionAttachment.h"
#import "RYEmotion.h"

@implementation RYEmotionAttachment

- (void)setEmotion:(RYEmotion *)emotion
{
    _emotion = emotion;
#warning 资源文件路径的改变会影响
    self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@/%@", @"source",emotion.directory, emotion.png]];
}

@end
