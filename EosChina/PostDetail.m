//
//  PostDetail.m
//  EosChina
//
//  Created by Ethan Guo on 15/9/14.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import "PostDetail.h"

@interface PostDetail ()

@end

@implementation PostDetail

@synthesize webView;
@synthesize newsCategory;
@synthesize ids;
@synthesize post_data;


- (void)loadView {
    [super loadView];
    
    CGRect rect = self.view.bounds;
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width , rect.size.height)];
    
    [self.view addSubview:webView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSString *str ;
    
    str = [NSString stringWithFormat:@"http://www.oschina.net/action/api/post_detail?id=%@",ids];
    
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (conn) {
        post_data = [NSMutableData new];
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [post_data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"%@", [error localizedDescription]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSLog(@"请求完成");
    NSString *str;
    str = [[NSString alloc] initWithData:post_data encoding:NSUTF8StringEncoding];
    
    PostDetailMsg *msg = [XMLParser postNewParser:str];
    
    NSString *author_str = [NSString stringWithFormat:@"<a href='http://my.oschina.net/u/%@'>%@</a> 发布于 %@",msg.authorid, msg.author, msg.pubDate];
    
    NSString *result ;
    
    if (msg.tagArray == nil || msg.tagArray.count == 0) {
        result = @"";
    }
    else
    {
        result = @"";
        for (NSString *t in msg.tagArray) {
            result = [NSString stringWithFormat:@"%@<a style='background-color: #BBD6F3;border-bottom: 1px solid #3E6D8E;border-right: 1px solid #7F9FB6;color: #284A7B;font-size: 12pt;-webkit-text-size-adjust: none;line-height: 2.4;margin: 2px 2px 2px 0;padding: 2px 4px;text-decoration: none;white-space: nowrap;' href='http://www.oschina.net/question/tag/%@' >&nbsp;%@&nbsp;</a>&nbsp;&nbsp;",result,t,t];
        }
    }
    
    
    NSString *html = [NSString stringWithFormat:@"<body style='background-color:#EBEBF3;'>%@<div id='oschina_title'>%@</div><div id='oschina_outline'>%@</div><hr/><div id='oschina_body'>%@</div>%@%@</body>",HTML_Style, msg.title,author_str,msg.body,result,HTML_Bottom];
    
    [self.webView loadHTMLString:html baseURL:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
