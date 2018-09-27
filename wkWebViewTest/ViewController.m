//
//  ViewController.m
//  wkWebViewTest
//
//  Created by ProgrammerChan on 2018/9/27.
//  Copyright © 2018 chaman. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "WKWebViewManager.h"

@interface ViewController ()<WKManagerDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WKWebViewManager *manager = [[WKWebViewManager alloc] init];
    manager.delegate = self;
    [manager initWebViewWithJavaScriptHanderNames:@[@"backName"] andHtmlFileName:@"walletHtml" andJavaScriptArray:@[@"backName()",@"backNameMore('moreValue')"]];
}

#pragma mark ====== delegate

- (void)receiveFunctionName:(NSString *)name andValues:(NSString *)value{
    NSLog(@"name:%@,value:%@",name,value);
}

@end
