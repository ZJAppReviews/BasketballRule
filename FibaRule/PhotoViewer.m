//
//  PhotoViewer.m
//  FibaRule
//
//  Created by sungeo on 15/1/5.
//  Copyright (c) 2015年 buddysoft. All rights reserved.
//

#import "PhotoViewer.h"
#import "Collection.h"
#import "CollectionManager.h"
#import "BDFoundation.h"
#import "DataSource.h"

@implementation PhotoViewer

+ (PhotoViewer *)defaultInstance{
    static PhotoViewer * sPhotoViewer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sPhotoViewer == nil) {
            sPhotoViewer = [[PhotoViewer alloc] init];
        }
    });
    
    return sPhotoViewer;
}

- (void)showPhotos:(NSArray *)photos withFirstPage:(NSUInteger)firstPage{
    // TODO: 隐藏向前向后按钮
    IDMPhotoBrowser * pb = [[IDMPhotoBrowser alloc] initWithPhotos:photos];
    pb.delegate = self;
    pb.displayActionButton = YES;
    pb.displayCounterLabel = YES;
    pb.actionButtonTitles = @[@"加入书签"];
    [pb setInitialPageIndex:firstPage];
    
    [kWindow.rootViewController presentViewController:pb animated:YES completion:nil];
}

#pragma mark IDMPhotoBrowserDelegate
- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didDismissActionSheetWithButtonIndex:(NSUInteger)buttonIndex photoIndex:(NSUInteger)photoIndex{
    if (buttonIndex == 0) {
        [[AlertViewTextEditor defaultInstance] showWithPlaceHolder:@"请输入书签名字" title:@"添加书签" completed:^(NSString * text){
            // 加入书签
            IDMPhoto * photo = [photoBrowser photoAtIndex:photoIndex];
            NSURL * photoUrl = photo.photoURL;
            
            Collection * collection = [[Collection alloc] init];
            collection.url = photoUrl.relativeString;
            collection.comment = text;
            collection.type = [DataSource dataTypeForUrl:collection.url];
            
            [[CollectionManager defaultInstance] addCollection:collection];
            
            [MBProgressManager toast:@"添加书签成功" delay:1.0 inView:photoBrowser.view];
        }];
    }
}

@end
