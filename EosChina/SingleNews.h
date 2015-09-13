//
//  SingleNews.h
//  EosChina
//
//  Created by Ethan Guo on 15/9/13.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleNews : NSObject

@property int _id;
@property (copy,nonatomic) NSString * title;
@property (copy,nonatomic) NSString * url;
@property (copy,nonatomic) NSString * body;
@property (copy,nonatomic) NSString * author;
@property int authorid;
@property (copy,nonatomic) NSString * pubDate;
@property int commentCount;
@property (retain,nonatomic) NSArray * relativies;
@property (copy,nonatomic) NSString * softwarelink;
@property (copy,nonatomic) NSString * softwarename;
@property BOOL favorite;

- (id) initWithContent:(int)nid andtitle:(NSString *)ntitle andurl:(NSString *)nurl andbody:(NSString *)nbody andauthor:(NSString *)nauthor andauthorid:(int) nauthorid  andpubDate:(NSString*)npubDate andcommentCount:(int) ncommentCount andfavorite:(BOOL) nfavorite;

@end

@interface RelativeNews : NSObject

@property (copy,nonatomic) NSString *rtitle;
@property (copy,nonatomic) NSString *rurl;

- (id) initWithContent:(NSString *)ntitle andUrl:(NSString *)nurl;

@end