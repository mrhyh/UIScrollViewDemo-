//
//  JZMTBtnView.m
//  meituan
//  自定义美团菜单view
//  Created by jinzelu on 15/6/30.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZMTBtnView.h"

@implementation JZMTBtnView


-(id)initWithFrame:(CGRect)frame title:(NSString *)title imageStr:(NSString *)imageStr{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat buttonWidth = frame.size.width;
        
//        CGFloat imageWidth = 60;
//        CGFloat imageHight = 60;
        CGFloat toTopHeight = frame.size.height /10 * 1;
        CGFloat imageWidth = frame.size.height / 10 * 6;
        CGFloat imageHight = frame.size.height / 10 * 6;
        CGFloat imageToLabelSpace = frame.size.height / 100 * 7;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((buttonWidth - imageWidth)/2, toTopHeight, imageWidth, imageHight)];
        imageView.image = [UIImage imageNamed:imageStr];
        [self addSubview:imageView];
        NSLog(@"imageView.frame.origin.y=%lf",imageView.frame.origin.y);
        NSLog(@"self.frame.origin.y=%lf",self.frame.origin.y);
        
        CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        CGFloat labelWidth = titleSize.width;
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake((buttonWidth - labelWidth)/2, toTopHeight + imageHight + imageToLabelSpace, labelWidth, 20)];
        titleLable.text = title;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = [UIFont systemFontOfSize:13];
        [self addSubview:titleLable];
    }
    return self;
}

// 一个view，上图片，下文字，均水平居中
/*
 -(id)initWithFrame:(CGRect)frame title:(NSString *)title imageStr:(NSString *)imageStr{
 self = [super initWithFrame:frame];
 if (self) {
 
 CGFloat buttonWidth = frame.size.width;
 
 CGFloat imageWidth = 60;
 CGFloat imageHight = 60;
 
 UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((buttonWidth - imageWidth)/2, 5, imageWidth, imageHight)];
 imageView.image = [UIImage imageNamed:imageStr];
 [self addSubview:imageView];
 CGRect tempFrame = imageView.frame;
 
 CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
 CGFloat labelWidth = titleSize.width;
 
 UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake((buttonWidth - labelWidth)/2, 10+imageHight, labelWidth, 20)];
 titleLable.text = title;
 titleLable.textAlignment = NSTextAlignmentCenter;
 titleLable.font = [UIFont systemFontOfSize:13];
 [self addSubview:titleLable];
 }
 return self;
 }
 */
@end
