//
//  CommentCells.h
//  EosChina
//
//  Created by Ethan Guo on 15/9/13.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentMsgDetails.h"

@interface CommentCells : UITableViewCell

@property (strong,nonatomic) UIImageView  *avatarImage;
@property (strong,nonatomic) UILabel *authorLabel;
@property (strong,nonatomic) UIView *myView;
@property (strong,nonatomic) UILabel *commentLabel;

- (void)setContent:(CommentMsgDetails *)msg;

@end
