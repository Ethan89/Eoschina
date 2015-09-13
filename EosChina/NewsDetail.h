//
//  NewsDeail.h
//  EosChina
//
//  Created by Ethan Guo on 15/9/13.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleNews.h"
#import "PushViews.h"

@interface NewsDetail : UIViewController <NSURLConnectionDataDelegate, UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (copy, nonatomic) NSString *ids;
@property (nonatomic, strong) NSMutableData *singleNewsData;
@property (strong,nonatomic) SingleNews *singleNews;
@property int newsCategory;

@end
