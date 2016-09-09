//
//  SHWKWebView.m
//  50+sh
//
//  Created by 宋海梁 on 15/12/14.
//  Copyright © 2015年 jicaas. All rights reserved.
//

#import "SHWKWebView.h"
#import "SHScriptMessage.h"

//这里可以统一设置WebView的访问域名，方便切换
#ifdef DEBUG
#   define BASE_URL_API    @"http://****/"   //测试环境
#else
#   define BASE_URL_API    @"http://****/"   //正式环境
#endif

@interface SHWKWebView () {
    
    NSString *_identityId;
}

@property (nonatomic, strong) NSURL *baseUrl;

@end

@implementation SHWKWebView

- (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration {
    self = [super initWithFrame:frame configuration:configuration];
    if (self) {
        
        if (configuration) {
            [configuration.userContentController addScriptMessageHandler:self name:@"webViewApp"];
        }
        
        //这句是关闭系统自带的侧滑后退（历史浏览记录）
//        self.allowsBackForwardNavigationGestures = YES;
        self.baseUrl = [NSURL URLWithString:BASE_URL_API];
    }
    
    return self;
}

#pragma mark - Load Url

- (void)loadRequestWithRelativeUrl:(NSString *)relativeUrl; {
    
    [self loadRequestWithRelativeUrl:relativeUrl params:nil];
}

- (void)loadRequestWithRelativeUrl:(NSString *)relativeUrl params:(NSDictionary *)params {
    
    if (!_identityId) {
        _identityId = [NSString stringWithFormat:@"%@",@(arc4random())];
    }
    
    NSURL *url = [self generateURL:relativeUrl params:params isShare:NO];
    
    [self loadRequest:[NSURLRequest requestWithURL:url]];
}

/**
 *  加载本地HTML页面
 *
 *  @param htmlName html页面文件名称
 *  @param params   参数
 */
- (void)loadLocalHTMLWithFileName:(nonnull NSString *)htmlName params:(nullable NSDictionary *)params {

    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:htmlName
                                                          ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    
    [self loadHTMLString:htmlCont baseURL:baseURL];
}

- (NSURL *)generateURL:(NSString*)baseURL params:(NSDictionary*)params isShare:(BOOL)isShare {
    
    self.webViewRequestUrl = baseURL;
    self.webViewRequestParams = params;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSMutableArray* pairs = [NSMutableArray array];
    
    for (NSString* key in param.keyEnumerator) {
        NSString *value = [NSString stringWithFormat:@"%@",[param objectForKey:key]];

        NSString* escaped_value = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                              (__bridge CFStringRef)value,
                                                                              NULL,
                                                                              (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                              kCFStringEncodingUTF8);
        
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
    }
    
    NSString *query = [pairs componentsJoinedByString:@"&"];
    baseURL = [baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString* url = @"";
    if ([baseURL containsString:@"?"]) {
        url = [NSString stringWithFormat:@"%@&%@",baseURL, query];
    }
    else {
        url = [NSString stringWithFormat:@"%@?%@",baseURL, query];
    }
    //绝对地址
    if ([url.lowercaseString hasPrefix:@"http"]) {
        return [NSURL URLWithString:url];
    }
    else {
        return [NSURL URLWithString:url relativeToURL:self.baseUrl];
    }
}

/**
 *  重新加载webview
 */
- (void)reloadWebView {
    [self loadRequestWithRelativeUrl:self.webViewRequestUrl params:self.webViewRequestParams];
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSLog(@"message:%@",message.body);
    if ([message.body isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *body = (NSDictionary *)message.body;
        
        SHScriptMessage *msg = [SHScriptMessage new];
        [msg setValuesForKeysWithDictionary:body];
        
        if (self.sh_messageHandlerDelegate && [self.sh_messageHandlerDelegate respondsToSelector:@selector(sh_webView:didReceiveScriptMessage:)]) {
            [self.sh_messageHandlerDelegate sh_webView:self didReceiveScriptMessage:msg];
        }
    }
    
}

#pragma mark - JS

- (void)callJS:(NSString *)jsMethod {
    [self callJS:jsMethod handler:nil];
}

- (void)callJS:(NSString *)jsMethod handler:(void (^)(id _Nullable))handler {
    
    NSLog(@"call js:%@",jsMethod);
    [self evaluateJavaScript:jsMethod completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        if (handler) {
            handler(response);
        }
    }];
}

@end
