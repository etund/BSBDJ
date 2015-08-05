//
//  ETInputPublishTextView.m
//  BSBDQJItem
//
//  Created by etund on 15/8/5.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETInputPublishTextView.h"
#import <objc/runtime.h>


@interface ETInputPublishTextView()
@property (nonatomic, weak) UILabel * placeholderLabel;

@end

@implementation ETInputPublishTextView

- (UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.font = self.font;
        placeholderLabel.x = 5;
        placeholderLabel.y = 8;
        placeholderLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.tintColor = [UIColor lightGrayColor];
        self.font = [UIFont systemFontOfSize:16];
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
}

@end
