//
//  Color.h
//  JoyTime
//
//  Created by stone on 2017/1/13.
//  Copyright © 2017年 stone. All rights reserved.
//

#ifndef Color_h
#define Color_h


/**定义颜色方法**/
#define ZMRGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define ZMGlobolgb [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00]
#define ZMRandomColor [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1]


/*menu配置项*/
#define MenuHeight            30
#define MenuColor             [UIColor clearColor];
#define MenuTitleNormalColor  [UIColor colorWithRed:0.10 green:0.10 blue:0.10 alpha:1.00]
#define MenuTitleSelectColor  [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:1.00]
#define MenuTitleSizeNormal   14
#define MenutitleSizeSelect   16

#endif /* Color_h */
