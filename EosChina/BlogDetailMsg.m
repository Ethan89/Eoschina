//
//  BlogDetailMsg.m
//  EosChina
//
//  Created by Ethan Guo on 15/9/13.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import "BlogDetailMsg.h"

@implementation BlogDetailMsg

@synthesize _id;
@synthesize title;
@synthesize where;
@synthesize body;
@synthesize author;
@synthesize authorid;
@synthesize documentType;
@synthesize pubDate;
@synthesize favorite;
@synthesize url;
@synthesize commentCount;

- (id)initWithParameters:(int)nid
                andTitle:(NSString *)ntitle
                andWhere:(NSString *)nwhere
                 andBody:(NSString *)nbody
               andAuthor:(NSString *)nauthor
             andAuthorid:(int)nauthorid
         andDocumentType:(int)nDocumentType
              andPubDate:(NSString *)nPubDate
             andFavorite:(BOOL)nfavorite
                  andUrl:(NSString *)nurl
         andCommentCount:(int)ncommentCount
{
    BlogDetailMsg * b = [[BlogDetailMsg alloc] init];
    b._id = nid;
    b.title = ntitle;
    b.where = nwhere;
    b.body = nbody;
    b.author = nauthor;
    b.authorid = nauthorid;
    b.documentType = nDocumentType;
    b.pubDate = nPubDate;
    b.favorite = nfavorite;
    b.url = nurl;
    b.commentCount = ncommentCount;
    return b;
}

@end
