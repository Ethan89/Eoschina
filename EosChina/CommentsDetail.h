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
#import "CommentCells.h"
#import "CommentMsgDetails.h"

@interface CommentsDetail : UIViewController <UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>

@property (nonatomic,weak) MsgDetail *msgDetail;
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;

@property (nonatomic, strong) NSMutableData *commentData;
@property (nonatomic, strong) NSMutableArray *commentArray;

@property int pageIndex;
@property int newsCategory;
@property NSString *ids;
@property BOOL isLoadOver;
@property int parentID;

@end
