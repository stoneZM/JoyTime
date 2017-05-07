//
//  JokCommentController.m
//  JoyTime
//
//  Created by stone on 2017/1/14.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "JokCommentController.h"
#import "JokCommentViewModel.h"
#import "JokCommentCell.h"
#import "LoginViewController.h"
#import "JokNetwork.h"

static NSString*  reuseIdentifier = @"JokCommentCell";

@interface JokCommentController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic ,strong)JokCommentViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *commentTf;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldBottomCons;



@end

@implementation JokCommentController
{

    NSString* _jokId;
    CGRect _keyboardFrame;
    NSInteger _keyboardAnimationOption;
    CGFloat _keyboardAnimationDuration;
}

-(instancetype)initWithJokId:(NSString *)jokId{
    if (self = [super init]) {
        _jokId = jokId;
    }
    return self;
}

-(JokCommentViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = [[JokCommentViewModel alloc]initWithJokId:_jokId];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    [self getDataFromCache];
    [self refresh];
    [self getMore];
    [self addObserverforKeyBoard];
}

-(void)refresh{
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.viewModel refreshDataCompletionHandle:^(NSError *error) {
            [self endRefresh];
            if (error) {
                return ;
            }
            if (self.viewModel.dataArr.count !=0) {
                 [self setSeparator];
                [self.tableView reloadData];
            }
        }];
    }];
    
    [self beginRefresh];
}

-(void)getMore{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.viewModel getMoreDataCompletionHandle:^(NSError *error) {
            [self.tableView.mj_footer endRefreshing];
            if (error) {
                return ;
            }
            [self.tableView reloadData];
        }];
    }];
}

#pragma mark 获取缓存数据
-(void)getDataFromCache{
    [self.viewModel getCacheDataCompletionHandle:^(BOOL isSuccess) {
        if (isSuccess) {
            [self.tableView reloadData];
        }
    }];
}
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
}
-(void)beginRefresh{
    [self.tableView.mj_header beginRefreshing];
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.viewModel.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JokCommentCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"JokCommentCell" owner:nil options:nil].lastObject;
    }
    
    cell.model = [self.viewModel getJokCommentForCellAtRow:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)setSeparator
{
    //    self.tableView.separatorColor = [UIColor redColor];
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle =       UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //发表评论
    [self addComment];
   
    return YES;
}


//对键盘增加监听事件
-(void)addObserverforKeyBoard{
    NSNotificationCenter* notificaiton = [NSNotificationCenter defaultCenter];
    [notificaiton addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [notificaiton addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardShow:(NSNotification*)noti{

 
    // 从通知的userInfo中取出键盘的高度
    _keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyboardAnimationOption = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    // 从通知的userInfo中取得动画的时长
    _keyboardAnimationDuration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    self.textFieldBottomCons.constant = _keyboardFrame.size.height;
    [UIView animateWithDuration:_keyboardAnimationDuration
                          delay:0
                        options:_keyboardAnimationOption
                     animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];

}

-(void)keyboardHidden:(NSNotification*)noti{
   
    [UIView animateWithDuration:_keyboardAnimationDuration
                          delay:0
                        options:_keyboardAnimationOption
                     animations:^{
        self.textFieldBottomCons.constant = 0;
    } completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.commentTf resignFirstResponder];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.commentTf resignFirstResponder];
}


-(void)closeKeyboard:(NSNotification *)notification
{
    // 从通知的userInfo中取得动画的选项
    NSInteger option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    // 从通知的userInfo中取得动画的时长
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // 做动画来修改约束
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
    
}

-(void)addComment{
    
    [SVProgressHUD setMinimumDismissTimeInterval:ZMMinimumDismissTimeInterval];
    if (![StoreTool getValuesForKey:USERID]) {
    
         [self login];
         return;
  
    }else if(self.commentTf.text.length == 0){
    
        [SVProgressHUD showErrorWithStatus:@"评论内容不能为空!"];
   
    }else{
       [JokNetwork addCommentForJokWithJokId:_jokId comment:self.commentTf.text completeHandle:^(id responseObj, NSError *error) {
           NSInteger err = [responseObj[@"err"] integerValue];
           if (error||err!=0) {
               [SVProgressHUD showErrorWithStatus:@"评论发表失败"];
               return ;
           }
           [SVProgressHUD showSuccessWithStatus:@"评论发表成功"];
          
           //将评论返回的结果解析成模型
            JokCommentModel* model = [JokCommentModel mj_objectWithKeyValues:responseObj];
           [self.commentTf resignFirstResponder];
           self.commentTf.text = @"";
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
           
           //插入新的数据到第一行,此处注意数据源也得插入新的模型数据才能刷新
           [self.tableView beginUpdates];
           [self.viewModel.dataArr insertObject:model.data.firstObject atIndex:0];
           [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
           [self.tableView endUpdates];
           [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
       }];
    }
}
- (IBAction)sendCommentBtn:(UIButton *)sender {
    [self addComment];
}

-(void)login{
    LoginViewController* vc = [[LoginViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
