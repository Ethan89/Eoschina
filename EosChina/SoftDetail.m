//
//  SoftDetail.m
//  EosChina
//
//  Created by Ethan Guo on 15/9/13.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import "SoftDetail.h"

@interface SoftDetail ()

@end

@implementation SoftDetail

@synthesize webView;
@synthesize softwareName;
@synthesize soft_data;

- (void)loadView
{
    [super loadView];
    
    CGRect rect = self.view.bounds;
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width , rect.size.height)];
    
    
    [self.view addSubview:webView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *str = [NSString stringWithFormat:@"%@?ident=%@",api_software,softwareName];
    NSLog(@"%@",str);
    
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (conn) {
        soft_data = [NSMutableData new];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [soft_data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"%@", [error localizedDescription]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSLog(@"请求完成");
    NSString *msg;
    msg = [[NSString alloc] initWithData:soft_data encoding:NSUTF8StringEncoding];
    //NSLog(@"%@", msg);
    
    TBXML* xml = [[TBXML alloc] initWithXMLString:msg error:nil];
    TBXMLElement* root = xml.rootXMLElement;
    TBXMLElement* soft = [TBXML childElementNamed:@"software" parentElement:root];
    if (soft == nil) {
        return;
    }
    TBXMLElement* _id = [TBXML childElementNamed:@"id" parentElement:soft];
    TBXMLElement* title = [TBXML childElementNamed:@"title" parentElement:soft];
    if (!title) {
        return ;
    }
    TBXMLElement* extensionTitle = [TBXML childElementNamed:@"extensionTitle" parentElement:soft];
    TBXMLElement* license = [TBXML childElementNamed:@"license" parentElement:soft];
    TBXMLElement* body = [TBXML childElementNamed:@"body" parentElement:soft];
    
    TBXMLElement* homePage = [TBXML childElementNamed:@"homepage" parentElement:soft];
    TBXMLElement* document = [TBXML childElementNamed:@"document" parentElement:soft];
    TBXMLElement* download = [TBXML childElementNamed:@"download" parentElement:soft];
    
    TBXMLElement* logo = [TBXML childElementNamed:@"logo" parentElement:soft];
    TBXMLElement* language = [TBXML childElementNamed:@"language" parentElement:soft];
    TBXMLElement* os = [TBXML childElementNamed:@"os" parentElement:soft];
    TBXMLElement* recordTime = [TBXML childElementNamed:@"recordtime" parentElement:soft];
    TBXMLElement* fav = [TBXML childElementNamed:@"favorite" parentElement:soft];
    TBXMLElement* tweetCount = [TBXML childElementNamed:@"tweetCount" parentElement:soft];
    
    NSString *str_title = [NSString stringWithFormat:@"%@ %@", [TBXML textForElement:extensionTitle],[TBXML textForElement:title]];
    
    NSString *tail = [NSString stringWithFormat:@"<div>授权协议: %@</div><div>开发语言: %@</div><div>操作系统: %@</div><div>收录时间: %@</div>",
                      [TBXML textForElement:license],[TBXML textForElement:language],[TBXML textForElement:os],[TBXML textForElement:recordTime]];
    
    tail = [NSString stringWithFormat:@"<div><table><tr><td style='font-weight:bold'>授权协议:&nbsp;</td><td>%@</td></tr><tr><td style='font-weight:bold'>开发语言:</td><td>%@</td></tr><tr><td style='font-weight:bold'>操作系统:</td><td>%@</td></tr><tr><td style='font-weight:bold'>收录时间:</td><td>%@</td></tr></table></div>",[TBXML textForElement:license],[TBXML textForElement:language],[TBXML textForElement:os],[TBXML textForElement:recordTime]];
    
    NSString *html = [NSString stringWithFormat:@"<body style='background-color:#EBEBF3'>%@<div id='oschina_title'><img src='%@' width='34' height='34'/>%@</div><hr/><div id='oschina_body'>%@</div><div>%@</div>%@%@</body>",HTML_Style,[TBXML textForElement:logo],str_title,[TBXML textForElement:body],tail, [self getButtonString:[TBXML textForElement:homePage] andDocument:[TBXML textForElement:document] andDownload:[TBXML textForElement:download]],HTML_Bottom];
    
    [self.webView loadHTMLString:html baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSString *)getButtonString:(NSString *)homePage andDocument:(NSString *)document andDownload:(NSString *)download
{
    NSString *strHomePage = @"";
    NSString *strDocument = @"";
    NSString *strDownload = @"";
    if ([homePage isEqualToString:@""] == NO) {
        strHomePage = [NSString stringWithFormat:@"<a href=%@><input type='button' value='软件首页' style='font-size:14px;'/></a>", homePage];
    }
    if ([document isEqualToString:@""] == NO) {
        strDocument = [NSString stringWithFormat:@"<a href=%@><input type='button' value='软件文档' style='font-size:14px;'/></a>", document];
    }
    if ([download isEqualToString:@""] == NO) {
        strDownload = [NSString stringWithFormat:@"<a href=%@><input type='button' value='软件下载' style='font-size:14px;'/></a>", download];
    }
    return [NSString stringWithFormat:@"<p>%@&nbsp;&nbsp;%@&nbsp;&nbsp;%@</p>", strHomePage, strDocument, strDownload];
}


@end
