//
//  HBOriginModel.m
//  DelegateWrapper
//
//  Created by Frederic on 2017/6/13.
//  Copyright © 2017年 honeyeeb. All rights reserved.
//

#import "HBOriginModel.h"

#import "HBDemoProtocol.h"

@implementation HBOriginModel

- (void)sayHelloAction {
    if ([_delegate respondsToSelector:@selector(sayHello)]) {
        [_delegate sayHello];
    }
}

- (void)sayByeAction {
    if ([_delegate respondsToSelector:@selector(sayBye)]) {
        [_delegate sayBye];
    }
}

@end
