//
//  GMCollectionView.h
//  GoodWine
//
//  Created by LMK on 2019/7/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMCollectionViewDelegate <NSObject>

- (void)userCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface GMCollectionView : UICollectionView

@property (nonatomic, weak) id <GMCollectionViewDelegate> collectionDelegate;

@end

NS_ASSUME_NONNULL_END
