//
//  GMPicTableViewCell.h
//  GoodWine
//
//  Created by LMK on 2019/9/17.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMPicTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *picImageView;

- (void)updateCellWithImageName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
