//
//  CommentsDetail.m
//  EosChina
//
//  Created by Ethan Guo on 15/9/13.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import "CommentsDetail.h"
#import "prefix_define.h"

@interface CommentsDetail ()

@end

@implementation CommentsDetail

@synthesize pageIndex;
@synthesize newsCategory;
@synthesize ids;
@synthesize isLoadOver;
@synthesize commentData;
@synthesize commentArray;
@synthesize parentID;
@synthesize commentTableView;

- (void)loadView {
    [super loadView];
    
    isLoadOver = NO;
    
    self.commentTableView.dataSource = self;
    self.commentTableView.delegate   = self;
    
    commentArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    if([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //self.commentTableView.frame = CGRectMake(0,50,self.view.frame.size.width,self.view.frame.size.height-50);
    //self.commentTableView.contentInset = UIEdgeInsetsMake(65, 0, 50, 0);
    
    /*
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
     */
    //NSLog(@"tableview frame: %@", NSStringFromCGRect([self.commentTableView frame]));
    //NSLog(@"view frame: %@", NSStringFromCGRect([self.view frame]));
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[commentTableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self loadContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"numberOfRowsInSection : %d", [commentArray count]);
    return [commentArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentMsgDetails *msg  = [commentArray objectAtIndex:[indexPath row]];
    return msg.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *tag = @"cell";
    CommentCells *cell = [tableView dequeueReusableCellWithIdentifier:tag];
    
    if(cell ==nil)
    {
        cell = [[CommentCells alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tag];
    }
    
    CommentMsgDetails *msg = [commentArray objectAtIndex:[indexPath row]];
    [cell setContent:msg];
    
    return cell;

}

- (void) loadContent {
    if (!isLoadOver) {
        int count = (int)[commentArray count]/20;
        pageIndex = count;
        
        NSString *str = nil;
        NSLog(@"#### newsCategory: %d",newsCategory);
        
        if(newsCategory ==5)
        {
            str = [NSString stringWithFormat:@"%@?id=%d&pageIndex=%d&pageSize=%d", api_blogcomment_list, self.parentID, pageIndex, 20];
        }
        else{
            str = [NSString stringWithFormat:@"%@catalog=%d&id=%@&pageIndex=%d&pageSize=%d",comments_detail,self.newsCategory,ids,count,20];
        }
        
        NSLog(@"%@", str);
        
        NSURL *url = [NSURL URLWithString:str];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        if (conn) {
            commentData = [NSMutableData new];
        }
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [commentData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"%@",[error localizedDescription]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSLog(@"请求完成");
    NSString *msg;
    msg = [[NSString alloc] initWithData:commentData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",msg);
    
    NSMutableArray *array = [XMLParser commentsDetailParser:msg];
    [commentArray addObjectsFromArray:array];
    //NSLog(@"array count : %d", [commentArray count]);
    [commentTableView reloadData];
}


@end
