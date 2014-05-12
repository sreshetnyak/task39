//
//  TTWebController.m
//  UIWebViewContent
//
//  Created by Sergey Reshetnyak on 5/12/14.
//  Copyright (c) 2014 sergey. All rights reserved.
//

#import "TTWebController.h"

@interface TTWebController () <UIWebViewDelegate>

@property (weak,nonatomic) UIWebView *webView;
@property (weak,nonatomic) UIActivityIndicatorView *indicator;

@end

@implementation TTWebController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect rect = self.view.bounds;
    rect.origin = CGPointZero;
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:rect];
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [webView loadRequest:[NSURLRequest requestWithURL:self.dataURL]];
    
    webView.delegate = self;
    
    [self.view addSubview:webView];
    self.webView = webView;
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(387/2 - 44, 568/2 - 44, 44, 44);
    [indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [indicator setColor:[UIColor orangeColor]];
    [self.view addSubview:indicator];
    self.indicator = indicator;
    
    UIToolbar *bar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 524, 320, 44)];
    
    UIBarButtonItem *itemForward = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(forwardPage)];
    UIBarButtonItem *itemBack = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(backPage)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    bar.items = @[itemBack,itemForward,space];
    
    [self.view addSubview:bar];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.indicator stopAnimating];
}

- (void)forwardPage {
    
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
    
}

- (void)backPage {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
