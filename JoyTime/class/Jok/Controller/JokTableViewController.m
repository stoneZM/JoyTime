//
//  JokTableViewController.m
//  JoyTime
//
//  Created by stone on 2017/1/12.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "JokTableViewController.h"
#import "JokViewModel.h"
#import "JokCell.h"

static NSString* reuseIdentifier = @"JokCell";

@interface JokTableViewController ()

@property (nonatomic,strong) JokViewModel* viewModel;
@property (nonatomic,strong)UIView* tipView;
@property (nonatomic,strong)UILabel* label;

@end


@implementation JokTableViewController


-(UIView *)tipView{
    if (_tipView == nil) {
        _tipView = [[UIView alloc]init];
        _tipView.height = 30;
        _tipView.x = 0;
        _tipView.y = 34;
        _tipView.width = ZMSCREENW;
        self.label = [[UILabel alloc]init];
        [_tipView addSubview:self.label];
        self.label.frame = _tipView.bounds;
        [self.navigationController.view insertSubview:_tipView belowSubview:self.navigationController.navigationBar];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor whiteColor];
        _tipView.backgroundColor = ZMRandomColor;
        _tipView.hidden = YES;
    }
    return _tipView;
}

-(JokViewModel *)viewModel{
    
    if (_viewModel == nil) {
        _viewModel = [[JokViewModel alloc]initWithRequestType:self.type];
    }
    return _viewModel;
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"片段";
    [self.tableView registerNib:[UINib nibWithNibName:@"JokCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.estimatedRowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getDataFromCache];
    [self refresh];
    [self getMore];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:LoginSuccedNotifucation object:nil];
}



-(void)refresh{
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        [self.viewModel refreshDataCompletionHandle:^(NSError *error) {
            [self endRefresh];
            if (error) {
             
                return ;
            }
            [self.tableView reloadData];
            [self setSeparator];
        }];
    }];
    
    [self beginRefresh];
}

-(void)getMore{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.viewModel getMoreDataCompletionHandle:^(NSError *error) {
            
            if (error) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                return ;
            }
             [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
      
        }];
    }];
}

#pragma mark 获取缓存数据
-(void)getDataFromCache{
    [self.viewModel getCacheDataCompletionHandle:^(BOOL isSuccess) {
        if (isSuccess) {
            [self.tableView reloadData];
            [self refresh];
        }
    }];
}


-(void)endRefresh{
     [self.tableView.mj_header endRefreshing];
}
-(void)beginRefresh{
    [self.tableView.mj_header beginRefreshing];
}

-(void)animationTipView{
    self.tipView.hidden = NO;
    [UIView animateWithDuration:1 animations:^{
        self.tipView.y = 64;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            self.tipView.y = 34;
        } completion:^(BOOL finished) {
            self.tipView.hidden = YES;
        }];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.viewModel.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JokCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"JokCell" owner:nil options:nil].firstObject;
    }
    cell.jok = [self.viewModel getJokForCellAtRow:indexPath.row];
   
    return cell;
}

-(void)setSeparator
{
    //    self.tableView.separatorColor = [UIColor redColor];
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle =       UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
}




@end
