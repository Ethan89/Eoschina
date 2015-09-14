//
//  QuestionViewController.h
//  EosChina
//
//  Created by Ethan Guo on 15/9/13.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "prefix_define.h"
#import "XMLParser.h"
#import "PushViews.h"

@interface QuestionViewController : UITableViewController <NSURLConnectionDataDelegate>

@property (strong, nonatomic) IBOutlet UITableView *questionTableView;

@property int newsCategory;
@property (nonatomic, strong) NSMutableData *datas;
@property (nonatomic, strong) NSMutableArray *newsArray;

@end
