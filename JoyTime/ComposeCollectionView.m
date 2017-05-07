//
//  ComposeCollectionView.m
//  BaiSi
//
//  Created by stone on 2016/10/5.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ComposeCollectionView.h"
#import "PicCell.h"
@interface ComposeCollectionView() <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)NSMutableArray* photos;
@end

@implementation ComposeCollectionView

-(NSMutableArray *)photos{
    if (_photos == nil) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.dataSource = self;
    self.delegate = self;
    [self registerNib:[UINib nibWithNibName:@"PicCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self addLayout];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(delateAction:) name:@"DelateActionNotification" object:nil];
}
-(void)delateAction:(NSNotification*)noti{
    ZMLogfunc;
    PicCell* cell = (PicCell*)noti.object;
    NSIndexPath* indexPath = [self indexPathForCell:cell];
    [self.photos removeObjectAtIndex:indexPath.row];
    NSLog(@"%---ld",self.photos.count);
    [self reloadData];
}
-(void)addLayout{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];;
    CGFloat itemWH = (ZMSCREENW - 4*10)/3;
    CGSize itemSize = CGSizeMake(itemWH, itemWH);
    layout.itemSize = itemSize;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    self.contentInset = UIEdgeInsetsMake(10, 10, 0, 10);
    self.backgroundColor = [UIColor whiteColor];
    self.collectionViewLayout = layout;
}

-(void)setImages:(NSArray<UIImage *> *)images{

    [self.photos addObjectsFromArray:images];
    NSLog(@"----%ld",self.photos.count);
    [self reloadData];
}

#pragma mark - UICollectionDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photos.count==0 ? 1 : (self.photos.count + 1);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PicCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == self.photos.count) {
        cell.image = nil;
        return cell;
    }else{
        cell.image = self.photos[indexPath.row];
    }
    return cell;
}



@end
