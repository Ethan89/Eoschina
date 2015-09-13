//
//  CustomProtocol.h
//  EosChina
//
//  Created by Ethan Guo on 15/9/13.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ViewProtocol <NSObject>

- (void) barButtonClick;

@end

@protocol TabBarProtocol

- (void) setBarTitle:(NSString*) title;
- (void) setBarTitle:(NSString*) title andButtonTitle:(NSString *) buttonTitle;
- (void) setBarTitle:(NSString *)title andButtonTitle:(NSString *)buttonTitle
         andProtocol:(id<ViewProtocol>)nProtocol ;


@end

