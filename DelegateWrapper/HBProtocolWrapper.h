//
//  HBProtocolWrapper.h
//  DelegateWrapper
//
//  Created by Frederic on 2017/6/13.
//  Copyright © 2017年 honeyeeb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HBDemoProtocol;

struct HBDemoProtocolAvalibale {
    BOOL sayHello   : 1;
    BOOL sayBye     : 1;
    
};
typedef struct HBDemoProtocolAvalibale HBDemoProtocolAvalibale;

typedef void(^HBDemoProtocolBlock)(id<HBDemoProtocol> delegate, HBDemoProtocolAvalibale delegateAvalible);

/**
 HBDemoProtocol 协议包装器
 */
@interface HBProtocolWrapper : NSObject

@property (nonatomic, weak) id<HBDemoProtocol> delegate;

@property (atomic, readonly) HBDemoProtocolAvalibale delegateAvalible;

@property (nonatomic, strong) dispatch_queue_t dispatchQueue;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

#pragma mark - Perform

- (void)performDelegateBlock:(HBDemoProtocolBlock)block;
- (void)performDelegateQueueBlock:(dispatch_block_t)block;

@end
