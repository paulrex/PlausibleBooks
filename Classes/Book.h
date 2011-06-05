//
//  Book.h
//  PlausibleBooks
//
//  Created by Mahipal Raythattha on 6/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Book : NSObject
{
    NSString *title;
    NSString *author;
    NSDate *copyright;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSDate *copyright;

@end
