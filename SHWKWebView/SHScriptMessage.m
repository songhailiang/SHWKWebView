//
//  SHScriptMessage.m
//  50+sh
//
//  Created by 宋海梁 on 15/12/14.
//  Copyright © 2015年 jicaas. All rights reserved.
//

#import "SHScriptMessage.h"

@implementation SHScriptMessage

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@:{method:%@,params:%@,callback:%@}>", NSStringFromClass([self class]),self.method, self.params, self.callback];
}

@end
