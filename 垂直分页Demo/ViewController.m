//
//  ViewController.m
//  垂直分页Demo
//
//  Created by app;e on 15/12/7.
//  Copyright © 2015年 world. All rights reserved.
//

#import "ViewController.h"
#import "SJScrollView.h"

#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width
@interface ViewController () <UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic,strong) SJScrollView *testScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.contentInset = UIEdgeInsetsMake(0, 0,10, 0);
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    id point = change[@"new"];
    CGPoint newPoint = [point CGPointValue];
    NSLog(@"%f",newPoint.y);
    if (newPoint.y > 100 && self.scrollView.dragging == NO)
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.testScrollView.frame = [UIScreen mainScreen].bounds;
            self.scrollView.frame = CGRectMake(0, -ScreenH, ScreenW, ScreenH);
        }];
    }
    __weak typeof (self) weakself = self;
    self.testScrollView.viewBlock = ^(CGFloat y){
        if (y < -120 && self.testScrollView.dragging == NO)
        {
            [UIView animateWithDuration:0.25 animations:^{
                weakself.testScrollView.frame = CGRectMake(0, ScreenH, ScreenW, ScreenH);
                weakself.scrollView.frame = [UIScreen mainScreen].bounds;
            }];
        }
    };
}


-(void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    //    [self.testScrollView removeObserver:self forKeyPath:@"contentOffset"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIScrollView *)testScrollView
{
    if (_testScrollView == nil)
    {
        _testScrollView = [[SJScrollView alloc] initWithFrame:CGRectMake(0, ScreenH, ScreenW, ScreenH)];
        _testScrollView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
        _testScrollView.contentSize = CGSizeMake(ScreenW, ScreenH);
        [_testScrollView addObserver:_testScrollView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        view.backgroundColor = [UIColor greenColor];
        [_testScrollView addSubview:view];
        [self.view addSubview:_testScrollView];
    }
    return _testScrollView;
}


/**
 *  懒加载scrollView
*/
- (UIScrollView *)scrollView
{
    if (_scrollView == nil)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        _scrollView.contentSize = CGSizeMake(ScreenW, ScreenH);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH +10)];
        view.backgroundColor = [UIColor redColor];
        [_scrollView addSubview:view];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}
@end
