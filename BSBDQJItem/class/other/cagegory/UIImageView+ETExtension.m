//
//  UIImageView+ETExtension.m
//  BSBDQJItem
//
//  Created by etund on 15/8/11.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "UIImageView+ETExtension.h"
#import "UIImageView+WebCache.h"
#import "UIImage+ETExtension.h"

@implementation UIImageView (ETExtension)
- (void)setHeader:(NSString *)url{
    UIImage *placeHolder = [[UIImage imageNamed:@"defaultUserIcon"] circle];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeHolder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image?[image circle]:placeHolder;
    }];
}
@end
