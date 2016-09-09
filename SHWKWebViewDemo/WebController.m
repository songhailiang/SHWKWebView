//
//  WebController.m
//  SHWKWebViewDemo
//
//  Created by 宋海梁 on 16/9/8.
//  Copyright © 2016年 宋海梁. All rights reserved.
//

#import "WebController.h"

@implementation WebController

- (void)viewDidLoad {

    [super viewDidLoad];
    
//    [self.webView loadRequestWithRelativeUrl:@"wap/money/list"];
    
    [self.webView loadLocalHTMLWithFileName:@"main"];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"调用JS" style:UIBarButtonItemStylePlain target:self action:@selector(callJS:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - WebView

- (void)callJS:(id)sender {

    [self.webView callJS:[NSString stringWithFormat:@"callJs('我是Objective-C')"] handler:^(NSString *response) {
        NSLog(@"JS返回结果：%@",response);
    }];
}

- (void)sh_webView:(SHWKWebView *)webView didReceiveScriptMessage:(SHScriptMessage *)message {

    if ([message.method isEqualToString:@"hello"]) {
        
        if (message.callback.length) {
            [self.webView callJS:[NSString stringWithFormat:@"%@('hello-JS')",message.callback] handler:^(id  _Nullable response) {
                NSLog(@"调用callback结果：%@",response);
            }];
        }
    }
    else {
        [super sh_webView:webView didReceiveScriptMessage:message];
    }
}

@end
