//
//  InfoViewController.m
//  EosChina
//
//  Created by Ethan Guo on 15/9/11.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import "InfoViewController.h"
#import "prefix_define.h"
#import "XMLParser.h"
#import "MsgCell.h"
#import "MsgDetail.h"
#import "PushViews.h"

//@interface InfoViewController ()
@interface InfoViewController ()

@end

@implementation InfoViewController

@synthesize newsArray;
@synthesize infoTableView;
@synthesize newCategory;
@synthesize pageIndex;

- (void)loadView {
    [super loadView];
    
    newCategory = 1;
    pageIndex = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.infoTableView.dataSource = self;
    self.infoTableView.delegate = self;
    //self.infoTableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    newsArray = [[NSMutableArray alloc] initWithCapacity:10];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self loadContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)categorySender:(id)sender {
    UISegmentedControl* segmentedControl = (UISegmentedControl*)sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    newCategory = (int)selectedSegment + 1;
    
    [self clear];
    [self loadContent];
}

- (void)clear
{
    [newsArray removeAllObjects];
    [infoTableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*
 * 开始请求网络数据
 */
- (void) loadContent{
    
    NSLog(@"开始请求数据");
    
    NSString *str;
    
    pageIndex = [newsArray count] / 20;
    if (newCategory == 1) {
        str = [NSString stringWithFormat:@"%@catalog=%d&pageIndex=%d&pageSize=%d",
               new_url, 1, pageIndex, 20];
        NSLog(@"%@",str);
        NSLog(@"pageIndex : %d", pageIndex);
    } else if (newCategory == 2 ){
        str = [NSString stringWithFormat:@"%@type=latest&pageIndex=%d&pageSize=%d",
               blog_url, pageIndex, 20];
        NSLog(@"%@",str);
        NSLog(@"pageIndex : %d", pageIndex);
    }
    
    
    
    NSURL *url = [NSURL URLWithString:str];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLConnection *connection = [[NSURLConnection alloc]
                                   initWithRequest:request delegate:self];
    
    if (connection) {
        _datas = [NSMutableData new];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [_datas appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"%@",[error localizedDescription]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSLog(@"请求完成");
    
    NSString *msg;
    msg = [[NSString alloc] initWithData:_datas encoding:NSUTF8StringEncoding];
    //NSLog(@"%@", msg);
    
    if (newCategory == 1) {
        NSMutableArray *array = [XMLParser newsParser:msg];
        //newsArray = [XMLParser newsParser:msg];
        [newsArray addObjectsFromArray:array];
    } else if (newCategory  == 2) {
        NSMutableArray *array = [XMLParser blogParser:msg];
        [newsArray addObjectsFromArray:array];
    }
    
    
    [self.infoTableView reloadData];
    [self createTableFooter];
}

- (void)createTableFooter {
    self.infoTableView.tableFooterView = nil;
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.infoTableView.bounds.size.width, 40.0f)];
    UILabel *loadMoreText = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 116.0f, 40.0f)];
    [loadMoreText setCenter:tableFooterView.center];
    [loadMoreText setFont:[UIFont fontWithName:@"Helvetica Neue" size:14]];
    [loadMoreText setText:@"上拉显示更多数据"];
    [tableFooterView addSubview:loadMoreText];
    
    self.infoTableView.tableFooterView = tableFooterView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 55;
}
 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger row = [newsArray count];
    //NSLog(@"row: %ld",(long)row);
    return row;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *tag = @"NewCell";
    
    MsgCell *cell = [infoTableView dequeueReusableCellWithIdentifier:tag];
    MsgDetail *news = [newsArray objectAtIndex:[indexPath row]];
    
    cell.title.text  = news.title;
    cell.author.text = news.author;
    cell.date.text   = news.date;
     
    return cell;
}

/*
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    MsgDetail *msg = [newsArray objectAtIndex:[indexPath row]];
    NSLog(@"click at row : %ld", (long)[indexPath row]);
    [PushViews pushNewsDetailView:self.navigationController andMsg:msg andCategory:newCategory];
}
 */


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"will select at row : %ld", (long)[indexPath row]);
    MsgDetail *msg = [newsArray objectAtIndex:[indexPath row]];
    [PushViews pushNewsDetailView:self.navigationController andMsg:msg andCategory:newCategory];
    return nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height)) {
        NSLog(@"加载更多");
        [self loadContent];
    }

}

@end
