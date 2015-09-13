//
//  MsgDetail.h
//  EosChina
//
//  Created by Ethan Guo on 15/9/12.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MsgDetail : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *ids;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *url;
@property int newType;
@property (nonatomic,copy) NSString *attachMent;
@property BOOL favorite;

- (id) initWithContent:(NSString *)_title author:(NSString *)_author ids:(NSString *)_ids date:(NSString *)_date;

- (id) initwithBlog:(NSString *)_titile author:(NSString *)_author ids:(NSString *)_ids pullDate:(NSString *)_pullDate url:(NSString *)_url;

@end
