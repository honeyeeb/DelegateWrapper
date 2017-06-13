//
//  HBWrapperModel.m
//  DelegateWrapper
//
//  Created by Frederic on 2017/6/13.
//  Copyright © 2017年 honeyeeb. All rights reserved.
//

#import "HBWrapperModel.h"

#import "HBDemoProtocol.h"
#import "HBProtocolWrapper.h"

@interface HBWrapperModel()

@property (nonatomic, strong) HBProtocolWrapper *protocolWrapper;

@end

@implementation HBWrapperModel

- (HBProtocolWrapper *)protocolWrapper {
    if (!_protocolWrapper) {
        _protocolWrapper = [[HBProtocolWrapper alloc] init];
    }
    return _protocolWrapper;
}

- (void)setDelegate:(id<HBDemoProtocol>)delegate {
    self.protocolWrapper.delegate = delegate;
}

- (void)sayHelloAction {
    [self.protocolWrapper performDelegateBlock:^(id<HBDemoProtocol> delegate, HBDemoProtocolAvalibale delegateAvalible) {
        if (delegateAvalible.sayHello) {
            [delegate sayHello];
        }
    }];
}

- (void)sayByeAction {
    [self.protocolWrapper performDelegateBlock:^(id<HBDemoProtocol> delegate, HBDemoProtocolAvalibale delegateAvalible) {
        if (delegateAvalible.sayBye) {
            [delegate sayBye];
        }
    }];
}

@end
