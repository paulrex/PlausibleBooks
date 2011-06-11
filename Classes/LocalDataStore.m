//
//  LocalDataStore.m
//  PlausibleBooks
//
//  Created by Mahipal Raythattha on 6/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocalDataStore.h"
#import "Book.h"


@implementation LocalDataStore

- (id) initWithPathToDatabase: (NSString *) path
{
    self = [super init];
    if (self)
    {
        db = [[PLSqliteDatabase alloc] initWithPath:path];
        dehydratedBooks = nil;
        
        if (![db open])
        {
            DebugLog(@"Could not open database!");
            db = nil;
            return nil;
        }
    }
    return self;
}

// this returns a handle to the (cached) array of books
- (NSArray *) dehydratedBooks
{
    if (dehydratedBooks != nil)
        return dehydratedBooks;
    
    NSMutableArray *bookAccumulator = [[NSMutableArray alloc] init];
    
    id<PLResultSet> results = [db executeQuery: @"SELECT id FROM example WHERE id = ?", [NSNumber numberWithInteger: 42]];
    while ([results next]) {
        NSLog(@"Value of column id is %d", [results intForColumn: @"id"]);
    }
    // Failure to close the result set will not leak memory, but may
    // retain database resources until the instance is deallocated.
    [results close];
    
    dehydratedBooks = [bookAccumulator copy];
    [bookAccumulator release];
    
    return dehydratedBooks;
}

// this returns a new Book object populated with the data from the requested table row
- (Book *) newHydratedBookWithId: (int) pk
{
    Book *b = [[Book alloc] init];
    
    
    
    return b;
}

- (void) dealloc
{
    [db close];
    
    [super dealloc];
}

@end
