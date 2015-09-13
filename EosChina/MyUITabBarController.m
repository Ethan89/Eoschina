//
//  myUITabBarController.m
//  EosChina
//
//  Created by Ethan Guo on 15/9/13.
//  Copyright (c) 2015年 Ethan Guo. All rights reserved.
//

#import "MyUITabBarController.h"

@implementation MyUITabBarController {
    id<ViewProtocol> viewDelegate;
    UIButton *barButton;
}

- (void) viewDidLoad {
    barButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 50)];
    [barButton setTitle:@"" forState:UIControlStateNormal];
    [barButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [barButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [barButton addTarget:self action:@selector(clickSearch:) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    
    self.navigationItem.rightBarButtonItem = item;
}

-(void) clickSearch:(id)sender
{
    [viewDelegate barButtonClick];
}

- (void)setBarTitle:(NSString *)title
{
    self.title = title;
}

-(void)setBarTitle:(NSString *)title andButtonTitle:(NSString *)buttonTitle
{
    self.title = title;
}

-(void) setBarTitle:(NSString *)title andButtonTitle:(NSString *)buttonTitle andProtocol:(id<ViewProtocol>)nProtocol
{
    self.title = title;
    [barButton setTitle:buttonTitle forState:UIControlStateNormal];
    [barButton setTitle:buttonTitle forState:UIControlStateHighlighted];
    viewDelegate = nProtocol;
}

@end
