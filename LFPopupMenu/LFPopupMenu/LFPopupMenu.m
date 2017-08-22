//
//  LFPopupMenu.m
//  LFPopupMenu
//
//  Created by 张林峰 on 2017/8/20.
//  Copyright © 2017年 张林峰. All rights reserved.
//

#import "LFPopupMenu.h"

@interface LFPopupMenu ()

@property (nonatomic, strong) UIImageView *ivBG;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, copy) void(^action)(NSInteger index);

@end

@implementation LFPopupMenu

#pragma mark - UI

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = NO;
        self.rowHeight = 60;
        self.triangleH = 9;
        self.triangleW = 9;
        self.popupMargin = 5;
        self.iconMargin = 16;
        self.cornerRadius = 6;
        self.lineColor = [UIColor grayColor];
        self.textFont = [UIFont systemFontOfSize:15];
        self.textColor = [UIColor blackColor];
    }
    return self;
}

- (void)configWithTitles:(NSArray *)titles images:(NSArray *)images action:(void(^)(NSInteger index))action {
    self.titles = titles;
    self.images = images;
    self.action = action;
    [self adjustMaxWidth];
    [self initUI];
}

- (void)initUI {
    if (self.imgBG) {
        self.ivBG = [[UIImageView alloc] initWithFrame:self.bounds];
        self.ivBG.image = self.imgBG;
        [self addSubview:self.ivBG];
    }
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.triangleH, self.frame.size.width, self.frame.size.height - self.triangleH)];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.contentView];
    
    for (NSInteger i = 0; i < self.titles.count; i++) {
        UIImage *image = self.images[i];
        CGFloat imgH = image.size.height;
        CGFloat imgW = image.size.width;
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(self.iconMargin, (self.rowHeight - imgH)/2 + self.rowHeight*i, imgW, imgH)];
        iv.image = image;
        [self.contentView addSubview:iv];
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(self.iconMargin*2 + imgW, i*self.rowHeight, self.frame.size.width - (self.iconMargin*3 + imgW), self.rowHeight)];
        lb.textColor = [UIColor blackColor];
        lb.text = self.titles[i];
        lb.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:lb];
        
        UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(0, i*self.rowHeight, self.frame.size.width, self.rowHeight)];
        bt.backgroundColor = [UIColor clearColor];
        bt.tag = i;
        [bt addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:bt];
        
        if (i > 0) {
            UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, i*self.rowHeight, self.frame.size.width, 1.0f/[UIScreen mainScreen].scale)];
            viewLine.backgroundColor = self.lineColor;
            [self.contentView addSubview:viewLine];
        }
    }
}

#pragma mark - Action

- (void)selectItem:(UIButton *)button {
    if (self.action) {
        self.action(button.tag);
    }
    
    [self dismiss];
}

#pragma mark - 公有方法

- (void)showInPoint:(CGPoint)point {
    [self addToWindow];
    
    BOOL isUp = point.y < self.maskView.frame.size.height/2;
    BOOL isLeft = (point.x + self.frame.size.width/2) < self.maskView.frame.size.width/2;
    
    self.frame = CGRectMake(point.x, point.y, self.frame.size.width, self.frame.size.height);
    // 弹出动画
    self.maskView.alpha = 0;
    CGRect oldFrame = self.frame;
    self.layer.anchorPoint = CGPointMake(isLeft ? 0 : 1, isUp ? 0.f : 1.f);
    self.frame = oldFrame;
    self.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    [UIView animateWithDuration:0.25f animations:^{
        self.transform = CGAffineTransformIdentity;
        self.maskView.alpha = 1.f;
    }];
}

- (void)showTriangleInPoint:(CGPoint)point {
    [self addToWindow];
    CGFloat popupX;//窗口x
    CGFloat popupY;//窗口y
    BOOL isUp = point.y < self.maskView.frame.size.height/2;
    
    // 如果箭头指向的点过于偏左或者过于偏右则需要重新调整箭头 x 轴的坐标
    CGFloat minHorizontalEdge = self.popupMargin + self.cornerRadius + self.triangleW/2;
    if (point.x < minHorizontalEdge) {
        point.x = minHorizontalEdge;
    }
    
    if (point.x > self.maskView.frame.size.width - minHorizontalEdge) {
        point.x = self.maskView.frame.size.width - minHorizontalEdge;
    }
    
    
    popupX = point.x - self.frame.size.width/2;
    popupY = point.y;
    //窗口靠左
    if (point.x <= self.frame.size.width/2 + self.popupMargin) {
        popupX = self.popupMargin;
    }
    //窗口靠右
    if (self.maskView.frame.size.width - point.x <= self.frame.size.width/2 + self.popupMargin) {
        popupX = self.maskView.frame.size.width - self.popupMargin - self.frame.size.width;
    }
    //三角向下
    if (!isUp) {
        popupY = point.y - self.frame.size.height;
        self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - self.triangleH);
    }
    
    self.frame = CGRectMake(popupX, popupY, self.frame.size.width, self.frame.size.height);
    
    // 三角相对本窗口的坐标
    CGPoint trianglePoint = CGPointMake(point.x - CGRectGetMinX(self.frame), isUp ? 0 : self.frame.size.height);
    
    CGFloat maskTop = isUp ? self.triangleH : 0; // 顶部Y值
    CGFloat maskBottom = isUp ? self.frame.size.height : self.frame.size.height - self.triangleH; // 底部Y值
    UIBezierPath *maskPath = [UIBezierPath bezierPath];
    // 左上圆角
    [maskPath moveToPoint:CGPointMake(0, self.cornerRadius + maskTop)];
    [maskPath addArcWithCenter:CGPointMake(self.cornerRadius, self.cornerRadius + maskTop)
                        radius:self.cornerRadius
                    startAngle:M_PI
                      endAngle:1.5*M_PI
                     clockwise:YES];
    // 三角朝上
    if (isUp) {
        [maskPath addLineToPoint:CGPointMake(trianglePoint.x - self.triangleW/2, self.triangleH)];
        [maskPath addQuadCurveToPoint:CGPointMake(trianglePoint.x - self.triangleCornerRadius, self.triangleCornerRadius)
                         controlPoint:CGPointMake(trianglePoint.x - self.triangleW/2 + self.triangleCornerRadius, self.triangleH)];
        [maskPath addQuadCurveToPoint:CGPointMake(trianglePoint.x + self.triangleCornerRadius, self.triangleCornerRadius)
                         controlPoint:trianglePoint];
        [maskPath addQuadCurveToPoint:CGPointMake(trianglePoint.x + self.triangleW/2, self.triangleH)
                         controlPoint:CGPointMake(trianglePoint.x + self.triangleW/2 - self.triangleCornerRadius, self.triangleH)];
    }
    // 右上圆角
    [maskPath addLineToPoint:CGPointMake(self.frame.size.width - self.cornerRadius, maskTop)];
    [maskPath addArcWithCenter:CGPointMake(self.frame.size.width - self.cornerRadius, maskTop + self.cornerRadius)
                        radius:self.cornerRadius
                    startAngle:1.5*M_PI
                      endAngle:0
                     clockwise:YES];
    // 右下圆角
    [maskPath addLineToPoint:CGPointMake(self.frame.size.width, maskBottom - self.cornerRadius)];
    [maskPath addArcWithCenter:CGPointMake(self.frame.size.width - self.cornerRadius, maskBottom - self.cornerRadius)
                        radius:self.cornerRadius
                    startAngle:0
                      endAngle:0.5*M_PI
                     clockwise:YES];
    // 三角朝下
    if (!isUp) {
        [maskPath addLineToPoint:CGPointMake(trianglePoint.x + self.triangleW/2, self.frame.size.height - self.triangleH)];
        [maskPath addQuadCurveToPoint:CGPointMake(trianglePoint.x + self.triangleCornerRadius, self.frame.size.height - self.triangleCornerRadius)
                         controlPoint:CGPointMake(trianglePoint.x + self.triangleW/2 - self.triangleCornerRadius, self.frame.size.height - self.triangleH)];
        [maskPath addQuadCurveToPoint:CGPointMake(trianglePoint.x - self.triangleCornerRadius, self.frame.size.height - self.triangleCornerRadius)
                         controlPoint:trianglePoint];
        [maskPath addQuadCurveToPoint:CGPointMake(trianglePoint.x - self.triangleW/2, self.frame.size.height - self.triangleH)
                         controlPoint:CGPointMake(trianglePoint.x - self.triangleW/2 + self.triangleCornerRadius, self.frame.size.height - self.triangleH)];
    }
    // 左下圆角
    [maskPath addLineToPoint:CGPointMake(self.cornerRadius, maskBottom)];
    [maskPath addArcWithCenter:CGPointMake(self.cornerRadius, maskBottom - self.cornerRadius)
                        radius:self.cornerRadius
                    startAngle:0.5*M_PI
                      endAngle:M_PI
                     clockwise:YES];
    [maskPath closePath];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = maskPath.CGPath;
    shapeLayer.lineWidth = 1/[UIScreen mainScreen].scale;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    shapeLayer.strokeColor = self.needBorder ? self.lineColor.CGColor : [UIColor clearColor].CGColor;
    [self.layer insertSublayer:shapeLayer atIndex:0];
    
    // 弹出动画
    self.maskView.alpha = 0;
    CGRect oldFrame = self.frame;
    self.layer.anchorPoint = CGPointMake(trianglePoint.x/self.frame.size.width, isUp ? 0.f : 1.f);
    self.frame = oldFrame;
    self.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    [UIView animateWithDuration:0.25f animations:^{
        self.transform = CGAffineTransformIdentity;
        self.maskView.alpha = 1.f;
    }];
}

- (void)showTriangleInView:(UIView*)view {
    CGRect pointViewRect = [view.superview convertRect:view.frame toView:[UIApplication sharedApplication].keyWindow];
    // 弹窗箭头指向的点
    CGPoint toPoint = CGPointMake(CGRectGetMidX(pointViewRect), 0);
    if (CGRectGetMidY(pointViewRect) < [UIApplication sharedApplication].keyWindow.frame.size.height/2) {
        toPoint.y = CGRectGetMaxY(pointViewRect) + 2;
    } else {
        toPoint.y = CGRectGetMinY(pointViewRect) - 2;
    }
    [self showTriangleInPoint:toPoint];
}

- (void)dismiss {
    [self removeFromSuperview];
    [self.maskView removeFromSuperview];
}

#pragma mark - 私有方法
//根据字数调整最大宽度
- (void)adjustMaxWidth {
    CGFloat textW = 0.0;
    CGFloat imageW = 0.0;
    for (NSInteger i = 0; i < self.titles.count; i++) {
        NSString *title = self.titles[i];
        NSStringDrawingOptions opts = NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading;
        CGRect rect = [title boundingRectWithSize:CGSizeZero
                                         options:opts
                                      attributes:@{NSFontAttributeName: self.textFont}
                                         context:nil];
        
        textW = textW > rect.size.width ? textW : rect.size.width;
        
        UIImage *image = self.images[i];
        imageW = imageW > image.size.width ? imageW : image.size.width;
    }
    self.frame = CGRectMake(0, 0, textW + imageW + self.iconMargin * 3, self.rowHeight * self.titles.count + self.triangleH);
}

//将maskView和popup加到window上
- (void)addToWindow {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.maskView.frame = window.bounds;
    [window addSubview:self.maskView];
    
    //点击手势
    UITapGestureRecognizer *tapGestureRecognizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tapGestureRecognizer.cancelsTouchesInView = NO;//为yes只响应优先级最高的事件，Button高于手势，textfield高于手势，textview高于手势，手势高于tableview。为no同时都响应，默认为yes
    [self.maskView addGestureRecognizer:tapGestureRecognizer];
    
    [window addSubview:self];
}

#pragma mark - Property
- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor clearColor];
    }
    return _maskView;
}

@end
