//
//  ViewController.m
//  KTVPlayer
//
//  Created by Blues on 2019/1/24.
//  Copyright © 2019 RC. All rights reserved.
//

#import "ViewController.h"
#import <KTVHTTPCache/KTVHTTPCache.h>
#import <ZFPlayer/ZFPlayer.h>
#import "ZFAVPlayerManager.h"
#import "GoddessVideoView.h"


@interface ViewController ()

@property(nonatomic,strong)NSArray *videoArray;
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) GoddessVideoView *goddessVideoView;
@property (nonatomic, strong) NSArray *assetURLs;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setupHTTPCache];
    });
    if (!_goddessVideoView) {
        _goddessVideoView = [[GoddessVideoView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        //        goddessVideoView.hidden = YES;
        [self.view addSubview:_goddessVideoView];
        [self.view layoutIfNeeded];
        
        
    }
    
    [self loadData];
    [self initPlayer];
    
}

- (void)setupHTTPCache
{
    [KTVHTTPCache logSetConsoleLogEnable:YES];
    NSError * error;
    [KTVHTTPCache proxyStart:&error];
    if (error) {
        NSLog(@"Proxy Start Failure, %@", error);
    } else {
        NSLog(@"Proxy Start Success");
    }
    [KTVHTTPCache tokenSetURLFilter:^NSURL * (NSURL * URL) {
        NSLog(@"URL Filter reviced URL : %@", URL);
        return URL;
    }];
    [KTVHTTPCache downloadSetUnsupportContentTypeFilter:^BOOL(NSURL * URL, NSString * contentType) {
        NSLog(@"Unsupport Content-Type Filter reviced URL : %@, %@", URL, contentType);
        return NO;
    }];
}

-(void)initPlayer{
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    playerManager.scalingMode = ZFPlayerScalingModeAspectFill;
    //    KSMediaPlayerManager *playerManager = [[KSMediaPlayerManager alloc] init];
    //    ZFIJKPlayerManager *playerManager = [[ZFIJKPlayerManager alloc] init];
    
    /// player的tag值必须在cell里设置
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.goddessVideoView];
    //    self.player.controlView = self.controlView;
    self.player.assetURLs = self.assetURLs;
    /// 0.8是消失80%时候，默认0.5
    self.player.playerDisapperaPercent = 0.8;
    /// 移动网络依然自动播放
    self.player.WWANAutoPlay = YES;
    
    //    @weakify(self)
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        //        @strongify(self)
    };
    
    __weak ViewController *weakSelf = self;
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        //        @strongify(self)
        [weakSelf setNeedsStatusBarAppearanceUpdate];
        [UIViewController attemptRotationToDeviceOrientation];
    };
}

-(void)loadData{
    self.assetURLs = @[[NSURL URLWithString:@"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"],
                       [NSURL URLWithString:@"https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h.mp4"],
                       [NSURL URLWithString:@"https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/peter/mac-peter-tpl-cc-us-2018_1280x720h.mp4"],
                       [NSURL URLWithString:@"https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/grimes/mac-grimes-tpl-cc-us-2018_1280x720h.mp4"],
                       [NSURL URLWithString:@"http://flv3.bn.netease.com/tvmrepo/2018/6/H/9/EDJTRBEH9/SD/EDJTRBEH9-mobile.mp4"],
                       [NSURL URLWithString:@"http://flv3.bn.netease.com/tvmrepo/2018/6/9/R/EDJTRAD9R/SD/EDJTRAD9R-mobile.mp4"],
                       [NSURL URLWithString:@"http://www.flashls.org/playlists/test_001/stream_1000k_48k_640x360.m3u8"],
                       [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-video/7_517c8948b166655ad5cfb563cc7fbd8e.mp4"],
                       [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/68_20df3a646ab5357464cd819ea987763a.mp4"],
                       [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/118_570ed13707b2ccee1057099185b115bf.mp4"],
                       [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/15_ad895ac5fb21e5e7655556abee3775f8.mp4"],
                       [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/12_cc75b3fb04b8a23546d62e3f56619e85.mp4"],
                       [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/5_6d3243c354755b781f6cc80f60756ee5.mp4"],
                       [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-movideo/11233547_ac127ce9e993877dce0eebceaa04d6c2_593d93a619b0.mp4"]];
    
}





@end
