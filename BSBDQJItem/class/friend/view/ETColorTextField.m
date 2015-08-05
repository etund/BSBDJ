//
//  ETColorTextField.m
//  BSBDQJItem
//
//  Created by etund on 15/7/27.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETColorTextField.h"
#import <objc/runtime.h>

@implementation ETColorTextField

+ (void)initialize{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        unsigned int count = 0;
//        Ivar *ivars = class_copyIvarList([UITextField class], &count);
//        for (const Ivar *p = ivars; p < ivars + count; p++) {
//            Ivar const ivar = *p;
//            const char *type = ivar_getTypeEncoding(ivar);
//            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
////            ETLog(@"%s-----------------%@",type,key);
//            ETLog(@"%@",key);
//        }
//    });
//    设置光标颜色跟文字颜色一样
    
}

- (void)awakeFromNib{
    self.tintColor = self.textColor;
    [self resignFirstResponder];
}

- (BOOL)becomeFirstResponder{
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder{
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}

@end
