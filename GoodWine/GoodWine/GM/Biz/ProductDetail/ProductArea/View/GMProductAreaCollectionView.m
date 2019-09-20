//
//  GMProductAreaCollectionView.m
//  GoodWine
//
//  Created by LMK on 2019/8/27.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMProductAreaCollectionView.h"
#import "GMWineListCollectionViewCell.h"

#define ItemHeight   245.f

static NSString *productAreaCellId = @"productAreaCellId";

@interface GMProductAreaCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray <HomePageTypeItem *> *dataArray;


@end

@implementation GMProductAreaCollectionView

//- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
//    self = [super initWithFrame:frame collectionViewLayout:layout];
//    if (self) {
//
//        self.dataSource = self;
//        self.delegate = self;
//        [self registerClass:[GMWineListCollectionViewCell class] forCellWithReuseIdentifier:productAreaCellId];
//    }
//    return self;
//}
- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((Width_Screen - 75)/2.f, ItemHeight);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        self.showsVerticalScrollIndicator = YES;
        self.alwaysBounceVertical = YES;
        [self registerClass:[GMWineListCollectionViewCell class] forCellWithReuseIdentifier:productAreaCellId];
    }
    return self;
}

- (void)reloadProductAreaCollectionWithDataArray:(NSArray <HomePageTypeItem *> *)array {
    self.dataArray = array;
    [self reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GMWineListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:productAreaCellId forIndexPath:indexPath];
    [cell updateWineListCollectionCellWithHomePageTypeItem:self.dataArray[indexPath.item]];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.titleLabel.font = Font(14.f);
    cell.promotionPriceLabel.font = Font(13.f);
    cell.originalPriceLabel.font = Font(10.f);
    cell.saleLabel.font = Font(10.f);
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.productAreaCVDelegate && [self.productAreaCVDelegate respondsToSelector:@selector(collectionViewDidSelectItemWithModel:)]) {
        [self.productAreaCVDelegate collectionViewDidSelectItemWithModel:self.dataArray[indexPath.item]];
    }
}


@end
