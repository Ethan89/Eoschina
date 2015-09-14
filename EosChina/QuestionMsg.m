//
//  QuestionMsg.m
//  EosChina
//
//  Created by Ethan Guo on 15/9/13.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import "QuestionMsg.h"

@implementation QuestionMsg

@synthesize ids;
@synthesize portrait;
@synthesize author;
@synthesize authorid ;
@synthesize title;
@synthesize answerCount ;
@synthesize viewCount ;
@synthesize pubDate ;
@synthesize name ;

- (id) initWithContent:(NSString *)andIds andPortrait:(NSString *)nPortrait andAuthor:(NSString *)nAuthor andAuthorid:(NSString *)nAuthorid andTitle:(NSString *)nTitle andAnswerCount:(NSString *)nAnswerCount andViewCount:(NSString *)nViewCount andPubDate:(NSString *)nPubDate andName:(NSString *)nName
{
    QuestionMsg *msg = [[QuestionMsg alloc] init];
    
    msg.ids = andIds;
    msg.portrait = nPortrait;
    msg.author = nAuthor;
    msg.authorid = nAuthorid;
    msg.title = nTitle;
    msg.answerCount = nAnswerCount;
    msg.viewCount=nViewCount;
    msg.pubDate = nPubDate;
    msg.name = nName;
    
    return msg;
}

@end
