//
//  ZMSearchBarController.m
//  自定义搜索框
//
//  Created by stone on 2016/10/21.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ZMSearchBarController.h"
#import <objc/runtime.h>
#import "ZMSearchBar.h"


@interface ZMSearchBarController()<UISearchBarDelegate>

@end

@implementation ZMSearchBarController

-(void)addSearchBarToNavi{
    ZMSearchBar* searchBar = [ZMSearchBar standSearchBar];
    self.navigationItem.titleView = searchBar;
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(0, 0, 200, 30);
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSearchBarToNavi];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    NSLog(@"%s",__func__);
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"%s",__FUNCTION__);
}

-(void)dealloc{
    ZMLogfunc;
}


@end
