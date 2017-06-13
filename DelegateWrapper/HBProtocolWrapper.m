//
//  HBProtocolWrapper.m
//  DelegateWrapper
//
//  Created by Frederic on 2017/6/13.
//  Copyright © 2017年 honeyeeb. All rights reserved.
//

#import "HBProtocolWrapper.h"
#import "HBDemoProtocol.h"

@interface HBProtocolWrapper()

@property (nonatomic, strong, readwrite) dispatch_queue_t accessQueue;

@property (atomic, assign, readwrite) HBDemoProtocolAvalibale delegateAvalible;

@end

@implementation HBProtocolWrapper

@synthesize delegate = _delegate;
@synthesize dispatchQueue = _dispatchQueue;
@synthesize operationQueue = _operationQueue;
#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (!self) return self;
    
    _accessQueue = dispatch_queue_create("com.honeyeeb.delegatewrapper.queue", DISPATCH_QUEUE_CONCURRENT);
    _dispatchQueue = dispatch_get_main_queue();
    
    return self;
}

#pragma mark - Accessors

- (void)setDelegate:(id<HBDemoProtocol>)delegate {
    dispatch_barrier_async(self.accessQueue, ^{
        _delegate = delegate;
        
        self.delegateAvalible = (HBDemoProtocolAvalibale){
            .sayHello = [delegate respondsToSelector:@selector(sayHello)],
            .sayBye = [delegate respondsToSelector:@selector(sayBye)],
            
        };
    });
}

- (id<HBDemoProtocol> _Nullable)delegate {
    __block id<HBDemoProtocol> delegate = nil;
    dispatch_sync(self.accessQueue, ^{
        delegate = _delegate;
    });
    return delegate;
}

- (void)setDispatchQueue:(dispatch_queue_t _Nullable)queue {
    dispatch_barrier_async(self.accessQueue, ^{
        _dispatchQueue = queue ?: dispatch_get_main_queue();
        _operationQueue = nil;
    });
}

- (dispatch_queue_t _Nullable)dispatchQueue {
    __block dispatch_queue_t queue = nil;
    dispatch_sync(self.accessQueue, ^{
        queue = _dispatchQueue;
    });
    return queue;
}

- (void)setOperationQueue:(NSOperationQueue *_Nullable)queue {
    dispatch_barrier_async(self.accessQueue, ^{
        _dispatchQueue = queue ? nil : dispatch_get_main_queue();
        _operationQueue = queue;
    });
}

- (NSOperationQueue *_Nullable)operationQueue {
    __block NSOperationQueue *queue = nil;
    dispatch_sync(self.accessQueue, ^{
        queue = _operationQueue;
    });
    return queue;
}

#pragma mark - Perform

- (void)performDelegateBlock:(HBDemoProtocolBlock)block {
    __block __strong id<HBDemoProtocol> delegate = nil;
    __block HBDemoProtocolAvalibale availableMethods = {};
    dispatch_sync(self.accessQueue, ^{
        delegate = _delegate; // Not `OK` to go through `self`, since queue sync.
        availableMethods = self.delegateAvalible; // `OK` to call through `self`, since no queue sync.
    });
    [self performDelegateQueueBlock:^{
        block(delegate, availableMethods);
    }];
}

- (void)performDelegateQueueBlock:(dispatch_block_t)block {
    dispatch_queue_t dispatchQueue = self.dispatchQueue;
    if (dispatchQueue) {
        dispatch_async(dispatchQueue, block);
    } else {
        [self.operationQueue addOperationWithBlock:block];
    }
}

@end
