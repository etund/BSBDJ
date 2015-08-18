//
//  ETToolView.m
//  BSBDQJItem
//
//  Created by etund on 15/8/6.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETToolView.h"
#import "ETTagEditController.h"
#import "ETNavContioller.h"
#import "ETPublishController.h"

@interface ETToolView()
@property (weak, nonatomic) IBOutlet UIView *tagContentView;

@property (nonatomic, weak) UIButton * addTagBtn;
@property (nonatomic, strong) NSMutableArray * tags;
@property (nonatomic, strong) NSMutableArray * tagLabels;

@end

@implementation ETToolView

//每个从xib加载的view的宽度都会不一致
+ (instancetype)toolView{
    ETToolView *toolView = [ETToolView viewFromXib];
    return toolView;
}

- (NSMutableArray *)tagLabels{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

- (void)awakeFromNib{
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
//    添加添加标签按钮
    UIButton *addTagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addTagBtn setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addTagBtn.layer.position = CGPointMake(10, 5);
    addTagBtn.size = addTagBtn.currentImage.size;
    [addTagBtn addTarget:self action:@selector(addTagClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tagContentView addSubview:addTagBtn];
    self.addTagBtn = addTagBtn;
}

- (void)addTagClick{
//    获取keyWindow的keyWindow
    UIViewController *keyRootVC = ETKeyWindow.rootViewController;
//    获取keyWindowmodel出的导航栏控制器
    ETNavContioller *nav = (ETNavContioller *)keyRootVC.presentedViewController;

    ETTagEditController *tagEditVC = [[ETTagEditController alloc] init];
    tagEditVC.tags = [self.tagLabels valueForKey:@"text"];
    __weak typeof(self) weakSelf = self;
    tagEditVC.tagsBlock = ^(NSMutableArray * tags){
        weakSelf.tags = tags;
    };
    [nav pushViewController:tagEditVC animated:YES];
}

- (void)setTags:(NSMutableArray *)tags{
    _tags = tags;
//    让全部对象执行一个方法
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    for (int i = 0 ; i < _tags.count ; i++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        [self.tagContentView addSubview:tagLabel];
        [self.tagLabels addObject:tagLabel];
        tagLabel.text = _tags[i];
        [tagLabel sizeToFit];
        UILabel *lastTag = (UILabel *)self.tagLabels[MAX(0, i-1)];
        if (i == 0) {
            lastTag = nil;
        }
        CGFloat leftMaxX = CGRectGetMaxX(lastTag.frame) + ETTagEditViewMargin;
        leftMaxX = MAX(ETTagEditViewMargin, leftMaxX);
        CGFloat leftMaxY = MAX(10, lastTag.y);
        //    获取最右侧值
        CGFloat rightWidth = ETScreenW - leftMaxX - ETTagEditViewMargin;
        if (rightWidth < (tagLabel.width + ETTagEditViewMargin)) {//换行
            tagLabel.x = ETTagEditViewMargin;
            tagLabel.y = CGRectGetMaxY(lastTag.frame) + ETTagEditViewMargin;
        }else{//不用换行
            tagLabel.x = leftMaxX;
            tagLabel.y = leftMaxY;
        }
        //    按钮属性赋值
        tagLabel.backgroundColor = ETColor(54, 128, 196);
    }
    
    //    当前右边的间隔
    UILabel *lastLabel = self.tagLabels.lastObject;
    CGFloat leftMargin = CGRectGetMaxX(lastLabel.frame) + ETTagEditViewMargin;
    CGFloat rightMargin = ETScreenW - leftMargin;
    
    //    获取文字宽度与自定义最小宽度之间的最大宽度，也就是说，右边的间距必须大于这两个条件，即大于最大宽度即可。
    CGFloat maxLimit = self.addTagBtn.width + ETTagEditViewMargin;
    if (rightMargin > maxLimit) {//如果右边的宽度足够就不用换行 有可能是第一个butoon
        self.addTagBtn.y = MAX(lastLabel.y, 10);
        self.addTagBtn.x = leftMargin;
    }else{//要换行
        self.addTagBtn.x = ETTagEditViewMargin;
        self.addTagBtn.y = CGRectGetMaxY(lastLabel.frame)+ETTagEditViewMargin;
    }
    self.tagContentView.height = CGRectGetMaxY(self.addTagBtn.frame);
    self.height = self.tagContentView.height + ETTagEditViewMargin + 30;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [self sizeToFit];
    self.height = CGRectGetMaxY(self.addTagBtn.frame) + ETTagEditViewMargin + 30;
    self.y = ETScreenH - self.height;
}

@end
