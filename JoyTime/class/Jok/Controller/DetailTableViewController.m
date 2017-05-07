//
//  DetailTableViewController.m
//  JoyTime
//
//  Created by stone on 2017/1/24.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "DetailTableViewController.h"
#import "DetailHeaderView.h"
#import "UserDetailViewModel.h"
#import "JokCell.h"
#import "DetailCell.h"

@interface DetailTableViewController ()

@property (nonatomic, strong)DetailHeaderView* headerView;
@property (nonatomic,strong)UserDetailViewModel* viewModel;

@end

@implementation DetailTableViewController


-(instancetype)initWithUid:(NSString *)uid{
    if (self = [super init]) {
        self.uid = uid;
    }
    return self;
}

-(DetailHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [[NSBundle mainBundle] loadNibNamed:@"DetailHeaderView" owner:nil options:nil].firstObject;
        self.tableView.tableHeaderView = _headerView;
        self.tableView.tableHeaderView.height = 300;
    }
    return _headerView;
}

-(UserDetailViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = [[UserDetailViewModel alloc]initWithUid:self.uid];
    }
    return _viewModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellReuseIdentifier:@"DetailCell"];
    self.tableView.estimatedRowHeight = 200;
    [self refresh];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    在viewWillDisappear里面重置一下
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}


-(void)refresh{
    [self.viewModel getDataFromNetCompleteHandle:^(NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"加载出现错误"];
            return ;
        }
        self.headerView.model = [self.viewModel getUserInfo];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.viewModel.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
    if (cell == nil) {
       cell = [[NSBundle mainBundle]loadNibNamed:@"DetailCell" owner:nil options:nil].firstObject;
    }
//    UserDetailModel* model = self.viewModel.dataArr[indexPath.row];
    cell.jok = [self.viewModel userJokForRow:indexPath.row];
    return cell;
    
}




@end
