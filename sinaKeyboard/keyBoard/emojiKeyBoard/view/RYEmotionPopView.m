//
//  RYEmotionPopView.m
//  MK
//
//  Created by mkq on 15/6/3.
//  Copyright (c) 2015年 mkq. All rights reserved.

#import "RYEmotionPopView.h"
#import "RYEmotionView.h"
#import "UIView+Frame.h"
@interface RYEmotionPopView()
@property (weak, nonatomic) IBOutlet RYEmotionView *emotionView;
@end

@implementation RYEmotionPopView

+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"RYEmotionPopView" owner:nil options:nil] lastObject];
}

- (void)showFromEmotionView:(RYEmotionView *)fromEmotionView
{
    if (fromEmotionView == nil) return;
    
    // 1.显示表情
    self.emotionView.emotion = fromEmotionView.emotion;
    
    // 2.添加到窗口上
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 3.设置位置
    CGFloat centerX = fromEmotionView.centerX;
    CGFloat centerY = fromEmotionView.centerY - self.height * 0.5;
    CGPoint center = CGPointMake(centerX, centerY);
    self.center = [window convertPoint:center fromView:fromEmotionView.superview];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

/**
 *  当一个控件显示之前会调用一次（如果控件在显示之前没有尺寸，不会调用这个方法）
 *
 *  @param rect 控件的bounds
 */
- (void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"emoticon_keyboard_magnifier"] drawInRect:rect];
}
@end
