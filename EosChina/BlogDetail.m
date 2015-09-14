#import "BlogDetail.h"

@implementation BlogDetail

@synthesize webView;
@synthesize blog_data;

- (void)loadView
{
    [super loadView];
    
    CGRect rect = self.view.bounds;
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width , rect.size.height)];
    
    
    [self.view addSubview:webView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //    http://www.oschina.net/action/api/blog_detail?id=345392
    
    NSString *str = [NSString stringWithFormat:@"%@?id=%d",api_blog_detail,self.ids];
    
    NSLog(@"%@",str);
    
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (conn) {
        blog_data = [NSMutableData new];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [blog_data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error  {
    
    NSLog(@"%@", [error localizedDescription]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSLog(@"请求完成");
    NSString *msg;
    msg = [[NSString alloc] initWithData:blog_data encoding:NSUTF8StringEncoding];
    //NSLog(@"%@", msg);
    
    TBXML *tbxml = [TBXML newTBXMLWithXMLString:msg error:nil];
    
    
    TBXMLElement *_id = nil;
    TBXMLElement *_title = nil;
    TBXMLElement *_url =nil;
    TBXMLElement *_where = nil;
    TBXMLElement *_body = nil;
    TBXMLElement *_author = nil;
    TBXMLElement *_authorid = nil;
    TBXMLElement *_documentType = nil;
    TBXMLElement *_pubDate = nil;
    TBXMLElement *_fav = nil;
    TBXMLElement *_commentCount = nil;
    
    if(tbxml!=nil)
    {
        TBXMLElement *root = tbxml.rootXMLElement;
        if(root!=nil)
        {
            TBXMLElement *blog = [TBXML childElementNamed:@"blog" parentElement:root];
            
            _id = [TBXML childElementNamed:@"id" parentElement:blog];
            _title = [TBXML childElementNamed:@"title" parentElement:blog];
            _url = [TBXML childElementNamed:@"url" parentElement:blog];
            _where = [TBXML childElementNamed:@"where" parentElement:blog];
            _body = [TBXML childElementNamed:@"body" parentElement:blog];
            _author = [TBXML childElementNamed:@"author" parentElement:blog];
            _authorid = [TBXML childElementNamed:@"authorid" parentElement:blog];
            _documentType = [TBXML childElementNamed:@"documentType" parentElement:blog];
            _pubDate = [TBXML childElementNamed:@"pubDate" parentElement:blog];
            _fav = [TBXML childElementNamed:@"favorite" parentElement:blog];
            _commentCount = [TBXML childElementNamed:@"commentCount" parentElement:blog];
        }
    }
    
    
    NSString *author_str = [NSString stringWithFormat:@"<a href='http://my.oschina.net/u/%d'>%@</a>&nbsp;发表于&nbsp;%@",[TBXML textForElement:_authorid ], [TBXML textForElement:_author ],  [XMLParser intervalSinceNow:[TBXML textForElement:_pubDate]]];
    
    NSString *html = [NSString stringWithFormat:@"<body style='background-color:#EBEBF3'>%@<div id='oschina_title'>%@</div><div id='oschina_outline'>%@</div><hr/><div id='oschina_body'>%@</div>%@</body>",HTML_Style, [TBXML textForElement:_title],author_str,[TBXML textForElement:_body],HTML_Bottom];
    [self.webView loadHTMLString:html baseURL:nil];
}



@end
