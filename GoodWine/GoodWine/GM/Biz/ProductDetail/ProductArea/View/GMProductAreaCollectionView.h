//
//  GMProductAreaCollectionView.h
//  GoodWine
//
//  Created by LMK on 2019/8/27.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMProductAreaCollectionViewDelegate <NSObject>

- (void)collectionViewDidSelectItemWithModel:(HomePageTypeItem *)model;

@end

@interface GMProductAreaCollectionView : UICollectionView

@property (nonatomic, weak) id <GMProductAreaCollectionViewDelegate> productAreaCVDelegate;

- (void)reloadProductAreaCollectionWithDataArray:(NSArray <HomePageTypeItem *> *)array;

@end

NS_ASSUME_NONNULL_END
