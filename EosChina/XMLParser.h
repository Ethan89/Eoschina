//
//  XMLParser.h
//  EosChina
//
//  Created by Ethan Guo on 15/9/12.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import "TBXML.h"
#import "SingleNews.h"
#import "CommentMsgDetails.h"

@interface XMLParser : NSObject

+ (NSMutableArray *)newsParser:(NSString *) response;
+ (SingleNews *) singleNewParser:(NSString *)response;
+ (NSString *)generateRelativeNewsString:(NSArray *)array;
+ (NSString *)intervalSinceNow: (NSString *) theDate;
+ (NSMutableArray*) commentsDetailParser:(NSString *)response;

@end
