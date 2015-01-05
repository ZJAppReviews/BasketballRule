//
//  Collection.m
//  FibaRule
//
//  Created by sungeo on 15/1/4.
//  Copyright (c) 2015年 buddysoft. All rights reserved.
//

#import "Collection.h"
#import "DataManager.h"

@implementation Collection

- (id)init{
    if (self = [super init]) {
        self.oid = @"503";
        self.comment = @"BuddySoft";
        
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        self.createTime = [formatter stringFromDate:[NSDate date]];
    }
    
    return self;
}

- (void)setUrl:(NSString *)url{
    if ([url hasPrefix:kFiba2014DataSource]) {
        self.type = [NSString stringWithFormat:@"%d", (int)CollectionFiba2014];
    }else if([url hasPrefix:kFiba2014InterpretationDataSource]){
        self.type = [NSString stringWithFormat:@"%d", (int)CollectionFiba2014Interpretation];
    }
    
    _url = url;
}

@end
