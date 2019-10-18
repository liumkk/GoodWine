//
//  GMCollectionView.m
//  GoodWine
//
//  Created by LMK on 2019/7/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMCollectionView.h"
#import "GMUserSecondCollectionViewCell.h"

static NSString *userSecondCollectionCell = @"userSecondCollectionCell";

@interface GMCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;


@end

@implementation GMCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(Width_Screen/3 - 1.f, 90.f);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 1.f;
    flowLayout.minimumInteritemSpacing = 1.f;
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        
        [self initData];
        
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = COLOR_GRAY_244;
        self.showsVerticalScrollIndicator = YES;//关闭滚动条
        self.bounces = NO;//是否有回弹效果
        self.scrollEnabled = NO;
        self.layer.borderWidth = 1.f;
        self.layer.borderColor = COLOR_GRAY_244.CGColor;
        [self registerClass:[GMUserSecondCollectionViewCell class] forCellWithReuseIdentifier:userSecondCollectionCell];
    }
    return self;
}

- (void)initData {
    self.titleArray = @[@"地址管理", @"优惠券", @"我的关注", @"联系客服", @"设置", @"版本信息"];
    self.imageArray = @[@"address", @"coupon_icon", @"collection", @"talk_kefu_blue", @"setting_green", @"info_blue"];
}

#pragma mark - collectionView dataSource Or delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GMUserSecondCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:userSecondCollectionCell forIndexPath:indexPath];
    [cell updateCellWithImageString:self.imageArray[indexPath.item] titleText:self.titleArray[indexPath.item]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.collectionDelegate && [self.collectionDelegate respondsToSelector:@selector(userCollectionView:didSelectItemAtIndexPath:)]) {
        [self.collectionDelegate userCollectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}

@end
