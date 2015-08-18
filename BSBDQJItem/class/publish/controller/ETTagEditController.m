//
//  ETTagEditController.m
//  BSBDQJItem
//
//  Created by etund on 15/8/7.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETTagEditController.h"
#import "ETEditTagTextField.h"
#import <objc/runtime.h>
#import "SVProgressHUD.h"
#import "ETTagButton.h"




@interface ETTagEditController ()<UITextFieldDelegate>

@property (nonatomic, weak) ETEditTagTextField * textField;

@property (nonatomic, strong) UIButton * previewBtn;

@property (nonatomic, strong) NSMutableArray * tagBtns;

@end

@implementation ETTagEditController



#pragma mark - 视图初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ETGlobalBackColor;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    self.navigationItem.title = @"编辑个性标签";
    [self addSonView];
}

#pragma mark - 懒加载
- (NSMutableArray *)tagBtns{
    if (!_tagBtns) {
        _tagBtns = [NSMutableArray array];
    }
    return _tagBtns;
}

- (void)setTags:(NSMutableArray *)tags{
    _tags = tags;
    for (NSString *tag in tags) {
        //    创建按钮并设置内容
        ETTagButton *labelBtn = [ETTagButton buttonWithType:UIButtonTypeCustom];
        [labelBtn setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        [labelBtn setTitle:tag forState:UIControlStateNormal];
        //    添加触发事件
        [labelBtn addTarget:self action:@selector(deleteTag:) forControlEvents:UIControlEventTouchUpInside];
        //    视图关系添加
        [self.view addSubview:labelBtn];
        [self.tagBtns addObject:labelBtn];
        [self updateTagBtns];
        //    添加完button在更新TextField
        self.textField.text = nil;
        [UIView animateWithDuration:0.5 animations:^{
            [self updateTextField];
        }];
    }
}

#pragma mark - 添加子控件 并且添加触发方法
- (void)addSonView{
//    添加ETEditTagTextField
    ETEditTagTextField *textField = [[ETEditTagTextField alloc] init];
    textField.frame = CGRectMake(ETTagEditViewMargin, 70,100, 30);
    textField.font = [UIFont systemFontOfSize:14];
//    设置占位字符的按钮颜色
    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    textField.deleteBlock = ^{
        /*
         *是否有text,是否有最后的元素
         */
        if (!self.textField.hasText&&self.tagBtns.count>0) {
            [self deleteTag:self.tagBtns.lastObject];
        }
        
    };
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    [textField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [textField sizeToFit];
    [self.view addSubview:textField];
    self.textField = textField;
//   添加编辑下面按钮
    UIButton *previewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat preBtnY = CGRectGetMaxY(self.textField.frame) + ETTagEditViewMargin;
    CGFloat preBtnH = 30;
    previewBtn.frame = CGRectMake(ETTagEditViewMargin, preBtnY, ETScreenW - 2*ETTagEditViewMargin, preBtnH);
    previewBtn.backgroundColor = ETColor(54, 128, 196);
    previewBtn.titleEdgeInsets = UIEdgeInsetsMake(0, ETTagEditViewMargin/2.0, 0, 0);
    previewBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [previewBtn addTarget:self action:@selector(addBtn) forControlEvents:UIControlEventTouchUpInside];
    previewBtn.hidden = YES;
    [self.view addSubview:previewBtn];
    self.previewBtn = previewBtn;
}

#pragma mark - 辅助方法
// 用于判断是都是确认键
- (BOOL)isSureKey:(NSString *)str{
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return [str isEqualToString:@","]||[str isEqualToString:@"，"]||[str isEqualToString:@""];
}

//用于更新textField的frame变化，主要更新宽度
- (void)textFieldSizeToFit{
    self.textField.text.length!=0? :[self.textField sizeToFit];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [UIButton alloc].currentTitle
    if (_tagsBlock) {
        _tagsBlock([_tagBtns valueForKey:@"currentTitle"]);
    }
    
}

#pragma mark - 接收触发事件，并且做出相应的处理
//接受textField改变时触发事件
- (void)textChange{
    //    时刻监听监听text的变化
    CGFloat width = [self.textField.text sizeWithAttributes:@{NSFontAttributeName:self.textField.font}].width;
    self.textField.width = width;
    [self textFieldSizeToFit];
    //    当有值的时候下面按钮出现，并且title就是输入的内容
    [self viewTitleBtn];
}


//时刻监听事件,preViewBtn做出相应改变
- (void)viewTitleBtn{
    if (self.textField.hasText&&![self isSureKey:self.textField.text]) {//有值，显示按钮
        self.previewBtn.hidden = NO;
        [self.previewBtn setTitle:self.textField.text forState:UIControlStateNormal];
    }else{//没值，隐藏按钮
        self.previewBtn.hidden = YES;
    }
    
//    获取最后一个字符
    NSString *tmpText = self.textField.text;
    if (tmpText.length<=0) return;
    NSString *lastStr = [tmpText substringFromIndex:tmpText.length - 1];

//    但最后一个是添加按钮
    if ([self isSureKey:lastStr]) {
        self.textField.text = [self.textField.text substringToIndex:self.textField.text.length - 1];
//        去空格
        self.textField.text = [self.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (self.textField.text.length<=0){
            [self textFieldSizeToFit];
            return;
        }
        [self addBtn];
    }
    
}

//添加标签按钮
- (void)addBtn{
//    判断是否已经超过最大标签数
    if (self.tagBtns.count>=MaxBtnCount) {
        [SVProgressHUD showInfoWithStatus:@"已经超过最大标签数"];
        return;
    }
    
//    创建按钮并设置内容
    ETTagButton *labelBtn = [ETTagButton buttonWithType:UIButtonTypeCustom];
    [labelBtn setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
    [labelBtn setTitle:self.textField.text forState:UIControlStateNormal];
//    添加触发事件
    [labelBtn addTarget:self action:@selector(deleteTag:) forControlEvents:UIControlEventTouchUpInside];
    
//    视图关系添加
    [self.view addSubview:labelBtn];
    [_tagBtns addObject:labelBtn];
    
    [self updateTagBtns];
//    添加完button在更新TextField
    self.textField.text = nil;
    [UIView animateWithDuration:0.5 animations:^{
        [self updateTextField];
    }];
}

- (void)updateTagBtns{
    for (int i = 0; i < self.tagBtns.count; i++) {
        ETTagButton *labelBtn = self.tagBtns[i];
        ETTagButton *lastBtn = (ETTagButton *)self.tagBtns[MAX(0, i-1)];
        if (i == 0) {
            lastBtn = nil;
        }
        CGFloat leftMaxX = CGRectGetMaxX(lastBtn.frame) + ETTagEditViewMargin;
        leftMaxX = MAX(ETTagEditViewMargin, leftMaxX);
        CGFloat leftMaxY = MAX(70, lastBtn.y);
        //    获取最右侧值
        CGFloat rightWidth = ETScreenW - leftMaxX - ETTagEditViewMargin;
        [labelBtn sizeToFit];
        if (rightWidth < (labelBtn.width + ETTagEditViewMargin)) {//换行
            labelBtn.x = ETTagEditViewMargin;
            labelBtn.y = CGRectGetMaxY(lastBtn.frame) + ETTagEditViewMargin;
        }else{//不用换行
            labelBtn.x = leftMaxX;
            labelBtn.y = leftMaxY;
        }
        //    按钮属性赋值
        labelBtn.width = labelBtn.width + 3 * TagMargin;
//        labelBtn.frame = CGRectMake(labelX, labelY, labelW, labelBtn.height);
        labelBtn.backgroundColor = self.previewBtn.backgroundColor;
    }
    
}



//在每次添加完标签按钮的时候根性TextField的位置
- (void)updateTextField{
//    当前右边的间隔
    ETTagButton *lastTagBtn = [self.tagBtns lastObject];
    CGFloat leftMargin = CGRectGetMaxX(lastTagBtn.frame) + ETTagEditViewMargin;
    CGFloat rightMargin = ETScreenW - leftMargin;
//    获取当前文字需要的最小宽度
    CGFloat textWidth = [self.textField.text sizeWithAttributes:@{NSFontAttributeName:self.textField.font}].width;
//    获取文字宽度与自定义最小宽度之间的最大宽度，也就是说，右边的间距必须大于这两个条件，即大于最大宽度即可。
    CGFloat maxLimit = MAX(textWidth, MinRigtMargin);
    if (rightMargin > maxLimit) {//如果右边的宽度足够就不用换行 有可能是第一个butoon
        self.textField.y = MAX(lastTagBtn.y, 70);
        self.textField.x = leftMargin;
    }else{//要换行
        self.textField.x = ETTagEditViewMargin;
        self.textField.y = CGRectGetMaxY(lastTagBtn.frame)+ETTagEditViewMargin;
        self.previewBtn.y = CGRectGetMaxY(self.textField.frame) + ETTagEditViewMargin;
    }
    [self textFieldSizeToFit];
    [self updatePreBtn];
}

//每次更新ETEditTagTextField之后更新预览按钮
- (void)updatePreBtn{
    self.previewBtn.y = CGRectGetMaxY(self.textField.frame) + ETTagEditViewMargin;
    [self.previewBtn setTitle:@"" forState:UIControlStateNormal];
    self.previewBtn.hidden = YES;
}

//添加删除按钮的触发事件
- (void)deleteTag:(UIButton *)btn{
    [btn removeFromSuperview];
    [self.tagBtns removeObject:btn];
    [UIView animateWithDuration:0.5 animations:^{
        [self updateTagBtns];
        [self updateTextField];
    }];
}

#pragma mark - ETEditTagTextFieldDelegate
- (BOOL)textFieldShouldReturn:(ETEditTagTextField *)textField{
    [self addBtn];
    return YES;
}

#pragma mark - 完成后的操作
- (void)done{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
