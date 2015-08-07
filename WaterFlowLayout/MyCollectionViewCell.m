//
//  MyCollectionViewCell.m
//  WaterFlowLayout
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

// 为了防止图片部分重叠
- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = self.bounds;
}


@end
