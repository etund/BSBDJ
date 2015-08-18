//
//  UIView+ETExtension.h
//  BSBDQJItem
//
//  Created by etund on 15/7/23.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ETExtension)
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat  centerX;
@property (nonatomic, assign) CGFloat  centerY;

+ (instancetype)viewFromXib;

- (BOOL)isShowingOnCurrentWindow;
@end
