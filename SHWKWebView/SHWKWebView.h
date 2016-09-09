//
//  SHWKWebView.h
//  50+sh
//
//  Created by 宋海梁 on 15/12/14.
//  Copyright © 2015年 jicaas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@class SHWKWebView;
@class SHScriptMessage;

@protocol SHWKWebViewMessageHandleDelegate <NSObject>

@optional
- (void)sh_webView:(nonnull SHWKWebView *)webView didReceiveScriptMessage:(nonnull SHScriptMessage *)message;

@end

@interface SHWKWebView : WKWebView<WKScriptMessageHandler,SHWKWebViewMessageHandleDelegate>

//webview加载的url地址
@property (nullable, nonatomic, copy) NSString *webViewRequestUrl;
//webview加载的参数
@property (nullable, nonatomic, copy) NSDictionary *webViewRequestParams;

@property (nullable, nonatomic, weak) id<SHWKWebViewMessageHandleDelegate> sh_messageHandlerDelegate;

#pragma mark - Load Url

- (void)loadRequestWithRelativeUrl:(nonnull NSString *)relativeUrl;

- (void)loadRequestWithRelativeUrl:(nonnull NSString *)relativeUrl params:(nullable NSDictionary *)params;

/**
 *  加载本地HTML页面
 *
 *  @param htmlName html页面文件名称
 *  @param params   参数
 */
- (void)loadLocalHTMLWithFileName:(nonnull NSString *)htmlName params:(nullable NSDictionary *)params;

#pragma mark - View Method

/**
 *  重新加载webview
 */
- (void)reloadWebView;

#pragma mark - JS Method Invoke

/**
 *  调用JS方法（无返回值）
 *
 *  @param jsMethod JS方法名称
 */
- (void)callJS:(nonnull NSString *)jsMethod;

/**
 *  调用JS方法（可处理返回值）
 *
 *  @param jsMethod JS方法名称
 *  @param handler  回调block
 */
- (void)callJS:(nonnull NSString *)jsMethod handler:(nullable void(^)(__nullable id response))handler;

@end