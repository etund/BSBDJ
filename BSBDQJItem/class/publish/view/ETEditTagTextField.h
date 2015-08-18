//
//  ETEditTagTextField.h
//  BSBDQJItem
//
//  Created by etund on 15/8/8.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ETEditTagDeleteBlack)();

@interface ETEditTagTextField : UITextField
@property (nonatomic, copy) ETEditTagDeleteBlack deleteBlock;
@end
