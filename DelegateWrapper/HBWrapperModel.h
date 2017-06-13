//
//  HBWrapperModel.h
//  DelegateWrapper
//
//  Created by Frederic on 2017/6/13.
//  Copyright © 2017年 honeyeeb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HBDemoProtocol;

@interface HBWrapperModel : NSObject

@property (nonatomic, weak) id<HBDemoProtocol> delegate;

- (void)sayHelloAction;
- (void)sayByeAction;

@end
