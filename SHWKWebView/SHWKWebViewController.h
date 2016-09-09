//
//  SHWKWebViewController.h
//  50+sh
//
//  Created by 宋海梁 on 15/12/21.
//  Copyright © 2015年 jicaas. All rights reserved.
//

#import "SHWKWebView.h"
#import "SHScriptMessage.h"

@interface SHWKWebViewController : UIViewController<WKUIDelegate, WKNavigationDelegate,SHWKWebViewMessageHandleDelegate>

@property (nonatomic, strong) SHWKWebView *webView;

@property (nonatomic, copy) NSString *url;

/**
 *  加载时是否显示HUD提示层(默认YES)
 */
@property (nonatomic, assign) BOOL showHudWhenLoading;

/**
 *  是否显示加载进度 (默认YES)
 */
@property (nonatomic, assign) BOOL shouldShowProgress;

/**
 *  是否使用WebPage的title作为导航栏title（默认YES）
 */
@property (nonatomic, assign) BOOL isUseWebPageTitle;

/**
 *  是否支持滚动（默认YES）
 */
@property (nonatomic, assign) BOOL scrollEnabled;

@end
