
平时工作肯定会遇到`delegate`的使用，比较常用的`UITableViewDelegate`、`UITableViewDataSource`， 有关`delegate`的特点以及使用可以参考[苹果官方文档](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Delegation.html)。
 
## delegate & struct
 
最近在阅读[SRSocketRocket](https://github.com/facebook/SocketRocket)源代码时候发现了一个之前没接触过的方式，代码中为`protocol`包装了一层，使用`struct`构建一个对象来标识实现这个协议的对象都实现了哪些方法：
 
 ![delegateWrapper](delegate_wrapper_0.png)
 ![delegateWrapper](delegate_wrapper_1.png)

我为此写了一个[Demo](https://github.com/honeyeeb/delegateWrapper)，简单的介绍了这种新的方式。

## Demo

Demo比较简单，三个页面用来区分平时使用方法和这次新的使用方法。

首先定义了一个协议`HBDemoProtocol`，包含两个接口给要实现者去实现。

```objectivec
- (void)sayHello;
- (void)sayBye;
```

`ViewController`是APP启动看见的页面，
`一般实现`按钮将页面带入平时使用方式调用页面；
`包装实现`按钮将页面带入这次新方法调用页面。

### Origin

定义`HBOriginModel`对象用来调用`HBDemoProtocol`的实现。
`HBOriginViewController` VC是平时使用方式，实现`HBDemoProtocol`。主要代码:

```objectivec
- (IBAction)sayHelloAction:(id)sender {
    [self.originModel sayHelloAction];
}

- (IBAction)sayByeAction:(id)sender {
    [self. originModel sayByeAction];
}

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
```

点击`sayHello`、`sayBye`按钮弹出不同的文言。

### 新的思路

对协议`HBDemoProtocol`做一个封装对象`HBProtocolWrapper`，定义结构体标识协议对应的方法:

```objectivec
struct HBDemoProtocolAvalibale {
    BOOL sayHello   : 1;
    BOOL sayBye     : 1;
    
};
typedef struct HBDemoProtocolAvalibale HBDemoProtocolAvalibale;
typedef void(^HBDemoProtocolBlock)(id<HBDemoProtocol> delegate, HBDemoProtocolAvalibale delegateAvalible);

....

- (void)setDelegate:(id<HBDemoProtocol>)delegate {
    dispatch_barrier_async(self.accessQueue, ^{
        _delegate = delegate;
        
        self.delegateAvalible = (HBDemoProtocolAvalibale){
            .sayHello = [delegate respondsToSelector:@selector(sayHello)],
            .sayBye = [delegate respondsToSelector:@selector(sayBye)],
            
        };
    });
}
```

这样在调用协议实现时可以这样写:

```objectivec
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
```

`HBWrapperViewController` 页面与 `HBOriginViewController`实现上基本一致。
将对`delegate`操作的代码和附加功能(delegate操作的队列等)做拆分，这样拆分了代码，阅读以及测试起来更加方便。


这是一些阅读源代码的发现，如果你有其它意见或者见解欢迎留言(注意：留言系统是Disqus)或者发我邮箱：`honeyeeeb@gmail.com`。谢谢！


需要多读一读优秀源代码，O(∩_∩)O~~


