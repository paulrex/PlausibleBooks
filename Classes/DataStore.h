/*
 *  DataStore.h
 *  PlausibleBooks
 *
 *  Created by Mahipal Raythattha on 6/4/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#import "Book.h"

@protocol DataStore <NSObject>

@required
- (NSArray *) dehydratedBooks;
- (Book *) newHydratedBookWithId: (int) pk;

@end
