//
//  GMSearchCollectionView.h
//  GoodWine
//
//  Created by LMK on 2019/9/18.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define itemHeight      255.f

@protocol GMSearchCollectionViewDelegate <NSObject>

- (void)searchCollectionView:(UICollectionView *)collectionView didSelectItemModel:(HomePageTypeItem *)model;

@end

@interface GMSearchCollectionView : UICollectionView

@property (nonatomic, weak) id <GMSearchCollectionViewDelegate> searchCollectionDelegate;

- (void)reloadStoreDetailCollectionViewWithDataArray:(NSMutableArray<HomePageTypeItem *> *)datatArray;

@end

NS_ASSUME_NONNULL_END
