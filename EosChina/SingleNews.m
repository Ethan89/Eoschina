//
//  SingleNews.m
//  EosChina
//
//  Created by Ethan Guo on 15/9/13.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import "SingleNews.h"

@implementation SingleNews

@synthesize _id;
@synthesize title;
@synthesize url;
@synthesize body;
@synthesize author;
@synthesize authorid;
@synthesize pubDate;
@synthesize commentCount;
@synthesize relativies;
@synthesize softwarelink;
@synthesize softwarename;
@synthesize favorite;

- (id) initWithContent:(int)nid andtitle:(NSString *)ntitle andurl:(NSString *)nurl andbody:(NSString *)nbody andauthor:(NSString *)nauthor andauthorid:(int)nauthorid andpubDate:(NSString *)npubDate andcommentCount:(int)ncommentCount andfavorite:(BOOL)nfavorite
{
    SingleNews *news = [[SingleNews alloc] init];
    
    news._id = nid;
    news.title = ntitle;
    news.url = nurl;
    news.body = nbody;
    news.author = nauthor;
    news.authorid = nauthorid;
    news.pubDate = npubDate;
    news.commentCount = ncommentCount;
    news.favorite = nfavorite;
    return news;
    
}

@end

@implementation RelativeNews

@synthesize rtitle;
@synthesize rurl;

- (id) initWithContent:(NSString *)ntitle andUrl:(NSString *)nurl
{
    RelativeNews *msg = [[RelativeNews alloc] init];
    
    msg.rtitle = ntitle;
    msg.rurl = nurl;
    
    return msg;
}

@end