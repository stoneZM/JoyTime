//
//  DetailTableViewController.h
//  JoyTime
//
//  Created by stone on 2017/1/24.
//  Copyright © 2017年 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewController : UITableViewController

@property (nonatomic,strong)NSString* uid;

-(instancetype)initWithUid:(NSString*)uid;

@end
