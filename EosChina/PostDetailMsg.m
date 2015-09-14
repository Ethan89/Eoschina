//
//  PostDetailMsg.m
//  EosChina
//
//  Created by Ethan Guo on 15/9/14.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import "PostDetailMsg.h"

@implementation PostDetailMsg

@synthesize ids;
@synthesize title;
@synthesize url;
@synthesize portrait;
@synthesize body;
@synthesize author;
@synthesize authorid;
@synthesize answerCount;
@synthesize viewCount;
@synthesize pubDate;
@synthesize favorite;
@synthesize tagArray;

-(id) initWithContent:(NSString *)newid andTitle:(NSString *)ntitle andUrl:(NSString *)nUrl andPortrait:(NSString *)nportrait andBody:(NSString *)nbody andAuthor:(NSString *)nauthor andAuthorID:(NSString *)nauthorid andAnswer:(NSString *)nanswerCount andView:(NSString *)nviewCount andPubDate:(NSString *)nPubDate andFavorite:(NSString *)nfavorite andTags:(NSMutableArray *)_tags
{
    PostDetailMsg *msg = [[PostDetailMsg alloc] init];
    msg.ids = newid;
    msg.title = ntitle;
    msg.url= nUrl;
    msg.portrait = nportrait;
    msg.body = nbody;
    msg.author =nauthor;
    msg.authorid = nauthorid;
    msg.answerCount = nanswerCount;
    msg.viewCount = nviewCount;
    msg.pubDate =nPubDate;
    msg.favorite = nfavorite;
    msg.tagArray = _tags;
    
    
    return msg;
}

@end
