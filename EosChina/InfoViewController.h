//
//  InfoViewController.h
//  EosChina
//
//  Created by Ethan Guo on 15/9/11.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UITableViewController <NSURLConnectionDataDelegate>

@property int pageIndex;
@property (nonatomic, strong) NSMutableData *datas;
@property (nonatomic, strong) NSMutableArray *newsArray;

@property (weak, nonatomic) IBOutlet UITableView *infoTableView;

@property int newCategory;
@property int pageindex;
@end
