//
//  DMIssueReport.h
//  DevMateIssues
//
//  Copyright © 2016-2018 DevMate Inc. All rights reserved.
//

#if __has_feature(modules)
@import Foundation;
#else
#import <Foundation/Foundation.h>
#endif

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DMIssueType)
{
    DMIssueTypeCrash        = 1,
    DMIssueTypeException    = 2,
};

@protocol DMIssue <NSObject>

@property (nonatomic, readonly) DMIssueType type;
@property (nonatomic, readonly) NSDate *creationDate;

@property (nonatomic, readonly) NSString *appIdentifier;
@property (nonatomic, readonly) NSString *appVersion;

- (NSString *)stringRepresentation;

@end

NS_ASSUME_NONNULL_END
