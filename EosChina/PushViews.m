//
//  PushViews.m
//  EosChina
//
//  Created by Ethan Guo on 15/9/13.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import "PushViews.h"

@implementation PushViews

+ (void)pushNewsDetailView:(UINavigationController *)navigationController andMsg:(MsgDetail *)msg andCategory:(int)category {
    
    switch (msg.newType) {
        case 0:
            NSLog(@"pushNews");
            [self pushNews:navigationController andIds:msg.ids andCategory:category];
            break;
            
        case 1:
            NSLog(@"pushSoft");
            [self pushSoft:navigationController andIds:msg.attachMent andCategory:0];
            break;
            
        case 2:
            NSLog(@"pushQuestion");
            break;
        
        case 3:
            NSLog(@"资讯");
            break;
            
        default:
            break;
    }
}

+ (void)pushNews:(UINavigationController *)navigationController andIds:(NSString *)ids andCategory:(int)category {
    
    MyUITabBarController *newsTab = [[MyUITabBarController alloc] init];
    newsTab.title = @"资讯详情";
    
    NewsDetail* newsDetail = [[NewsDetail alloc] init];
    newsDetail.view.backgroundColor = [UIColor whiteColor];
    newsDetail.title = @"资讯";
    newsDetail.ids = ids;
    newsDetail.newsCategory = category;
    
    newsTab.viewControllers = [NSArray arrayWithObjects:newsDetail, nil];
    [navigationController pushViewController:newsTab animated:YES];
}

+ (void)analysisDetail:(NSString *)url andNav:(UINavigationController *)navigationController
{
    NSLog(@"url = %@",url);
    
    NSString *search = @"oschina.net";
    
    NSRange rng = [url rangeOfString:search];
    if (rng.length <= 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        return;
    }
    else{
        NSString *tail = [url substringFromIndex:7];
        
        if([tail hasPrefix:@"www"])
        {
            NSArray *array = [tail componentsSeparatedByString:@"/"];
            
            if([[array objectAtIndex:1] isEqualToString:@"news"])
            {
                [self pushNews:navigationController andIds:[array objectAtIndex:2] andCategory:1];
                return;
            }
            /*
            else if([[array objectAtIndex:1] isEqualToString:@"p"])
            {
                [self pushSoft:navigationController andIds:[array objectAtIndex:2] andCategory:0];
                return;
            }
            else if([[array objectAtIndex:1] isEqualToString:@"question"])
            {
                //[self pushQuestion:navigationController andIds:[array objectAtIndex:2] andCategory:2];
                
                if([array count]==3)
                {
                    NSString *ids = [[[array objectAtIndex:2] componentsSeparatedByString:@"_"] objectAtIndex:1];
                    
                    [self pushQuestion:navigationController andIds:ids andCategory:2];
                    return;
                }
            }
            */
            
        }
        
    }
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    
}

+ (void)pushSoft:(UINavigationController *)navigationController andIds:(NSString *)ids andCategory:(int)category {
    
    MyUITabBarController *newTab = [[MyUITabBarController alloc] init];
    newTab.title = @"软件详情";
    
    [navigationController pushViewController:newTab animated:YES];
}

@end
