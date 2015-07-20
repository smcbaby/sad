
//
//  MHAudioTool.m
//  Music_smc
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 sunmengchen. All rights reserved.
//

#import "MHAudioTool.h"
#import <AVFoundation/AVFoundation.h>



@implementation MHAudioTool

/**
 * 存放所有音效ID
 */
static NSMutableDictionary *_soundIDs;
+(NSMutableDictionary *)soundIDs{
    if (!_soundIDs) {
        _soundIDs = [NSMutableDictionary dictionary];
    }
    return _soundIDs;
}
/**
 * 存放所有音乐文件
 */
//懒加载，单例。
static NSMutableDictionary *_musicPlayers;
+(NSMutableDictionary *)musicPlayers{
    if (!_musicPlayers) {
        _musicPlayers = [NSMutableDictionary dictionary];
    }
    return _musicPlayers;
}


/**
 *
 * 播放音乐
 * filename 音乐的文件名
 */
+(BOOL)playMusic:(NSString *)fileName{
    
    if (!fileName) return NO;
    
    //1.取出对应的播放器
    AVAudioPlayer *player = [self musicPlayers][fileName];
    
    //2.播放器没有创建，进行初始化
    if (!player) {
        // 音频文件的URL
        NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        if (!url) return NO;
        // 创建播放器(一个 AVAudioPlayer 只能播放 一个 url)
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        //缓冲,失败就返回空
        if (![player prepareToPlay]) return NO;
        
        //成功，就存入字典
        [self musicPlayers][fileName] = player;
    }
    //3.播放，如果没有播放，才进去播放
    if (!player.isPlaying) {
        [player play];
    }
    //正在播放
    return YES;
}
/**
 *
 * 暂停音乐
 * filename 音乐的文件名
 */
+(void)pauseMusic:(NSString *)fileName{
    
    if (!fileName) return;
    
    //取出对应的播放器
    AVAudioPlayer *player = [self musicPlayers][fileName];
    //暂停，应该是暂停当前 播放的音乐呀
//    if (!player.isPlaying) {
//        [player pause];
//    }??????????????????????????????这样写暂停就不能用
    [player pause];
}
/**
 *
 * 停止音乐
 * filename 音乐的文件名
 */
+(void)stopMusic:(NSString *)fileName{
    if (!fileName) return;
    
    //1.取出对应的播放器
    AVAudioPlayer *player = [self musicPlayers] [fileName];
    
    //2.停止
    [player stop];
    
    //3.将播放器从字典中移除
    [[self musicPlayers]removeObjectForKey:fileName];
}



/**
 *
 * 播放音效,销毁音效
 * filename 音效的文件名
 */
+(void)playSound:(NSString *)fileName{
    
    if (!fileName) return ;
    
    //1.取出对应的音效ID
    SystemSoundID soundID = [[self soundIDs][fileName] unsignedLongValue];
    
    //2.初始化
    if (!soundID) {
        //音频文件的 url
        NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        if (!url) return ;
        OSStatus status = AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
        NSLog(@"%d",(int)status);
        
        //存入字典
        [self soundIDs][fileName] = @(soundID);
    }
    //3.播放
    AudioServicesPlaySystemSound(soundID);
    
}
+(void)disposeSound:(NSString *)fileName{
    
    if (!fileName) return;
    
    //1.取出对应的音效ID
    SystemSoundID soundID = [[self soundIDs][fileName] unsignedLongValue];
    
    //2.销毁
    if (soundID != 0) {
        AudioServicesDisposeSystemSoundID(soundID);
    }
    //3.从字典中移除
    [[self soundIDs] removeObjectForKey:fileName];
}






















@end
