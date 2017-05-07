//
//  ZMSearchBar.m
//  自定义搜索框
//
//  Created by stone on 2016/10/21.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ZMSearchBar.h"
#import "ZMSearchBarController.h"
@interface ZMSearchBar() <UISearchBarDelegate>

@end

@implementation ZMSearchBar

+(ZMSearchBar*)standSearchBar{
    static ZMSearchBar* zmSearchBar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zmSearchBar = [[ZMSearchBar alloc]init];
        [zmSearchBar defaultConfig];
    });
    return zmSearchBar;
}
-(instancetype)init{
    if (self = [super init]) {
        [self defaultConfig];
    }
    return self;
}

-(void)defaultConfig{
    [self setBackgroundImage:[UIImage new]];
    [self setSearchFieldBackgroundImage:[UIImage imageNamed:@"search_bar_bg"] forState:UIControlStateNormal];
    UITextField* tf = [self valueForKey:@"_searchField"];
    tf.placeholder = @"选份走心的礼物送给Ta";
    tf.font = [UIFont systemFontOfSize:12];
    [tf setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
}



@end
