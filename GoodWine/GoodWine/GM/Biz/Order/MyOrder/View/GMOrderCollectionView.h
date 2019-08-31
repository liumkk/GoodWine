//
//  GMOrderCollectionView.h
//  GoodWine
//
//  Created by LMK on 2019/8/1.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMOrderCollectionViewDelegate <NSObject>

- (void)orderCollectionViewDidSelectItemAtIndex:(NSInteger )index;

@end

@interface GMOrderCollectionView : UICollectionView

@property (nonatomic, weak) id <GMOrderCollectionViewDelegate> orderCollectDelegate;

@end

NS_ASSUME_NONNULL_END
