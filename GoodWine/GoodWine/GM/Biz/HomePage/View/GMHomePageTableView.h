//
//  GMHomePageTableView.h
//  GoodWine
//
//  Created by LMK on 2019/5/28.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WineAreaType){
    WineAreaTypeWhite = 1,
    WineAreaTypeRed,
    WineAreaTypeOther,
    WineAreaTypeCoupon
};

@protocol GMHomePageTableViewDelegate <NSObject>

- (void)collectionViewDidSelectItemWithModel:(HomePageTypeItem *)model;
- (void)clickWineAreaWithAreaType:(WineAreaType)type;
- (void)clickAdvertiseWithProductId:(NSString *)productId;
@end

@interface GMHomePageTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id <GMHomePageTableViewDelegate> homePageTVDelegate;

- (void)updateBannerImageWithHomePageInfoModel:(HomePageInfoModel *)infoModel;
- (void)reloadHomePageTableViewWithHomePageInfoModel:(HomePageInfoModel *)infoModel;

@end

NS_ASSUME_NONNULL_END
