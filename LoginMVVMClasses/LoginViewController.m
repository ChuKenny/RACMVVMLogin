//
//  LoginViewController.m
//  LoginMVVM
//
//  Created by qunye zhu on 2018/8/16.
//  Copyright © 2018年 qunye zhu. All rights reserved.
//

#import "LoginViewController.h"
#import <ReactiveObjC.h>
#import "LoginViewModel.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (copy, nonatomic) NSString *sendBtnTitle;/**  验证码标题  */
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (nonatomic, strong) LoginViewModel *loginViewModel;/** 试图模型   */


@end

@implementation LoginViewController

- (LoginViewModel *)loginViewModel {
    if (!_loginViewModel) {
        _loginViewModel = [[LoginViewModel alloc] init];
    }
    return _loginViewModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    RAC(self.loginViewModel, account) = self.accountField.rac_textSignal;
    RAC(self.loginViewModel, pwd) = self.pwdField.rac_textSignal;
    [[self.loginViewModel rac_valuesForKeyPath:@"verfiyBtnTitle" observer:self] subscribeNext:^(id  _Nullable x) {
        [self.sendBtn setTitle:x forState:UIControlStateNormal];
    }];
}

- (IBAction)sendVerifyCode:(id)sender {
    if (self.sendBtn.enabled) {
        NSLog(@"%@", @"发送验证码请求！");
        [self.loginViewModel.sendBtnCommand execute:@"发送验证码请求！"];
    }
}

- (IBAction)login:(id)sender {
    NSLog(@"%@", @"账号密码");
    [self.loginViewModel.loginCommand execute:@"账号密码"];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
