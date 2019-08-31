//
//  ProductEvaluateInfoModel.h
//  GoodWine
//
//  Created by LMK on 2019/8/19.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductEvaluateInfoModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *evaluateId;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *memberNickName;
@property (nonatomic, assign) NSInteger productStar; //商品评价星数：0->5
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *memberIcon; //评论用户头像
@property (nonatomic, copy) NSString *anonymous; //是否匿名  1->匿名  0->不匿名
@property (nonatomic, copy) NSString *deliveryStar; //送货评价星数：0-5
@property (nonatomic, copy) NSString *satisfactionStar; //服务满意度评价星数：0-5
@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) CGFloat contentHeight;

+ (instancetype)productEvaluateInfoModelWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
