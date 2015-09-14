//
//  PostDetail.h
//  EosChina
//
//  Created by Ethan Guo on 15/9/14.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "prefix_define.h"
#import "PostDetailMsg.h"
#import "XMLParser.h"

@interface PostDetail : UIViewController <NSURLConnectionDataDelegate>

@property (strong,nonatomic) UIWebView *webView;
@property (copy,nonatomic) NSString *ids;
@property int newsCategory;
@property (nonatomic, strong) NSMutableData *post_data;

@end
