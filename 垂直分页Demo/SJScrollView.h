//
//  SJScrollView.h
//  垂直分页Demo
//
//  Created by app;e on 15/12/7.
//  Copyright © 2015年 world. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJScrollView : UIScrollView
@property (nonatomic,copy) void(^viewBlock)(CGFloat y);
@end

