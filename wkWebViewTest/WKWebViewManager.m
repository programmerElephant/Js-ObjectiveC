//
//  WKWebViewManager.m
//  wkWebViewTest
//
//  Created by ProgrammerChan on 2018/9/27.
//  Copyright © 2018 chaman. All rights reserved.
//

#import "WKWebViewManager.h"


@interface WKWebViewManager()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong) NSArray *scriptArray;

@end

@implementation WKWebViewManager


#pragma mark ====== init


- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark ====== private/publick method

- (void)initWebViewWithJavaScriptHanderNames:(NSArray *)array andHtmlFileName:(NSString *)htmlName andJavaScriptArray:(NSArray *)scriptArray{
    
    self.scriptArray = scriptArray;
    
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    for (int i = 0; i < array.count; i ++) {
        [userContentController addScriptMessageHandler:self name:array[i]];
    }
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    _webView.UIDelegate = self;
    _webView.hidden = YES;
    _webView.navigationDelegate = self;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:htmlName ofType:@"html"];
    [_webView loadFileURL:[NSURL fileURLWithPath:filePath] allowingReadAccessToURL:[NSBundle mainBundle].resourceURL];
}


#pragma mark ====== delegate

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"error message:%@",error);
    [_webView reload];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"begin load html");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"finish load");
    
    for (int i = 0; i < self.scriptArray.count; i ++) {
        [webView evaluateJavaScript:self.scriptArray[i] completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            
            NSLog(@"received data:%@, and Error:%@",response,error);
            
            if (response || error) {
                if ([self.delegate respondsToSelector:@selector(receiveFunctionName:andValues:)]) {
                    [self.delegate receiveFunctionName:[response objectForKey:@"functionName"] andValues:[response objectForKey:@"value"]];
                }
            }
            
        }];
    }

}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"function name:%@",message.name);
    NSLog(@"values:%@",message.body);
    
    if ([self.delegate respondsToSelector:@selector(receiveFunctionName:andValues:)]) {
        [self.delegate receiveFunctionName:message.name andValues:message.body];
    }
}


#pragma mark ====== getter/setter

- (NSArray *)scriptArray{
    if (!_scriptArray) {
        _scriptArray = [NSArray array];
    }
    return _scriptArray;
}

@end
