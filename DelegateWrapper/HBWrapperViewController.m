//
//  HBWrapperViewController.m
//  DelegateWrapper
//
//  Created by Frederic on 2017/6/13.
//  Copyright © 2017年 honeyeeb. All rights reserved.
//

#import "HBWrapperViewController.h"
#import "HBWrapperModel.h"
#import "HBDemoProtocol.h"

@interface HBWrapperViewController ()<HBDemoProtocol>

@property (nonatomic, strong) HBWrapperModel *wrapperModel;

@end

@implementation HBWrapperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (HBWrapperModel *)wrapperModel {
    if (!_wrapperModel) {
        _wrapperModel = [[HBWrapperModel alloc] init];
        _wrapperModel.delegate = self;
    }
    return _wrapperModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sayHelloAction:(id)sender {
    [self.wrapperModel sayHelloAction];
}

- (IBAction)sayByeAction:(id)sender {
    [self.wrapperModel sayByeAction];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)alertTitle:(NSString *)title {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)sayHello {
    [self alertTitle:@"sayHello2"];
}

- (void)sayBye {
    [self alertTitle:@"sayBye2"];
}

@end
