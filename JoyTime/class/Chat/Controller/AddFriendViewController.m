//
//  AddFriendViewController.m
//  JoyTime
//
//  Created by stone on 2017/1/19.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "AddFriendViewController.h"
#import "ChatNetwork.h"
#import "YunXinFriendModel.h"
#import "JokUserModel.h"
#import "AddFriCell.h"

@interface AddFriendViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray* dataArr;

@end

@implementation AddFriendViewController
{
    NSInteger _page;
    NSInteger _totalPage;
}

-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 0;
    _totalPage = 1;
    [self getRecommendFriend];
    self.navigationItem.title = @"添加好友";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"AddFriCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self getRecommendFriend];
}

- (IBAction)searchBtnClickedAction:(UIButton *)sender {
}
- (IBAction)getMoreBtnClickedAction:(UIButton *)sender {
    _page++;
    [self getRecommendFriend];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddFriCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    YunXinFriendUserModel* model = self.dataArr[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}


/****************获取数据*************************/
-(void)getRecommendFriend{
    if (_page > _totalPage-1) {
        [SVProgressHUD showInfoWithStatus:@"无更多数据了"];
        return;
    }
    NSString* page = [NSString stringWithFormat:@"%ld",_page];
    ZMSVProgressDismiss;
    [ChatNetwork getRecommendedFriendWithpage:page pageCount:@"2" completeHandle:^(id responseObj, NSError *err) {
      YunXinFriendModel* model = (YunXinFriendModel*)responseObj;
        _totalPage = model.total;
      if (err||model.err) {
          [SVProgressHUD showErrorWithStatus:@"出现未知错误"];
      }else{
          [self.dataArr removeAllObjects];
          [self.dataArr addObjectsFromArray:model.data];
          [self.tableView reloadData];
      }
  }];
    
}






@end
