//
//  GMProductEvaluateTableView.h
//  GoodWine
//
//  Created by LMK on 2019/8/19.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMProductEvaluateTableView : UITableView

- (void)reloadTableViewWithDataArray:(NSArray <ProductEvaluateInfoModel *> *)dataArray;

@end

NS_ASSUME_NONNULL_END
