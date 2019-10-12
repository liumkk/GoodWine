//
//  GMProductDetailTableView.h
//  GoodWine
//
//  Created by LMK on 2019/8/16.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMProductDetailTableViewDelegate <NSObject>

- (void)productDetailScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)productDetailTableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)showAllEvaluate;

@end

@interface GMProductDetailTableView : UITableView

@property (nonatomic, weak) id <GMProductDetailTableViewDelegate> productDetailDelegate;

- (void)reloadTableViewWithModel:(GMProductDetailModel *)model evaluateArray:(NSArray <ProductEvaluateInfoModel *>*)evaluateArray;

@end

NS_ASSUME_NONNULL_END
