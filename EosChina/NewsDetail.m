//
//  NewsDeail.m
//  EosChina
//
//  Created by Ethan Guo on 15/9/13.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import "NewsDetail.h"
#import "prefix_define.h"
#import "XMLParser.h"

@implementation NewsDetail
{
    id<TabBarProtocol> mydelegate;
}

@synthesize webView;
@synthesize ids;
@synthesize singleNewsData;
@synthesize singleNews;
@synthesize newsCategory;

- (void)loadView {
    
    [super loadView];
    
    CGRect rect = self.view.bounds;
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width , rect.size.height)];
    
    self.webView.delegate =self;
    
    [self.view addSubview:webView];
}

- (void)viewDidAppear:(BOOL)animated {

    NSString *str;
    
    if (newsCategory == 1) {
        str = [NSString stringWithFormat:@"%@id=%@",new_detail,ids];
        NSLog(@"**:%@", str);
    } else if (newsCategory == 2) {
        str = [NSString stringWithFormat:@"%@id=%@",blog_detail,ids];
        NSLog(@"**: %@", str);
    }
    
    NSURL *url = [NSURL URLWithString:str];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (connection) {
        singleNewsData = [NSMutableData new];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [singleNewsData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error  {
    
    NSLog(@"aaa*** %@",[error localizedDescription]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSLog(@"请求完成");
    NSString *msg;
    NSString *html;
    
    msg = [[NSString alloc] initWithData:singleNewsData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@", msg);
    
    if (newsCategory == 1) {
        singleNews = [XMLParser singleNewParser:msg];
        
        NSString *author_str = [NSString stringWithFormat:@"<a href='http://my.oschina.net/u/%d'>%@</a> 发布于 %@",singleNews.authorid,singleNews.author,singleNews.pubDate];
        
        
        NSString *software = @"";
        if ([singleNews.softwarename isEqualToString:@""] == NO) {
            software = [NSString stringWithFormat:@"<div id='oschina_software' style='margin-top:8px;color:#FF0000;font-size:14px;font-weight:bold'>更多关于:&nbsp;<a href='%@'>%@</a>&nbsp;的详细信息</div>",singleNews.softwarelink, singleNews.softwarename];
        }
        
        html = [NSString stringWithFormat:@"<body style='background-color:#EBEBF3'>%@<div id='oschina_title'>%@</div><div id='oschina_outline'>%@</div><hr/><div id='oschina_body'>%@</div>%@%@%@</body>",HTML_Style, singleNews.title,author_str, singleNews.body,software,[XMLParser generateRelativeNewsString:singleNews.relativies],HTML_Bottom];
    } else if (newsCategory == 2) {
        //NSLog(@"aaaaaaaa");
        BlogDetailMsg *blogDetails = [XMLParser blogDetailParser:msg];
        
        NSString *author_str = [NSString stringWithFormat:@"<a href='http://my.oschina.net/u/%d'>%@</a>&nbsp;发表于&nbsp;%@",blogDetails.authorid, blogDetails.author,  [XMLParser intervalSinceNow:blogDetails.pubDate]];
        html = [NSString stringWithFormat:@"<body style='background-color:#EBEBF3'>%@<div id='oschina_title'>%@</div><div id='oschina_outline'>%@</div><hr/><div id='oschina_body'>%@</div>%@</body>",HTML_Style, blogDetails.title,author_str,blogDetails.body,HTML_Bottom];
    }
    
    [self.webView loadHTMLString:html baseURL:nil];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    [PushViews analysisDetail:[request.URL absoluteString] andNav:self.parentViewController.navigationController];
    if ([request.URL.absoluteString isEqualToString:@"about:blank"]){
        return YES;
    } else {
        return NO;
    }
    
}

- (void)barButtonClick {
    NSLog(@"barButtonClick");
}

- (void)setMyDelegate:(id<TabBarProtocol>)delegate {
    mydelegate = delegate;
}

@end
