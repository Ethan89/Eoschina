//
//  PushViews.h
//  EosChina
//
//  Created by Ethan Guo on 15/9/13.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MsgDetail.h"
#import "NewsDetail.h"
#import "SoftDetail.h"
#import "BlogDetail.h"
#import "CommentsDetail.h"
#import "MyUITabBarController.h"

@interface PushViews : NSObject

+ (void)pushNewsDetailView:(UINavigationController *)navigationController andMsg:(MsgDetail *)msg andCategory:(int)category;

+ (void)pushNews:(UINavigationController *)navigationController andIds:(NSString *)ids andCategory:(int)category;

+ (void)pushSoft:(UINavigationController *)navigationController andIds:(NSString*)ids andCategory:(int)category;

+ (void)analysisDetail:(NSString *)url andNav:(UINavigationController *)navigationController;

@end
