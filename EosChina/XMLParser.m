//
//  XMLParser.m
//  EosChina
//
//  Created by Ethan Guo on 15/9/12.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import "XMLParser.h"
#import "MsgDetail.h"

@implementation XMLParser

+ (NSMutableArray *)newsParser:(NSString *)response {
    NSLog(@"开始解析news xml");
    
    NSMutableArray *newsArray = [[NSMutableArray alloc] initWithCapacity:10];
    
    TBXML *tbxml = [TBXML newTBXMLWithXMLString:response error:nil];
    
    if (tbxml != nil) {
        TBXMLElement *root = tbxml.rootXMLElement;
        
        if (root != nil) {
            TBXMLElement *childElement = [TBXML childElementNamed:@"newslist" parentElement:root];
            
            if (childElement != nil) {
                
                TBXMLElement *test = [TBXML childElementNamed:@"news" parentElement:childElement];
                
                while (test != nil) {
                    
                    TBXMLElement *idElement = [TBXML childElementNamed:@"id" parentElement:test];
                    NSString *ids = [TBXML textForElement:idElement];
                    
                    TBXMLElement *contentElement = [TBXML childElementNamed:@"title" parentElement:test];
                    NSString *content = [TBXML textForElement:contentElement];
                    
                    TBXMLElement *authorElement = [TBXML childElementNamed:@"author" parentElement:test];
                    NSString *author = [TBXML textForElement:authorElement];
                    
                    TBXMLElement *dateElement = [TBXML childElementNamed:@"pubDate" parentElement:test];
                    NSString *date = [TBXML textForElement:dateElement];
                    
                    TBXMLElement *newType = [TBXML childElementNamed:@"newstype" parentElement:test];
                    
                    TBXMLElement *type = [TBXML childElementNamed:@"type" parentElement:newType];
                    
                    TBXMLElement *attachment = [TBXML childElementNamed:@"attachment" parentElement:newType];
                    
                    MsgDetail *news = [[MsgDetail alloc] initWithContent:content author:author ids:ids date:date];
                    news.newType = [[TBXML textForElement:type] intValue];
                    if (attachment != nil) {
                        news.attachMent = [TBXML textForElement:attachment];
                    }
                    
                    [newsArray addObject:news];
                    
                    test = [TBXML nextSiblingNamed:@"news" searchFromElement:test];
                }
            }
        }
    }
    
    
    NSLog(@"解析完成");
    return newsArray;
}

+ (SingleNews *) singleNewParser:(NSString *)response
{
    SingleNews *singleNews ;
    
    NSMutableArray *relativeArray = [[NSMutableArray alloc] init];
    
    
    TBXML *tbxml = [TBXML newTBXMLWithXMLString:response error:nil];
    
    if(tbxml!=nil)
    {
        TBXMLElement *root = tbxml.rootXMLElement;
        
        if(root!=nil)
        {
            TBXMLElement *news = [TBXML childElementNamed:@"news" parentElement:root];
            
            if(news!=nil)
            {
                
                TBXMLElement *_id = [TBXML childElementNamed:@"id" parentElement:news];
                TBXMLElement *_title = [TBXML childElementNamed:@"title" parentElement:news];
                TBXMLElement *_url = [TBXML childElementNamed:@"url" parentElement:news];
                TBXMLElement *_body = [TBXML childElementNamed:@"body" parentElement:news];
                TBXMLElement *_author = [TBXML childElementNamed:@"author"parentElement:news];
                TBXMLElement *_authorid = [TBXML childElementNamed:@"authorid"parentElement:news];
                TBXMLElement *_pubDate = [TBXML childElementNamed:@"pubDate" parentElement:news];
                
                TBXMLElement *_commentCount = [TBXML childElementNamed:@"commentCount" parentElement:news];
                
                TBXMLElement *_softwarelink = [TBXML childElementNamed:@"softwarelink" parentElement:news];
                TBXMLElement *_softwarename = [TBXML childElementNamed:@"softwarename" parentElement:news];
                TBXMLElement *_fav = [TBXML childElementNamed:@"favorite" parentElement:news];
                
                TBXMLElement *_relativies = [TBXML childElementNamed:@"relativies" parentElement:news];
                
                if(_relativies!=nil)
                {
                    TBXMLElement *relativieChild = [TBXML childElementNamed:@"relative" parentElement:_relativies];
                    
                    while (relativieChild) {
                        
                        TBXMLElement *_rtitle = [TBXML childElementNamed:@"rtitle"parentElement:relativieChild];
                        
                        TBXMLElement *_rurl = [TBXML childElementNamed:@"rurl" parentElement:relativieChild];
                        
                        RelativeNews *relativeNews = [[RelativeNews alloc] initWithContent:[TBXML textForElement:_rtitle] andUrl:[TBXML textForElement:_rurl]];
                        
                        [relativeArray addObject:relativeNews];
                        
                        relativieChild = [TBXML nextSiblingNamed:@"relative" searchFromElement:relativieChild];
                        
                    }
                }
                
                
                singleNews = [[SingleNews alloc] initWithContent:[[TBXML textForElement:_id] intValue] andtitle:[TBXML textForElement:_title] andurl:[TBXML textForElement:_url] andbody:[TBXML textForElement:_body] andauthor:[TBXML textForElement:_author] andauthorid:[[TBXML textForElement:_authorid] intValue] andpubDate:[TBXML textForElement:_pubDate] andcommentCount:[[TBXML textForElement:_commentCount] intValue] andfavorite:[[TBXML textForElement:_fav] intValue] ==1 ];
                
                singleNews.softwarelink = [TBXML textForElement:_softwarelink];
                singleNews.softwarename = [TBXML textForElement:_softwarename];
                singleNews.relativies = relativeArray;
                
                
            }
            
        }
    }
    
    
    
    return singleNews;
    
}

+ (NSString *)generateRelativeNewsString:(NSArray *)array
{
    if (array == nil || [array count] == 0) {
        return @"";
    }
    NSString *middle = @"";
    for (RelativeNews *r in array) {
        middle = [NSString stringWithFormat:@"%@<a href=%@ style='text-decoration:none'>%@</a><p/>",middle, r.rurl, r.rtitle];
    }
    return [NSString stringWithFormat:@"<hr/>相关文章<div style='font-size:14px'><p/>%@</div>", middle];
}

@end
