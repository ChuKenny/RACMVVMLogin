//
//  LoginViewModel.h
//  LoginMVVM
//
//  Created by qunye zhu on 2018/8/17.
//  Copyright © 2018年 qunye zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

@interface LoginViewModel : NSObject
@property (nonatomic, copy) NSString *account;/**  账号 */
@property (nonatomic, copy) NSString *pwd;/**  密码 */
@property (nonatomic, strong) RACSignal *loginEnableSignal;/**  可登录信号  */
@property (nonatomic, strong) RACCommand * loginCommand;/** 登录按钮命令  */

@property (nonatomic, copy) NSString *verfiyBtnTitle;//倒计时按钮标题
@property (nonatomic, strong) RACSignal *sendBtnSignal;/**  发送验证码信号  */
@property (nonatomic, strong) RACCommand *sendBtnCommand;/**  发送验证码命令  */

@end
