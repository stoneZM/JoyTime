//
//  OtherViewController.m
//  JoyTime
//
//  Created by stone on 2017/1/11.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "AttentionListController.h"
#import "JokCell.h"
#import "AttentionViewModel.h"
#import "JokCell.h"
#import "LoginViewController.h"
#import "PlaceHolderView.h"

static NSString* reuseIdentifier = @"JokCell";
@interface AttentionListController ()
@property (nonatomic,strong)AttentionViewModel* viewModel;
@end

@implementation AttentionListController
{
    PlaceHolderView* _placeHodlerView;
}

-(AttentionViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = [[AttentionViewModel alloc]init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = ZMGlobolgb;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"JokCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.estimatedRowHeight = 100;
    [self addNotification];
  
    if (![LoginViewController isLogin]) {
        [self addPlaceHolderView];
        return;
    }
    
    [self refresh];
  
}

-(void)addNotification{
    
    NSNotificationCenter* noti = [NSNotificationCenter defaultCenter];
    
    [noti addObserver:self selector:@selector(refresh) name:CancleAttentionNotification object:nil];
    [noti  addObserver:self selector:@selector(refresh) name:AddAttentionNotification object:nil];
    [noti addObserver:self selector:@selector(refresh) name:CancleAttentionNotification object:nil];
    [noti addObserver:self selector:@selector(hasLogin) name:LoginSuccedNotifucation object:nil];
    [noti addObserver:self selector:@selector(hasLogout) name:LogoutNotification object:nil];
}


-(void)refresh{
    if (![LoginViewController isLogin]) {
        return;
    }
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
       [self.viewModel getDataFromNetCompleteHandle:^(NSError *error) {
          [self.tableView.mj_header endRefreshing];
           if (error) {
               return ;
           }
           [self.tableView reloadData];
       }];
    }];
    [self.tableView.mj_header beginRefreshing];
}


-(void)hasLogin{
    ZMLogfunc;
    [_placeHodlerView removeFromSuperview];
    [self refresh];
}
-(void)hasLogout{
    [self addPlaceHolderView];
}

-(void)addPlaceHolderView{
    _placeHodlerView = [PlaceHolderView standPlaceHoldView];
    [self.tableView addSubview:_placeHodlerView];
    _placeHodlerView.frame = self.tableView.bounds;
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

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




@end
