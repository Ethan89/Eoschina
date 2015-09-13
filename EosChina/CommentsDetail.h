//
//  CommentsDetail.h
//  EosChina
//
//  Created by Ethan Guo on 15/9/13.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgDetail.h"
#import "XMLParser.h"

@interface CommentsDetail : UITableViewController <UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>

@property (nonatomic,weak) MsgDetail *msgDetail;
@property (strong, nonatomic) IBOutlet UITableView *commentTableView;

@property (nonatomic, strong) NSMutableData *commentData;
@property (nonatomic, strong) NSMutableArray *commentArray;
@property int pageIndex;
@property int newsCategory;
@property NSString *ids;
@property BOOL isLoadOver;
@property int parentID;

@end
