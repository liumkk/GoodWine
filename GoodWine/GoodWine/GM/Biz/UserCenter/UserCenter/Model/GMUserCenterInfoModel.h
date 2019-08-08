//
//  GMUserCenterInfoModel.h
//  GoodWine
//
//  Created by LMK on 2019/7/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMUserCenterInfoModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *memberId;
@property (nonatomic, copy, readonly) NSString *username;
@property (nonatomic, copy, readonly) NSString *nickname;
@property (nonatomic, copy, readonly) NSString *password;
@property (nonatomic, copy, readonly) NSString *phone;
@property (nonatomic, copy, readonly) NSString *createTime;
@property (nonatomic, copy, readonly) NSString *birthday;
@property (nonatomic, copy, readonly) NSString *city;
@property (nonatomic, copy, readonly) NSString *job;

+ (instancetype)userCenterModelWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
