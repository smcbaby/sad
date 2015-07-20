//
//  ViewController.m
//  Music_smc
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 sunmengchen. All rights reserved.
//

#import "ViewController.h"
//#import <AVFoundation/AVFoundation.h>
#import "MHAudioTool.h"
@interface ViewController ()

//@property (strong, nonatomic) AVAudioPlayer *player;
- (IBAction)play;
- (IBAction)pause;
- (IBAction)stop;
- (IBAction)next;

//需要播放的所有的歌
@property (strong, nonatomic) NSArray *songs;
//记录当前播放的是哪首歌 的索引
@property (assign, nonatomic) int currentIndex;


@end

@implementation ViewController

//懒加载
-(NSArray *)songs{
    if (!_songs) {
        self.songs = @[@"Still With You (Outro.).mp3",@"fiction.mp3",@"Midnight.mp3"];
    }
    return _songs;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

//-(AVAudioPlayer *)player{
//    
//    // 0.音频文件的URL
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Still With You (Outro.).mp3" withExtension:nil];
//    if (!_player) {
//        // 1.创建播放器(一个 AVAudioPlayer 只能播放 一个 url)
//        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//        
//        //缓冲
//        [player prepareToPlay];
//        self.player = player;
//    }
//    return _player;
//}


- (IBAction)play {
    //    [self.player play];
    [MHAudioTool playMusic:self.songs[self.currentIndex]];
}

- (IBAction)pause {
    //    [self.player pause];
    [MHAudioTool pauseMusic:self.songs[self.currentIndex]];

}

- (IBAction)stop {
    //    [self.player stop];
    //    self.player = nil;
    [MHAudioTool stopMusic:self.songs[self.currentIndex]];
}


- (IBAction)next {
    
    //点击下一首的时候，要先停止当前的这首
//    [MHAudioTool stopMusic:self.songs [self.currentIndex]];
    [self stop];
    
    self.currentIndex ++;
    if (self.currentIndex >= self.songs.count) {
        self.currentIndex = 0;
    }
    //进行播放
//    [MHAudioTool playMusic:self.songs [self.currentIndex]];
    [self play];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] == YES && self.view.window == nil) {
        self.view = nil;
    }
}
@end
