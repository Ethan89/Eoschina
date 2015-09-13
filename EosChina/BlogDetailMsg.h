//
//  BlogDetailMsg.h
//  EosChina
//
//  Created by Ethan Guo on 15/9/13.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlogDetailMsg : NSObject

@property int _id;
@property (copy,nonatomic) NSString * title;
@property (copy,nonatomic) NSString * where;
@property (copy,nonatomic) NSString * body;
@property (copy,nonatomic) NSString * author;
@property int authorid;
@property int documentType;
@property (copy,nonatomic) NSString * pubDate;
@property BOOL favorite;
@property (copy,nonatomic) NSString * url;
@property int commentCount;

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
         andCommentCount:(int)ncommentCount;

@end
