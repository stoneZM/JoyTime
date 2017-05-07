//
//  AppDelegate+YunXin.h
//  JoyTime
//
//  Created by stone on 2017/1/15.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "AppDelegate.h"
#import "NIMSDK.h"
#import "NIMLoginManagerProtocol.h"

@interface AppDelegate (YunXin) <NIMLoginManagerDelegate>
- (void)initializeWithYunXinApplication:(UIApplication *)application ;
@end
