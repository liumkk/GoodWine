//
//  GMRegisterTableView.h
//  GoodWine
//
//  Created by LMK on 2019/8/22.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMRegisterFooterView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GMRegisterTableViewDelegate <NSObject>

- (void)sendVerificationCodeWithPhone:(NSString *)phone;

- (void)pushProtocol;

- (void)registerTableViewNameTF:(UITextField *)nameTF
                        phoneTF:(UITextField *)phoneTF
                  verficationTF:(UITextField *)verficationTF
                     passwordTF:(UITextField *)passwordTF;

@end

@interface GMRegisterTableView : UITableView

@property (nonatomic, weak) id <GMRegisterTableViewDelegate> registerTBDelegate;
@property (nonatomic, strong) MKVerificationCodeView *verificationView;
@property (nonatomic, strong) GMRegisterFooterView *protocolView;
@end

NS_ASSUME_NONNULL_END
