//
//  ViewController.m
//  LFPopupMenu
//
//  Created by 张林峰 on 2017/8/20.
//  Copyright © 2017年 张林峰. All rights reserved.
//

#import "ViewController.h"
#import "LFPopupMenu.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//加阴影的弹窗
- (IBAction)action1:(id)sender {
    LFPopupMenu *optionsView = [[LFPopupMenu alloc] init];
    optionsView.needShadow = YES;
    NSArray *images = @[[UIImage imageNamed:@"el_icon_menu_record_normal"],[UIImage imageNamed:@"el_icon_menu_shoot_normal"],[UIImage imageNamed:@"el_icon_menu_album_normal"]];
    [optionsView configWithTitles:@[@"小视频",@"拍照",@"相册"]
                           images:images
                           action:^(NSInteger index) {
                               NSLog(@"点击了第%li个",index);
                           }];
    
    [optionsView showTriangleInView:sender];
}

//自定义背景图的弹窗
- (IBAction)action2:(UIButton *)sender {
    LFPopupMenu *optionsView = [[LFPopupMenu alloc] init];
    optionsView.imgBG = [[UIImage imageNamed:@"el_img_menu_frame_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20) resizingMode:UIImageResizingModeStretch];;
    optionsView.needShadow = YES;
    NSArray *images = @[[UIImage imageNamed:@"el_icon_menu_record_normal"],[UIImage imageNamed:@"el_icon_menu_shoot_normal"],[UIImage imageNamed:@"el_icon_menu_album_normal"]];
    [optionsView configWithTitles:@[@"小视频",@"拍照",@"相册"]
                           images:images
                           action:^(NSInteger index) {
                               NSLog(@"点击了第%li个",index);
                           }];
    
    [optionsView showInPoint:CGPointMake(CGRectGetMidX(sender.frame) - (optionsView.frame.size.width - 12), CGRectGetMaxY(sender.frame))];
}

//加边框的弹窗
- (IBAction)action3:(id)sender {
    LFPopupMenu *optionsView = [[LFPopupMenu alloc] init];
    optionsView.needBorder = YES;
    NSArray *images = @[[UIImage imageNamed:@"el_icon_menu_record_normal"],[UIImage imageNamed:@"el_icon_menu_shoot_normal"],[UIImage imageNamed:@"el_icon_menu_album_normal"]];
    [optionsView configWithTitles:@[@"小视频",@"拍照",@"相册"]
                           images:images
                           action:^(NSInteger index) {
                               NSLog(@"点击了第%li个",index);
                           }];
    
    [optionsView showTriangleInView:sender];
}

//加遮罩的弹窗
- (IBAction)action4:(id)sender {
    LFPopupMenu *optionsView = [[LFPopupMenu alloc] init];
    optionsView.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    NSArray *images = @[[UIImage imageNamed:@"el_icon_menu_record_normal"],[UIImage imageNamed:@"el_icon_menu_shoot_normal"],[UIImage imageNamed:@"el_icon_menu_album_normal"]];
    [optionsView configWithTitles:@[@"小视频",@"拍照",@"相册"]
                           images:images
                           action:^(NSInteger index) {
                               NSLog(@"点击了第%li个",index);
                           }];
    
    [optionsView showTriangleInView:sender];
}

//阴影+边框的弹窗
- (IBAction)action5:(id)sender {
    LFPopupMenu *optionsView = [[LFPopupMenu alloc] init];
    optionsView.needBorder = YES;
    optionsView.needShadow = YES;
    NSArray *images = @[[UIImage imageNamed:@"el_icon_menu_record_normal"],[UIImage imageNamed:@"el_icon_menu_shoot_normal"],[UIImage imageNamed:@"el_icon_menu_album_normal"]];
    [optionsView configWithTitles:@[@"小视频",@"拍照",@"相册"]
                           images:images
                           action:^(NSInteger index) {
                               NSLog(@"点击了第%li个",index);
                           }];
    
    [optionsView showTriangleInView:sender];
}

//边框+遮罩的弹窗
- (IBAction)action6:(id)sender {
    LFPopupMenu *optionsView = [[LFPopupMenu alloc] init];
    optionsView.needBorder = YES;
    optionsView.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    NSArray *images = @[[UIImage imageNamed:@"el_icon_menu_record_normal"],[UIImage imageNamed:@"el_icon_menu_shoot_normal"],[UIImage imageNamed:@"el_icon_menu_album_normal"]];
    [optionsView configWithTitles:@[@"小视频",@"拍照",@"相册"]
                           images:images
                           action:^(NSInteger index) {
                               NSLog(@"点击了第%li个",index);
                           }];
    
    [optionsView showTriangleInView:sender];
}

@end
