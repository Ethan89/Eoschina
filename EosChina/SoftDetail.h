//
//  SoftDetail.h
//  EosChina
//
//  Created by Ethan Guo on 15/9/13.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "prefix_define.h"
#import "TBXML.h"

@interface SoftDetail : UIViewController<NSURLConnectionDataDelegate>

@property (strong,nonatomic) UIWebView *webView;

@property int ids;
@property int newsCategory;
@property (nonatomic, strong) NSString *softwareName;
@property (nonatomic, strong) NSMutableData *soft_data;


@end
