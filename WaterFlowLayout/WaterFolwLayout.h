//
//  WaterFolwLayout.h
//  WaterFlowLayout
//
//  Created by 小爪乎黑 on 15/7/29.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WaterFlowLayoutDeleage <NSObject>
// 获取每一个item的高度
- (CGFloat)heightForItemIndexpath:(NSIndexPath *)indexPath;

@end


@interface WaterFolwLayout : UICollectionViewLayout
// item大小
@property (nonatomic,assign)CGSize itemSize;
// 内边距
@property (nonatomic,assign)UIEdgeInsets sectionInsets;
// 间隙
@property (nonatomic,assign)CGFloat insertItemSpacing;
// 列数
@property (nonatomic,assign)NSUInteger numberOfColumns;


@property (nonatomic,weak)id<WaterFlowLayoutDeleage>delegate;// 代理




@end
