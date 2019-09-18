//
//  GMSearchCollectionView.m
//  GoodWine
//
//  Created by LMK on 2019/9/18.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMSearchCollectionView.h"
#import "GMWineListCollectionViewCell.h"

static NSString *searchCollectionCellId = @"searchCollectionCellId";

@interface GMSearchCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray <HomePageTypeItem *>*dataArray;

@end

@implementation GMSearchCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(Width_Screen/2 - 11.f, itemHeight);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 0; //y边距
    flowLayout.minimumInteritemSpacing = 0; //x边距
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.backgroundColor = COLOR_TABLE_BG_RAY;
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = YES;
        self.alwaysBounceVertical = YES;
        [self registerClass:[GMWineListCollectionViewCell class] forCellWithReuseIdentifier:searchCollectionCellId];
    }
    return self;
}

- (void)reloadStoreDetailCollectionViewWithDataArray:(NSMutableArray<HomePageTypeItem *> *)datatArray {
    self.dataArray = datatArray;
    [self reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GMWineListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:searchCollectionCellId forIndexPath:indexPath];
    [cell updateWineListCollectionCellWithHomePageTypeItem:self.dataArray[indexPath.item]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.searchCollectionDelegate && [self.searchCollectionDelegate respondsToSelector:@selector(searchCollectionView:didSelectItemModel:)]) {
        [self.searchCollectionDelegate searchCollectionView:collectionView didSelectItemModel:self.dataArray[indexPath.item]];
    }
}

@end
