//
//  ViewController.m
//  testScrollView
//
//  Created by hyh on 15/10/9.
//  Copyright © 2015年 com.hyh. All rights reserved.
//

#import "ViewController.h"
#import "JZMTBtnView.h"

@interface ViewController ()<UIScrollViewDelegate>
{
    UILabel *label;
    
    CGPoint startPoint;
    BOOL isTouchSV;
    int suoyin;
    UIView *lineView; //下划线
    
    UIScrollView *sv;
    UIScrollView *labelScrollView;
    int currentPage;
    UIPageControl *pageControl;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createScrollViewOne];
    [self createScrollViewTwo];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)createScrollViewTwo
{
    int kNumberOfPages = 10;
    labelScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200,GET_VIEWCONTROLLER_WIDTH, 95)];
    [labelScrollView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:labelScrollView];
    
    labelScrollView.pagingEnabled = YES;
    labelScrollView.clipsToBounds = NO;
    labelScrollView.contentSize = CGSizeMake(labelScrollView.frame.size.width * (kNumberOfPages + 2), labelScrollView.frame.size.height);
    labelScrollView.showsHorizontalScrollIndicator = NO;
    labelScrollView.showsVerticalScrollIndicator = NO;
    labelScrollView.scrollsToTop = NO;
    labelScrollView.delegate = self;
    currentPage = 0;
    
    pageControl.numberOfPages = kNumberOfPages;
    pageControl.currentPage = 0;
    
    //创建在scrollView上面显示的view
    [self createAllEmptyPagesForScrollView: kNumberOfPages];
    currentPage = 0;
}

//创建在scrollView上面显示的view
- (void)createAllEmptyPagesForScrollView: (int) pages {
    
    for (int pageTemp = 0; pageTemp < pages; pageTemp++) {
        CGRect frame = labelScrollView.frame;
        UIView *viewTemp1 = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width * pageTemp, 0 , frame.size.width, frame.size.height)];
        if(pageTemp % 2 == 0){
            viewTemp1.backgroundColor = [UIColor blueColor];
        }
        [labelScrollView addSubview:viewTemp1];
    }
}

- (void)createScrollViewOne{
    sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 46, GET_VIEWCONTROLLER_WIDTH, 100)];
    // 隐藏水平滚动条
    sv.showsHorizontalScrollIndicator = NO;
    sv.showsVerticalScrollIndicator = NO;
    
    // 设置scrollView的额外顶部滚动区域:(UIEdgeInsetsMake是逆时针设置，上左下右)
    //sv.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    // 取消scrollView的弹簧效果(NO)
    sv.bounces = YES;
    sv.scrollEnabled = YES;
    sv.delegate = self;
    // 设置scrollView的滚动偏移量
    // sv.contentOffset = CGPointMake(10, 10);
    
    sv.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sv];
    
    int i;
    for (i=0; i<13; i++)
    {
        CGRect frame = CGRectMake(i*GET_VIEWCONTROLLER_WIDTH/4, 0, GET_VIEWCONTROLLER_WIDTH/4, 80);
        //CGRect frame = CGRectMake(GET_VIEWCONTROLLER_WIDTH/4, 0, GET_VIEWCONTROLLER_WIDTH/4, 80);
        NSString *title = @"测试";
        NSString *imageStr = @"recommend_final_9.png";
        JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
        btnView.tag = 20+i;
        [sv addSubview:btnView];
        
        //下划线
        //        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(
        //            btnView.frame.origin.x + 5,
        //            btnView.frame.origin.y + btnView.frame.size.height,
        //            btnView.frame.size.width - 10,
        //            0.5)];
        //
        //        //lineView.tag = 20 + i;
        //        lineView.backgroundColor = [UIColor blueColor];
        //        [sv addSubview:lineView];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
        [btnView addGestureRecognizer:tap];
        //[view addSubview:btnView];
        //[sv addSubview:view];
    }
    
    //下划线
    lineView = [[UIView alloc] initWithFrame:CGRectMake(
                                                        sv.frame.origin.x + 10,
                                                        sv.frame.origin.y + 35,
                                                        sv.frame.size.width/4 - 15,
                                                        0.5)];
    
    lineView.backgroundColor = [UIColor blueColor];
    
    [sv addSubview:lineView];
    
    // 设置scrollView的滚动范围(x、y两个方向)
    sv.contentSize = CGSizeMake(GET_VIEWCONTROLLER_WIDTH/4*i,100);
}
- (void)OnTapBtnView:(UITapGestureRecognizer *)sender{
    NSLog(@"tag:%ld",(long)sender.view.tag);
    
    for (int i = 0; i < 13; i++) {
        JZMTBtnView *btnView = (JZMTBtnView *)[sv viewWithTag:20+i];
        
        if((long)sender.view.tag == btnView.tag){
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            
            lineView.frame = CGRectMake(btnView.frame.origin.x + 10,sv.frame.origin.y + 35,sv.frame.size.width/4-15,0.5);
            
            [UIView commitAnimations];
            
            return;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch =[[event allTouches] anyObject];
    CGPoint currentPoint =[touch locationInView:self.view];
    if (CGRectContainsPoint(sv.frame, currentPoint))
    {
        isTouchSV = YES;
        startPoint = currentPoint;
    }
}


-(void) selectBtn:(UIButton *)btn
{
    [label setText:[NSString stringWithFormat:@"%ld",(long)btn.tag]];

}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView  //滑动效果停止的时候
{
    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    [label setText:[NSString stringWithFormat:@"%d",suoyin+2]];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//只要滚动了就会触发
- (void)scrollViewDidScroll:(UIScrollView *)sender {

}
@end
