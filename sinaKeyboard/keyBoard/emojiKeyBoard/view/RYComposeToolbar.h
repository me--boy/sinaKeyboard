//
//  RYComposeToolbar.h
//  黑马微博
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    RYComposeToolbarButtonTypeCamera, // 照相机
    RYComposeToolbarButtonTypePicture, // 相册
    RYComposeToolbarButtonTypeMention, // 提到@
    RYComposeToolbarButtonTypeTrend, // 话题
    RYComposeToolbarButtonTypeEmotion // 表情
} RYComposeToolbarButtonType;

@class RYComposeToolbar;

@protocol RYComposeToolbarDelegate <NSObject>

@optional
- (void)composeTool:(RYComposeToolbar *)toolbar didClickedButton:(RYComposeToolbarButtonType)buttonType;

@end

@interface RYComposeToolbar : UIView
@property (nonatomic, weak) id<RYComposeToolbarDelegate> delegate;
/**
 *  设置某个按钮的图片
 *
 *  @param image      图片名
 *  @param buttonType 按钮类型
 */
//- (void)setButtonImage:(NSString *)image buttonType:(RYComposeToolbarButtonType)buttonType;

/**
 *  是否要显示表情按钮
 */
@property (nonatomic, assign, getter = isShowEmotionButton) BOOL showEmotionButton;
@end
