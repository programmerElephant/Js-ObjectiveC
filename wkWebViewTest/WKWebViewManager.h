//
//  WKWebViewManager.h
//  wkWebViewTest
//
//  Created by ProgrammerChan on 2018/9/27.
//  Copyright © 2018 chaman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WKManagerDelegate <NSObject>

@optional


/**
 代理方法,用户获取返回值信息

 @param name 方法名称
 @param value 值
 */
- (void)receiveFunctionName:(NSString *)name andValues:(NSString *)value;

@end

@interface WKWebViewManager : NSObject



/**
 创建一个wkwebview实例

 @param array 注册方法数组
 @param htmlName 加载的html文件名称
 @param scriptArray 需要执行的JavaScript代码
 */
- (void) initWebViewWithJavaScriptHanderNames:(NSArray *)array andHtmlFileName:(NSString *)htmlName andJavaScriptArray:(NSArray *)scriptArray;



/**
 遵循代理,用户获取返回值
 */
@property (nonatomic,assign) id <WKManagerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
