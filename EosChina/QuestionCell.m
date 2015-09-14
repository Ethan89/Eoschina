//
//  QuestionCell.m
//  EosChina
//
//  Created by Ethan Guo on 15/9/13.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import "QuestionCell.h"

@implementation QuestionCell

@synthesize tag;

- (void)setContent:(QuestionMsg *)msg {
    
    if (self) {
        self.avatorView.imageURL = [NSURL URLWithString:msg.portrait];
        self.titleLabel.text = msg.title;
        self.answerTitle.text = @"回帖";
        self.answerCount.text = msg.answerCount;
        
        NSString *time = [XMLParser intervalSinceNow:msg.pubDate];
        
        self.authorLabel.text = [NSString stringWithFormat:@"%@        %@",msg.author,time ];
    }
}

@end
