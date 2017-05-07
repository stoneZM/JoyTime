//
//  JokCommentCell.m
//  JoyTime
//
//  Created by stone on 2017/1/14.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "JokCommentCell.h"

@interface JokCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *content;



@end

@implementation JokCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.profileImg.layer.cornerRadius = 16.5;
    self.profileImg.layer.masksToBounds = YES;
}


-(void)setModel:(JokCommentDataModel *)model{
    
    JokUserModel* user = model.u;
    [self.profileImg sd_setImageWithURL:[NSURL URLWithString:user.profileImg] placeholderImage:[UIImage imageNamed:@"Profile_noneAvatarBg"]];
    
    self.nickName.text = user.nickName;
    self.createTime.text = model.createTime;
    self.content.text = model.content;
    
}


@end
