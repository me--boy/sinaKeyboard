//
//  ViewController.m
//  KeyBoardDemo
//
//  Created by mkq on 15/6/24.
//  Copyright (c) 2015年 mkq. All rights reserved.
//
#define kScreenH    [UIScreen mainScreen].bounds.size.height

#define kScreenW    [UIScreen mainScreen].bounds.size.width

#import "ViewController.h"
#import "RYEmotionKeyboard.h"
#import "RYComposeToolbar.h"
#import "keyBoardConstDefine.h"
#import "RYEmotion.h"
#import "RYEmotionTextView.h"

@interface ViewController ()<RYComposeToolbarDelegate,UITextViewDelegate>

/**
 *  工具条
 */
@property (nonatomic, weak)RYComposeToolbar *composeToolbar;
/**
 *  是否正在切换键盘
 */
@property (nonatomic, assign, getter = isChangingKeyboard) BOOL changingKeyboard;
/**
 *  表情栏
 */
@property (nonatomic, strong)RYEmotionKeyboard *keyBoard;

@property (weak, nonatomic)RYEmotionTextView *textview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加工具条
    [self setupComposeToolBar];
    //添加键盘
    [self setupTextView];
}
/**
 *  添加textView
 */
- (void)setupTextView
{
    // 1.添加
    RYEmotionTextView *textView = [[RYEmotionTextView alloc] init];
    //    textView.backgroundColor = [UIColor redColor];
    textView.font = [UIFont systemFontOfSize:15];
    NSInteger textViewX = 0;
    NSInteger textViewY = 20;
    NSInteger textViewW = kScreenW - 2*textViewX;
    NSInteger textViewH = 164;
    textView.frame = CGRectMake(textViewX, textViewY, textViewW, textViewH);
    //    textView.backgroundColor = [UIColor redColor];
    // 垂直方向上永远可以拖拽
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.placeholder = @"说点什么吧...";
    [self.view addSubview:textView];
    self.textview = textView;
    // 4.监听键盘
    // 键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
    // 键盘即将弹出, 就会发出UIKeyboardWillShowNotification
    [RYNotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [RYNotificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)setupComposeToolBar
{
    // 1.创建
    RYComposeToolbar *toolbar = [[RYComposeToolbar alloc] init];
    //    toolbar.backgroundColor = [UIColor redColor];
    toolbar.delegate = self;
    NSInteger cc = kScreenH - 44;
    toolbar.frame = CGRectMake(0, cc, kScreenW, 44);
    [self.view addSubview:toolbar];
    
    self.composeToolbar = toolbar;
    // 监听表情选中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelected:) name:RYEmotionDidSelectedNotification object:nil];
    
    // 监听删除按钮点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidDeleted:) name:RYEmotionDidDeletedNotification object:nil];
    
}
/**
 *  当表情选中的时候调用
 *
 *  @param note 里面包含了选中的表情
 */
- (void)emotionDidSelected:(NSNotification *)note
{
    RYEmotion *emotion = note.userInfo[RYSelectedEmotion];
    // 1.拼接表情
    [self.textview appendEmotion:emotion];
    
    // 2.检测文字长度
    [self textViewDidChange:self.textview];
}
/**
 *  当textView的文字改变就会调用
 */
- (void)textViewDidChange:(UITextView *)textView
{
    //    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}
/**
 *  当点击表情键盘上的删除按钮时调用
 */
- (void)emotionDidDeleted:(NSNotification *)note
{
    // 往回删
    [self.textview deleteBackward];
    //    RYLog(@"删除1个......");
}

#pragma mark - 键盘处理
/**
 *  键盘即将隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    if (self.isChangingKeyboard) return;
    
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.composeToolbar.transform = CGAffineTransformIdentity;
    }];
}

/**
 *  键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //iPhone6+ 键盘高271  iPhone6 258  其他216
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.composeToolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
    }];
}
#pragma mark RYComposeToolbarDelegate 工具条代理
- (void)composeTool:(RYComposeToolbar *)toolbar didClickedButton:(RYComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case RYComposeToolbarButtonTypeCamera: // 照相机
            //            [self setUpCamera];
            break;
            
        case RYComposeToolbarButtonTypePicture: // 相册
            //            [self setUpAlbum];
            break;
            
        case RYComposeToolbarButtonTypeEmotion: // 表情
            [self setupKeyBoard];
            break;
            
        default:
            break;
    }
}
- (void)setupKeyBoard
{
    // 正在切换键盘
    self.changingKeyboard = YES;
    
    if (self.textview.inputView) { // 当前显示的是自定义键盘，切换为系统自带的键盘
        self.textview.inputView = nil;
        
        // 显示表情图片
        self.composeToolbar.showEmotionButton = YES;
    } else { // 当前显示的是系统自带的键盘，切换为自定义键盘
        // 如果临时更换了文本框的键盘，一定要重新打开键盘
        self.textview.inputView = self.keyBoard;
        // 不显示表情图片
        self.composeToolbar.showEmotionButton = NO;
    }
    
    // 关闭键盘
    [self.textview resignFirstResponder];
    
#warning 记录是否正在更换键盘
    // 更换完毕完毕
    self.changingKeyboard = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 打开键盘
        [self.textview becomeFirstResponder];
    });
}
#pragma mark 懒加载

- (RYEmotionKeyboard *)keyBoard
{
    if (nil == _keyBoard) {
        _keyBoard = [RYEmotionKeyboard keyboard];
        _keyBoard.width = kScreenW;
        
        //iPhone6+ 键盘高271  iPhone6 258  其他216
        _keyBoard.height = 216;
        
    }
    return _keyBoard;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.textview isFirstResponder]) {
        [self.textview resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
