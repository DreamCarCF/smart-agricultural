//
//  YPChannelCell.h
//  YPReusableController
//
//  Created by MichaelPPP on 16/2/1.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "YPBaseCollectionCell.h"

@interface YPChannelCell : YPBaseCollectionCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *idStr;

+ (instancetype)channelCellWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath;

@end
