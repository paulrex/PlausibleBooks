//
//  LocalDataStore.m
//  PlausibleBooks
//
//  Created by Mahipal Raythattha on 6/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocalDataStore.h"


@implementation LocalDataStore

- (id) initWithPathToDatabase: (NSString *) path
{
    self = [super init];
    if (self)
    {
        db = [[PLSqliteDatabase alloc] initWithPath:path];
        
        if (![db open])
        {
            DebugLog(@"Could not open database!");
            db = nil;
            return nil;
        }
    }
    return self;
}


@end
