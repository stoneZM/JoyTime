//
//  FollowUserInfoController.m
//  JoyTime
//
//  Created by stone on 2017/1/22.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "FollowUserInfoController.h"
#import "MeNetwork.h"
#import "FollowModel.h"
#import "JokUserModel.h"
#import "iCarousel.h"
#import "CarouselView.h"
#import "DetailTableViewController.h"

@interface FollowUserInfoController ()<iCarouselDataSource, iCarouselDelegate,
                                       UIActionSheetDelegate>


@property (nonatomic,strong) NSMutableArray* dataArr;
@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) iCarousel *carousel;

@end

@implementation FollowUserInfoController

-(iCarousel *)carousel{
    
    if (_carousel == nil) {
        _carousel = [[iCarousel alloc]initWithFrame:CGRectZero];
        [self.view addSubview:_carousel];
        _carousel.frame = self.view.bounds;
        _carousel.backgroundColor = ZMGlobolgb;
       UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_carousel addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_offset(0);
            make.bottom.mas_equalTo(-20);
            make.height.mas_equalTo(44);
            make.width.mas_equalTo(100);
        }];
        [button addTarget:self action:@selector(switchCarouselType) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"变换样式" forState:UIControlStateNormal];
        [button setTitleColor:ZMRandomColor forState:UIControlStateNormal];
    }
    return _carousel;
}

-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getFollowUserInfo];
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    _carousel.type = [StoreTool getValuesForKey:iCarouselSwitchType]? [[StoreTool getValuesForKey:iCarouselSwitchType] integerValue] : iCarouselTypeLinear;
    /*
     iCarouselTypeLinear = 0,
     iCarouselTypeRotary,
     iCarouselTypeInvertedRotary,
     iCarouselTypeCylinder,
     iCarouselTypeInvertedCylinder,
     iCarouselTypeWheel,
     iCarouselTypeInvertedWheel,
     iCarouselTypeCoverFlow,
     iCarouselTypeCoverFlow2,
     iCarouselTypeTimeMachine,
     iCarouselTypeInvertedTimeMachine,
     iCarouselTypeCustom
     */
}

-(void)getFollowUserInfo{
    
    [MeNetwork getMyFollowerInfoCompleteHandle:^(id responseObj, NSError *err) {
        FollowModel* model = (FollowModel*)responseObj;
        [self.dataArr addObjectsFromArray:model.data];
        [self.carousel reloadData];
    }];
}

- (void)dealloc
{
    _carousel.delegate = nil;
    _carousel.dataSource = nil;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.carousel = nil;
}

- (void)switchCarouselType
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Select Carousel Type"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Linear", @"Rotary", @"Inverted Rotary", @"Cylinder", @"Inverted Cylinder", @"Wheel", @"Inverted Wheel", @"CoverFlow", @"CoverFlow2", @"Time Machine", @"Inverted Time Machine", @"Custom", nil];
    [sheet showInView:self.view];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    return (NSInteger)[self.dataArr count];
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    CarouselView *myview=nil;
    
    if (view == nil)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250.0f, 250.0f)];
        myview = [[NSBundle mainBundle]loadNibNamed:@"CarouselView" owner:nil options:nil].firstObject;
        [view addSubview:myview];
        myview.frame = view.bounds;
        myview.tag = 100;
        myview.backgroundColor = ZMRandomColor;
        [view addSubview:myview];
    }else{
        
        myview = (CarouselView *)[view viewWithTag:100];
    
    }
     myview.userModel = (JokUserModel*)self.dataArr[index];
    return view;
}

- (CATransform3D)carousel:(__unused iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0, 0.0, 1.0, 0.0);
    return CATransform3DTranslate(transform, 0.0, 0.0, offset * self.carousel.itemWidth);
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return self.wrap;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05;
        }
        case iCarouselOptionFadeMax:
        {
            if (self.carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0;
            }
            return value;
        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }
}

#pragma mark -
#pragma mark UIActionSheet methods

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex >= 0)
    {
        //map button index to carousel type
        iCarouselType type = buttonIndex;
        
        //carousel can smoothly animate between types
        [UIView beginAnimations:nil context:nil];
        
        self.carousel.type = type;
        [StoreTool ZMsetValue:[NSString stringWithFormat:@"%ld",type] forkey:iCarouselSwitchType];
        [UIView commitAnimations];
        
    }
}

#pragma mark -
#pragma mark iCarousel taps

- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    ZMLogfunc;
    JokUserModel* userModel = (JokUserModel*)self.dataArr[index];
    DetailTableViewController* commentVC = [[DetailTableViewController alloc]initWithUid:userModel.uid];
    [self.navigationController pushViewController:commentVC animated:YES];
}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
    //NSLog(@"Index: %@", @(self.carousel.currentItemIndex));
}




@end
