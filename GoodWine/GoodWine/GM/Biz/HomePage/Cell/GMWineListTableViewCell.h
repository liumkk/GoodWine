//
//  GMWineListTableViewCell.h
//  GoodWine
//
//  Created by LMK on 2019/6/4.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMWineListTableViewCell : UITableViewCell

@property (nonatomic, strong) UICollectionView *wineListCollectionView;

- (void)updateWineListCellWithArray:(NSArray <HomePageTypeItem *> *)array;

@end

NS_ASSUME_NONNULL_END
