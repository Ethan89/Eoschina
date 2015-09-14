//
//  QuestionCell.h
//  EosChina
//
//  Created by Ethan Guo on 15/9/13.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionMsg.h"
#import "XMLParser.h"
#import "AsyncImageView.h"

@interface QuestionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatorView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerTitle;
@property (weak, nonatomic) IBOutlet UILabel *answerCount;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@property int tag;

- (void)setContent:(QuestionMsg *)msg;
@end
