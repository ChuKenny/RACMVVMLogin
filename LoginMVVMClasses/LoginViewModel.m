//
//  LoginViewModel.m
//  LoginMVVM
//
//  Created by qunye zhu on 2018/8/17.
//  Copyright © 2018年 qunye zhu. All rights reserved.
//

#import "LoginViewModel.h"
@interface LoginViewModel()
@property (nonatomic, strong) RACDisposable *sendBtnDisPosable;/**   */
@property (nonatomic, assign) int time;
@end
@implementation LoginViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)verfiyBtnTitle {
    if (!_verfiyBtnTitle) {
        _verfiyBtnTitle = @"请求验证码";
    }
    return _verfiyBtnTitle;
}

- (RACSignal *)loginEnableSignal {
    if (!_loginEnableSignal) {
        //处理登录点击的信号
        _loginEnableSignal = [RACSignal combineLatest:@[RACObserve(self, account), RACObserve(self, pwd)] reduce:^id _Nullable(NSString * account,NSString * pwd){
            return @(account.length && pwd.length);
        }];
        
    }
    return _loginEnableSignal;
}

- (RACCommand *)loginCommand {
    if (!_loginCommand) {
        //处理登录的命令
        //创建命令
        _loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            //处理事件密码加密
            NSLog(@"拿到%@",input);
            
            
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                //发送请求&&获取登录结果!!
                [subscriber sendNext:@"请求登录的数据"];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
        //获取命令中信号源
        [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@",x);
        }];
        
        //监听命令执行过程!!
        [[_loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
            
            if ([x boolValue]) {
                //正在执行
                NSLog(@"显示菊花!!");
            }else{
                NSLog(@"干掉菊花!!");
            }
        }];
    }
    return _loginCommand;
}

- (RACSignal *)sendBtnSignal {
    if (self.account.length==11) {
        _time = 10;
        _sendBtnSignal = [RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]];
        self.sendBtnDisPosable = [_sendBtnSignal subscribeNext:^(id  _Nullable x) {
            self->_time--;
            NSString *btnText = self->_time>0 ? [NSString stringWithFormat:@"请等待%d秒",self->_time] : @"重新发送";
            self.verfiyBtnTitle = btnText;
            if (self->_time<=0) {
                [self->_sendBtnDisPosable dispose];
            }
        }];
    }else{
        NSLog(@"输入账号!!");
    }
    
    return _sendBtnSignal;
}

- (RACCommand *)sendBtnCommand  {
    _sendBtnCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return self.sendBtnSignal;
    }];
    return _sendBtnCommand;
}
@end
