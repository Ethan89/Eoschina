//
//  CommentCells.m
//  EosChina
//
//  Created by Ethan Guo on 15/9/13.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import "CommentCells.h"

@implementation CommentCells

@synthesize avatarImage;
@synthesize authorLabel;
@synthesize myView;
@synthesize commentLabel;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    return self;
    
}

- (void) setContent:(CommentMsgDetails *)msg
{
    if(self)
    {
        [self initView:msg];
    }
}

- (void) initView:(CommentMsgDetails *) msg
{
    
    if(self.avatarImage)
    {
        [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:avatarImage];
        [self.avatarImage removeFromSuperview];
    }
    
    if(self.authorLabel)
    {
        [self.authorLabel removeFromSuperview];
    }
    
    if(self.myView)
    {
        [self.myView removeFromSuperview];
    }
    
    if(self.commentLabel)
    {
        [self.commentLabel removeFromSuperview];
    }
    
    avatarImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    avatarImage.image = [UIImage imageNamed:@"big_avatar_loading"];
    
    avatarImage.imageURL = [NSURL URLWithString:msg.cPortrait];
    
    
    authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 360, 30)];
    NSString *str = [NSString stringWithFormat:@"%@  发表于%@ ",msg.cAuthor,[XMLParser intervalSinceNow:msg.cPubDate]];
    authorLabel.text = str;
    authorLabel.font = [UIFont fontWithName:@"Arial" size:14];
    
    myView = [[UIView alloc] initWithFrame:CGRectMake(80, 20, 360, 100)];
    
    for (int i =0; i<msg.refrenceArray.count; i++) {
        ReferenceMsg *ref = [msg.refrenceArray objectAtIndex:i];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,20+i*40,200,15)];
        label.font = [UIFont fontWithName:@"Arial" size:14];
        label.text = ref.refertitle;
        label.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:228.0/255 alpha:1.0];
        
        UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(5, 40+i*40, 200, 15)];
        content.font = [UIFont fontWithName:@"Arial" size:14];
        content.text = ref.referbody;
        content.backgroundColor = [UIColor whiteColor];
        
        
        [self.myView addSubview:label];
        [self.myView addSubview:content];
        
    }
    
    int count =(int)[msg.refrenceArray count];
    
    if(count ==0)
    {
        commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 200, 30)];
    }
    else{
        commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 30+count*40 , 200, 30)];
    }
    
    commentLabel.text = msg.cContent;
    commentLabel.font = [UIFont fontWithName:@"Arial" size:16];
    
    
    
    [self addSubview:avatarImage];
    [self addSubview:authorLabel];
    [self addSubview:myView];
    [self addSubview:commentLabel];
    
}


@end
