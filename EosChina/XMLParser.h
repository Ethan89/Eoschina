//
//  XMLParser.h
//  EosChina
//
//  Created by Ethan Guo on 15/9/12.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import "TBXML.h"
#import "SingleNews.h"
#import "BlogDetailMsg.h"
#import "PostDetailMsg.h"
#import "CommentMsgDetails.h"
#import "QuestionMsg.h"

@interface XMLParser : NSObject

+ (NSMutableArray *)newsParser:(NSString *) response;

+ (NSMutableArray *)blogParser:(NSString *) response;

+ (SingleNews *) singleNewParser:(NSString *)response;

+ (BlogDetailMsg *) blogDetailParser:(NSString *)response;

+ (NSMutableArray*) questionNewParser:(NSString *)response;

+ (PostDetailMsg *) postNewParser:(NSString *)response;

+ (NSString *)generateRelativeNewsString:(NSArray *)array;

+ (NSString *)intervalSinceNow: (NSString *) theDate;

+ (NSMutableArray *) commentsDetailParser:(NSString *)response;

@end
