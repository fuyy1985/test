//
//  ForceUpdateViewController.m
//  smellycat
//
//  Created by LOUGUOPENG on 15-3-19.
//
//

#import "ForceUpdateViewController.h"

@interface ForceUpdateViewController ()<UIWebViewDelegate>

@end

@implementation ForceUpdateViewController
@synthesize webView = _webView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {

	}
	return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Custom initialization
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
        _webView.userInteractionEnabled = YES;
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
        NSURL *url = [NSURL URLWithString:@"http://m.zjwater.gov.cn/zjfxhd.aspx?sysType=6E32679EA81223DE"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
		[_webView release];
        self.navigationItem.title = @"软件更新";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma UIWebView Delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    NSURL *url = request.URL;
    if (UIWebViewNavigationTypeLinkClicked == navigationType)
    {
        [[UIApplication sharedApplication] openURL:url];
        NSLog(@"BA");
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView;
{
    NSLog(@"B");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    NSLog(@"C");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
{
    NSLog(@"D");
}

@end
