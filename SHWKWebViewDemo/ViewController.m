//
//  ViewController.m
//  SHWKWebViewDemo
//
//  Created by 宋海梁 on 16/9/8.
//  Copyright © 2016年 宋海梁. All rights reserved.
//

#import "ViewController.h"
#import "WebController.h"

@interface ViewController ()

- (IBAction)openWebViewTouched:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openWebViewTouched:(id)sender {
    
    WebController *webVc = [[WebController alloc] init];
    [self.navigationController pushViewController:webVc animated:YES];
}
@end
