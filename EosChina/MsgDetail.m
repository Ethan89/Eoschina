//
//  MsgDetail.m
//  EosChina
//
//  Created by Ethan Guo on 15/9/12.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import "MsgDetail.h"

@implementation MsgDetail

@synthesize title;
@synthesize author;
@synthesize ids;
@synthesize date;
@synthesize url;
@synthesize favorite;
@synthesize newType;
@synthesize attachMent;

- (id)initWithContent:(NSString *)_title author:(NSString *)_author ids:(NSString *)_ids date:(NSString *)_date {
    
    MsgDetail *msg = [[MsgDetail alloc] init];
    
    msg.title  = _title;
    msg.author = _author;
    msg.ids    = _ids;
    msg.date   = _date;
    
    return msg;
}

@end
