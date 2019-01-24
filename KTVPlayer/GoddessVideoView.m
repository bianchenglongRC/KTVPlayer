//
//  GoddessVideoVIew.m
//  iOSLivU
//
//  Created by Blues on 2019/1/23.
//  Copyright © 2019 RC. All rights reserved.
//

#import "GoddessVideoView.h"


@interface GoddessVideoView ()

@property (nonatomic, assign) BOOL isBuildUI;
@property (nonatomic, strong) UIImageView *goddessStateBgImgView;
@property (nonatomic, strong) UIImageView *goddessStateImgView;
@property (nonatomic, strong) UILabel *goddessStateLbl;
@property (nonatomic, strong) UIButton *callBtn;
@property (nonatomic, strong) UILabel *costLbl;
@property (nonatomic, strong) UIButton *nextBtn;

@end


@implementation GoddessVideoView


- (void)layoutSubviews
{
    if (!_isBuildUI) {
        [self buildUI];
        _isBuildUI = YES;
    }
    [super layoutSubviews];
}

- (void)buildUI
{
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [self addSubview:self.containerView];
    
}












/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
