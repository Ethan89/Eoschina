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

+ (NSMutableArray *) blogParser:(NSString *)response
{
    
    NSMutableArray *newsArray = [[NSMutableArray alloc] initWithCapacity:10];
    
    TBXML *tbxml = [TBXML newTBXMLWithXMLString:response error:nil];
    
    if(tbxml!=nil)
    {
        TBXMLElement *root = tbxml.rootXMLElement;
        
        if(root!=nil)
        {
            TBXMLElement *childElement = [TBXML childElementNamed:@"blogs" parentElement:root];
            
            if(childElement!=nil)
            {
                
                TBXMLElement *test = [TBXML childElementNamed:@"blog" parentElement:childElement];
                
                
                while (test!=nil) {
                    
                    TBXMLElement *idElement = [TBXML childElementNamed:@"id" parentElement:test];
                    NSString *ids = [TBXML textForElement:idElement];
                    
                    TBXMLElement *contentEle = [TBXML childElementNamed:@"title" parentElement:test];
                    NSString *content = [TBXML textForElement:contentEle];
                    
                    TBXMLElement *authorEle = [TBXML childElementNamed:@"authorname" parentElement:test];
                    NSString *author = [TBXML textForElement:authorEle];
                    
                    
                    TBXMLElement *dateEle = [TBXML childElementNamed:@"pubDate" parentElement:test];
                    NSString *pullData = [XMLParser intervalSinceNow:[TBXML textForElement:dateEle]];
                    
                    
                    TBXMLElement *urlEle = [TBXML childElementNamed:@"url" parentElement:test];
                    NSString *url = [TBXML textForElement:urlEle];
                    
                    
                    MsgDetail *news = [[MsgDetail alloc] initwithBlog:content author:author ids:ids pullDate:pullData url:url];
                    
                    [newsArray addObject:news];
                    
                    test = [TBXML nextSiblingNamed:@"blog" searchFromElement:test];
                }
                
            }
            
        }
    }
    
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

+ (BlogDetailMsg*) blogDetailParser:(NSString *)response
{
    TBXML *xml = [[TBXML alloc] initWithXMLString:response error:nil];
    TBXMLElement *root = xml.rootXMLElement;
    TBXMLElement *blog = [TBXML childElementNamed:@"blog" parentElement:root];
    if (blog == nil) {
        return nil;
    }
    TBXMLElement *_id = [TBXML childElementNamed:@"id" parentElement:blog];
    TBXMLElement *title = [TBXML childElementNamed:@"title" parentElement:blog];
    TBXMLElement *url = [TBXML childElementNamed:@"url" parentElement:blog];
    TBXMLElement *where = [TBXML childElementNamed:@"where" parentElement:blog];
    TBXMLElement *body = [TBXML childElementNamed:@"body" parentElement:blog];
    TBXMLElement *author = [TBXML childElementNamed:@"author" parentElement:blog];
    TBXMLElement *authorid = [TBXML childElementNamed:@"authorid" parentElement:blog];
    TBXMLElement *documentType = [TBXML childElementNamed:@"documentType" parentElement:blog];
    TBXMLElement *pubDate = [TBXML childElementNamed:@"pubDate" parentElement:blog];
    TBXMLElement *fav = [TBXML childElementNamed:@"favorite" parentElement:blog];
    TBXMLElement *commentCount = [TBXML childElementNamed:@"commentCount" parentElement:blog];
    
    
    BlogDetailMsg *b = [[BlogDetailMsg alloc] initWithParameters:[[TBXML textForElement:_id] intValue] andTitle:[TBXML textForElement:title] andWhere:[TBXML textForElement:where] andBody:[TBXML textForElement:body] andAuthor:[TBXML textForElement:author] andAuthorid:[[TBXML textForElement:authorid] intValue] andDocumentType:[[TBXML textForElement:documentType] intValue] andPubDate:[TBXML textForElement:pubDate] andFavorite:[[TBXML textForElement:fav] intValue] == 1 andUrl:[TBXML textForElement:url] andCommentCount:[[TBXML textForElement:commentCount] intValue]];
    return b;
    
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

+ (NSString *)intervalSinceNow: (NSString *) theDate
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    NSTimeInterval cha=now-late;
    
    if (cha/3600<1) {
        if (cha/60<1) {
            timeString = @"1";
        }
        else
        {
            timeString = [NSString stringWithFormat:@"%f", cha/60];
            timeString = [timeString substringToIndex:timeString.length-7];
        }
        
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    else if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    else if (cha/86400>1&&cha/864000<1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    }
    else
    {
        NSArray *array = [theDate componentsSeparatedByString:@" "];
        
        timeString = [array objectAtIndex:0];
    }
    return timeString;
}

+ (NSMutableArray *) commentsDetailParser:(NSString *)response
{
    
    NSMutableArray *commentArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    TBXML *xml = [[TBXML alloc] initWithXMLString:response error:nil];
    TBXMLElement *root = xml.rootXMLElement;
    TBXMLElement *blog = [TBXML childElementNamed:@"comments" parentElement:root];
    if (blog == nil) {
        return nil;
    }
    
    TBXMLElement *first = [TBXML childElementNamed:@"comment" parentElement:blog];
    
    while (first!=nil) {
        
        TBXMLElement *_id = [TBXML childElementNamed:@"id" parentElement:first];
        TBXMLElement *_portrait = [TBXML childElementNamed:@"portrait" parentElement:first];
        TBXMLElement *_author = [TBXML childElementNamed:@"author" parentElement:first];
        TBXMLElement *_authorid = [TBXML childElementNamed:@"authorid" parentElement:first];
        TBXMLElement *_content = [TBXML childElementNamed:@"content" parentElement:first];
        TBXMLElement *_pubDate = [TBXML childElementNamed:@"pubDate" parentElement:first];
        TBXMLElement *_appclient = [TBXML childElementNamed:@"appclient" parentElement:first];
        TBXMLElement *_refers = [TBXML childElementNamed:@"refers" parentElement:first];
        
        NSMutableArray *referenceArray =  nil;
        
        
        if(_refers!=nil)
        {
            referenceArray = [[NSMutableArray alloc] initWithCapacity:2];
            
            TBXMLElement *_refersChild = [TBXML childElementNamed:@"refer" parentElement:_refers];
            
            while (_refersChild!=nil) {
                
                TBXMLElement *_refertitle = [TBXML childElementNamed:@"refertitle" parentElement:_refersChild];
                TBXMLElement *_referbody = [TBXML childElementNamed:@"referbody" parentElement:_refersChild];
                
                ReferenceMsg *msg = [[ReferenceMsg alloc] initWithContent:[TBXML textForElement:_referbody] andrefertitle:[TBXML textForElement:_refertitle]];
                
                [referenceArray addObject:msg];
                
                _refersChild = [TBXML nextSiblingNamed:@"refer" searchFromElement:_refersChild];
            }
        }
        
        NSString *_refersContent = nil;
        
        if(_refers!=nil)
        {
            _refersContent = [TBXML textForElement:_refers];
        }
        
        CommentMsgDetails *news = [[CommentMsgDetails alloc] initWithContent:[TBXML textForElement:_id] andPortrait:[TBXML textForElement:_portrait] andAuthor:[TBXML textForElement:_author] andAuthorid:[TBXML textForElement:_authorid] andContent:[TBXML textForElement:_content] andPubDate:[TBXML textForElement:_pubDate] andAppClent:[TBXML textForElement:_appclient] andRefers:_refersContent];
        
        news.refrenceArray = referenceArray;
        [news calculateHeight];
        
        
        
        [commentArray addObject:news];
        
        first = [TBXML nextSiblingNamed:@"comment" searchFromElement:first];
    }
    
    
    return commentArray;
}

@end
