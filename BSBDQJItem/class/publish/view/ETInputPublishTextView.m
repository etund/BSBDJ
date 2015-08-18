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

#pragma mark - 懒加载
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

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
}

#pragma mark - 视图处理
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.tintColor = [UIColor lightGrayColor];
        self.font = [UIFont systemFontOfSize:16];
        [ETDefaultNotificationCenter addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

//动态监听以及适应placeholderLabel的变化;
- (void)layoutSubviews{
    [super layoutSubviews];
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
    
}

#pragma mark - 自定义方法
- (void)textChange{
    self.placeholderLabel.hidden = self.hasText;
}

#pragma mark - 死亡时移除监听器
- (void)dealloc{
    [ETDefaultNotificationCenter removeObserver:self];
}

- (void)setDefaultText:(NSString *)defaultText{
    self.text = defaultText;
    [self textChange];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    [self setValue:[UIColor randomColor] forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont{
    self.font = placeholderFont;
}



@end
