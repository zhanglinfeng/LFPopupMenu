//
//  LFPopupMenu.h
//  LFPopupMenu
//
//  Created by 张林峰 on 2017/8/20.
//  Copyright © 2017年 张林峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFPopupMenu : UIView

/*******下面全是可选属性，都有默认值**********/
@property (nonatomic, strong) UIView *maskView;//半透明遮罩层,默认透明，可自行设置
@property (nonatomic, strong) UIImage *imgBG;//背景图，设置了这个就不用画带三角的框了。
@property (nonatomic, assign) CGFloat rowHeight;//行高,默认60
@property (nonatomic, assign) CGFloat triangleH;//三角形高,默认9
@property (nonatomic, assign) CGFloat triangleW;//三角形宽,默认9
@property (nonatomic, assign) CGFloat popupMargin;//窗口距屏幕边缘最小距离，默认5
@property (nonatomic, assign) CGFloat iconMargin;//图标和文字及窗口的距离，默认16
@property (nonatomic, assign) CGFloat cornerRadius;//弹窗圆角,默认6
@property (nonatomic, assign) CGFloat triangleCornerRadius;//三角的圆角，默认0
@property (nonatomic, strong) UIColor *lineColor;//分割线颜色，默认系统灰色
@property (nonatomic, strong) UIFont *textFont;//默认15
@property (nonatomic, strong) UIColor *textColor;//默认黑色
@property (nonatomic, assign) BOOL needShadow;//是否要阴影，默认NO。如果设yes，会设置个默认阴影，也可自行设置阴影效果
@property (nonatomic, assign) BOOL needBorder;//是否要边框


/**
 配置选项，注意：设置上面属性之后调用
 
 @param titles 文字数组
 @param images 图标数组，元素是UIImage类型
 @param action 点击回调，根据index判断点击的第几个
 */
- (void)configWithTitles:(NSArray *)titles images:(NSArray *)images action:(void(^)(NSInteger index))action;


/**
 显示菜单窗，有imgBG的情况下调用
 @param point 本控件左上角位置,相对window
 */
- (void)showInPoint:(CGPoint)point;

/**
 显示菜单窗，无imgBG的情况下调用
 @param point 三角顶点位置,相对window
 */
- (void)showTriangleInPoint:(CGPoint)point;


/**
 显示菜单窗，无imgBG的情况下调用

 @param view 三角对准的view
 */
- (void)showTriangleInView:(UIView*)view;

- (void)dismiss;

@end
