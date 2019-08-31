//
//  GMWineListTableViewCell.m
//  GoodWine
//
//  Created by LMK on 2019/6/4.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMWineListTableViewCell.h"
#import "GMWineListCollectionViewCell.h"

static NSString *collectionViewCellId = @"collectionViewCellId";

@interface GMWineListTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray <HomePageTypeItem *> *dataArray;

@end

@implementation GMWineListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupConstraints];
        
        [self initWineListCollectionView];
    }
    return self;
}

- (void)initWineListCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((Width_Screen/2) - 9, 255);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    self.wineListCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(9, 0, Width_Screen-18, 255) collectionViewLayout:flowLayout];
    self.wineListCollectionView.delegate = self;
    self.wineListCollectionView.dataSource = self;
    [self.wineListCollectionView registerClass:[GMWineListCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCellId];
    self.wineListCollectionView.backgroundColor = [UIColor whiteColor];
    self.wineListCollectionView.showsVerticalScrollIndicator = YES;//关闭滚动条
    self.wineListCollectionView.bounces = NO;//是否有回弹效果
    self.wineListCollectionView.scrollEnabled = NO;
    [self.contentView addSubview:self.wineListCollectionView];
    
}
- (void)setupConstraints {
    
}

- (void)updateWineListCellWithArray:(NSArray <HomePageTypeItem *> *)array {
    self.dataArray = array;
    self.wineListCollectionView.frame = CGRectMake(9, 0, Width_Screen - 18, (self.dataArray.count/2 + self.dataArray.count %2)* 255.f);
    [self.wineListCollectionView reloadData];
}

#pragma mark - collectionView dataSource Or delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GMWineListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellId forIndexPath:indexPath];
    [cell updateWineListCollectionCellWithHomePageTypeItem:self.dataArray[indexPath.item]];
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MKNSLog(@"collecIndexPath--%ld",(long)indexPath.item);
    if (self.wineListTVCellDelegate && [self.wineListTVCellDelegate respondsToSelector:@selector(collectionViewDidSelectItemWithModel:)]) {
        [self.wineListTVCellDelegate collectionViewDidSelectItemWithModel:self.dataArray[indexPath.item]];
    }
}

@end
