//
//  SHScriptMessage.h
//  50+sh
//
//  Created by 宋海梁 on 15/12/14.
//  Copyright © 2015年 jicaas. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  WKWebView与JS调用时参数规范实体
 */
@interface SHScriptMessage : NSObject

/**
 *  方法名
 *  用来确定Native App的执行逻辑
 */
@property (nonatomic, copy) NSString *method;

/**
 *  方法参数
 *  json字符串
 */
@property (nonatomic, copy) NSDictionary *params;

/**
 *  回调函数名
 *  Native App执行完后回调的JS方法名
 */
@property (nonatomic, copy) NSString *callback;

@end
