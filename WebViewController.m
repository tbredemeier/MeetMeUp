//
//  WebViewController.m
//  MeetMeUp
//
//  Created by tbredemeier on 5/27/14.
//  Copyright (c) 2014 Mobile Makers Academy. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *hostWebView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.hostWebView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.spinner stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.title = @"Failed to Load ;)";
    alert.message = error.localizedDescription;
    [alert addButtonWithTitle:@"Sucks to be you"];
    alert.delegate = self;
    [alert show];
    [self.spinner stopAnimating];
}



@end
