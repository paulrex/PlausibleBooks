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

// this returns a handle to the (cached) array of books.
// we call this array "dehydrated" because these Book objects do not contain the FULL metadata.
// rather, they only contain the data we need to show for the list view (in this case, the table in the RootVC).
// you would modify this select query to grab all the columns that you need to display to the user for an initial list.
// when the user picks a row in this list, you would then use the primary key (in the "pk" property, here) to grab the hydrated object.
//
// exercise: modify the rootVC to show the author in the detailsLabel of the cell, then come back and update this function.
//
- (NSArray *) dehydratedBooks
{
    if (dehydratedBooks != nil)
        return dehydratedBooks;
    
    NSMutableArray *bookAccumulator = [[NSMutableArray alloc] init];
    
    id<PLResultSet> results = [db executeQuery:@"SELECT id, title FROM books"];
    while ([results next])
    {
        Book *b = [[Book alloc] init];
        b.pk = [results intForColumn:@"id"];
        b.title = [results stringForColumn:@"title"];

        [bookAccumulator addObject:b];
        [b release];
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
    
    id<PLResultSet> results = [db executeQuery:@"SELECT * FROM books WHERE id = ?", [NSNumber numberWithInt:pk]];
    [results next];

    b.pk = [results intForColumn:@"id"];
    b.title = [results stringForColumn:@"title"];
    b.author = [results stringForColumn:@"author"];
    b.copyright = [results dateForColumn:@"copyright"];
    
    [results close];
    
    return b;
}

- (void) dealloc
{
    [db close];
    
    [super dealloc];
}

@end
