//
//  HBOriginViewController.m
//  DelegateWrapper
//
//  Created by Frederic on 2017/6/13.
//  Copyright © 2017年 honeyeeb. All rights reserved.
//

#import "HBOriginViewController.h"
#import "HBDemoProtocol.h"
#import "HBOriginModel.h"

@interface HBOriginViewController ()<HBDemoProtocol>

@property (nonatomic, strong) HBOriginModel *originModel;

@end

@implementation HBOriginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (HBOriginModel *)originModel {
    if (!_originModel) {
        _originModel = [[HBOriginModel alloc] init];
        _originModel.delegate = self;
    }
    return _originModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sayHelloAction:(id)sender {
    [self.originModel sayHelloAction];
}

- (IBAction)sayByeAction:(id)sender {
    [self. originModel sayByeAction];
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
    [self alertTitle:@"sayHello"];
}

- (void)sayBye {
    [self alertTitle:@"sayBye"];
}

@end
