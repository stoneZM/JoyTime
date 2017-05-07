//
//  ZMCustomtextField.m
//  BaiSi
//
//  Created by stone on 16/9/8.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ZMCustomtextField.h"

static NSString* ZMPlaceHolderColorKeyPath = @"_placeholderLabel.textColor";
static NSString* ZMPlaceHolderFontKeyPath = @"_placeholderLabel.font";
@implementation ZMCustomtextField
/*
+(void)initialize{

    // 查看控件所有的成员变量，包括被隐藏的成员变量
    unsigned int count = 0;
    Ivar* ivars = class_copyIvarList([UITextField class], &count);

    for (int i=0; i<count; i++) {
        // 取出成员变量
        Ivar ivar = *(ivars+i);
        //打印成员变量的名字
        NSLog(@"%s",ivar_getName(ivar));
    }
    //手动释放
        free(ivars)
}
*/

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setUI];
}
-(void)setUI{
     //利用kvc直接给想改变的属性赋值 --改变占位字符的颜色和大小
    [self setValue:[UIColor colorWithWhite:0.8 alpha:0.8] forKeyPath:ZMPlaceHolderColorKeyPath];
    [self setValue:[UIFont systemFontOfSize:12] forKeyPath:ZMPlaceHolderFontKeyPath];

    //改变指示标志的颜色
    self.textColor = [UIColor whiteColor];   //输入字体的颜色
    self.tintColor = self.textColor;
    self.font = [UIFont systemFontOfSize:16]; //输入字体的大小
    ZMLogfunc;
}
/**
 重写resignFirstResponder 改变站位字符的颜色
 */

-(BOOL)resignFirstResponder{

    [self setValue:[UIColor colorWithWhite:0.8 alpha:0.8] forKeyPath:ZMPlaceHolderColorKeyPath];
    return [super resignFirstResponder];
}
/**
 重写becomeFirstResponder 改变站位字符的颜色
 */
-(BOOL)becomeFirstResponder{

    [self setValue:[UIColor whiteColor] forKeyPath:ZMPlaceHolderColorKeyPath];
    return [super becomeFirstResponder];

}




@end
