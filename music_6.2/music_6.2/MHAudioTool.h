//
//  MHAudioTool.h
//  Music_smc
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 sunmengchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHAudioTool : NSObject

/**
 *
 * 播放音乐,暂停音乐，停止音乐
 * filename 音乐的文件名
 */
+(BOOL)playMusic:(NSString *)fileName;
+(void)pauseMusic:(NSString *)fileName;
+(void)stopMusic:(NSString *)fileName;



/**
 *
 * 播放音效,销毁音效
 * filename 音效的文件名
 */
+(void)playSound:(NSString *)fileName;
+(void)disposeSound:(NSString *)fileName;

@end
