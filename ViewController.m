//
//  ViewController.m
//  JSSample
//
//  Created by 冯 鸿杰 on 14-3-18.
//  Copyright (c) 2014年 掌淘科技. All rights reserved.
//

#import "ViewController.h"
#import "ShareSDKJSBridge.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (retain) AVAudioPlayer *player;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    //清除UIWebView的缓存
    NSURLCache * cache = [NSURLCache sharedURLCache];
       [cache removeAllCachedResponses];
    [cache setMemoryCapacity:0];
    //[cache setDiskCapacity:0];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Sample" ofType:@"html"];
    NSURL *htmlURL = [NSURL fileURLWithPath:path];
    
   // htmlURL  = [NSURL URLWithString:@"http://192.168.123.1:8080/cf/index.html"];
    
    webView.delegate = self;
    [self.view addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:htmlURL]];
     [webView release];
    
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return ![[ShareSDKJSBridge sharedBridge] captureRequest:request webView:webView];
}

@end
