//
//  SJScrollView.m
//  垂直分页Demo
//
//  Created by app;e on 15/12/7.
//  Copyright © 2015年 world. All rights reserved.
//

#import "SJScrollView.h"

@implementation SJScrollView

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    id point = change[@"new"];
    CGPoint newPoint = [point CGPointValue];
    NSLog(@"y=%f",newPoint.y);

    self.viewBlock(newPoint.y);
}

@end
