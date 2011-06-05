//
//  LocalDataStore.h
//  PlausibleBooks
//
//  Created by Mahipal Raythattha on 6/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PlausibleDatabase/PlausibleDatabase.h>
#import "DataStore.h"

@interface LocalDataStore : NSObject <DataStore>
{
    PLSqliteDatabase *db;
    
}

- (id) initWithPathToDatabase: (NSString *) path;

@end