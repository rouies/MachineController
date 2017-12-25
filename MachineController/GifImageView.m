//
//  GifImageView.m
//  MachineController
//
//  Created by rouies zhang on 2017/12/25.
//  Copyright © 2017年 rouies zhang. All rights reserved.
//

#import "GifImageView.h"

@implementation GifImageView

-(void)createGifImageView:(NSString*) path{
    //获取gif文件数据
    CGImageSourceRef source = CGImageSourceCreateWithURL((CFURLRef)[NSURL fileURLWithPath:path], NULL);
    //获取gif文件中图片的个数
    size_t count = CGImageSourceGetCount(source);
    //定义一个变量记录gif播放一轮的时间
    //定义一个可变数组存放所有图片
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    for (size_t i=0; i<count; i++) {
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
        UIImage* itemImg = [UIImage imageWithCGImage:image];
        [imageArray addObject:itemImg];
        CGImageRelease(image);
        //获取图片信息
        //NSDictionary *info = (__bridge NSDictionary *)CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
        //NSLog(@"info---%@",info);
    }
    self.animationImages = imageArray; //获取Gif图片列表
}

-(instancetype) initWithPath:(NSString *)path andFrame:(CGRect)rect{
    self = [super initWithFrame:rect];
    if(self != nil){
        [self createGifImageView:path];
    }
    return self;
}

@end
