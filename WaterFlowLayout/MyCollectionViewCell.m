//
//  MyCollectionViewCell.m
//  WaterFlowLayout
//
//  Created by 小爪乎黑 on 15/7/29.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc] init];
        _imageView.frame = self.contentView.bounds;
        [self.contentView addSubview:_imageView];
    }
    return self;
}

// 写一个东西
- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = self.bounds;
}


@end
