//
//  LFPopupMenu.h
//  LFPopupMenu
//
//  Created by 张林峰 on 2017/8/20.
//  Copyright © 2017年 张林峰. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LFPopupMenuItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *image;

/** 生成选项对象，标题和图片至少要传一个参数*/
+ (LFPopupMenuItem *)createWithTitle:(NSString *)title image:(UIImage *)image;

@end



@interface LFPopupMenu : UIView

/*******下面全是可选属性，都有默认值**********/
@property (nonatomic, strong) UIView *maskView;//半透明遮罩层,默认透明，可自行设置
@property (nonatomic, strong) UIImage *imgBG;//背景图，设置了这个就不用画带箭头的框了。
@property (nonatomic, strong) UIView *containerView;//容器，用于自定义弹窗内视图
@property (nonatomic, assign) CGFloat rowHeight;//行高,默认60
@property (nonatomic, assign) CGFloat arrowH;//箭头形高,默认9
@property (nonatomic, assign) CGFloat arrowW;//箭头形宽,默认9
@property (nonatomic, assign) CGFloat popupMargin;//窗口距屏幕边缘最小距离，默认5
@property (nonatomic, assign) CGFloat iconMargin;//图标和文字及窗口的距离，默认16
@property (nonatomic, assign) CGFloat cornerRadius;//弹窗圆角,默认6
@property (nonatomic, assign) CGFloat arrowCornerRadius;//箭头的圆角，默认0
@property (nonatomic, strong) UIColor *lineColor;//分割线颜色，默认系统灰色
@property (nonatomic, strong) UIFont *textFont;//默认15
@property (nonatomic, strong) UIColor *textColor;//默认黑色
@property (nonatomic, strong) UIColor *fillColor;//带箭头框的填充色，默认白色
@property (nonatomic, assign) BOOL needBorder;//是否要边框
@property (nonatomic, assign) CGPoint anchorPoint;//设置背景图的情况使用，背景图的三角在背景图的位置比例，如左上角(0,0),右下角(1,1),下边中间(0.5,1)以此类推

/**
 配置选项，注意：设置上面属性之后调用
 
 @param items 含文字和标题的对象数组
 @param action 点击回调，根据index判断点击的第几个
 */
- (void)configWithItems:(NSArray<LFPopupMenuItem *>*)items action:(void(^)(NSInteger index))action;

/**完全自定义菜单弹窗*/
- (void)configWithCustomView:(UIView *)customView;

/**
 显示菜单窗，有imgBG的情况下调用
 @param point 本控件左上角位置,相对window
 */
- (void)showInPoint:(CGPoint)point;

/**
 显示菜单窗，无imgBG的情况下调用
 @param point 箭头顶点位置,相对window
 */
- (void)showArrowInPoint:(CGPoint)point;


/**
 显示菜单窗，无imgBG的情况下调用（推荐）

 @param view 箭头对准的view
 */
- (void)showArrowInView:(UIView*)view;

- (void)dismiss;

@end
