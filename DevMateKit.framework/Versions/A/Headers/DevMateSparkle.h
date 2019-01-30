//
//  DevMateSparkle.h
//  Sparkle
//
//  Created by Dmytro Tretiakov on 10/1/14.
//
//

#if __has_feature(modules)
@import Cocoa;
#else
#import <Cocoa/Cocoa.h>
#endif

// If you are using your own copy of Sparkle.framework just define
// USED_CUSTOM_SPARKLE_FRAMEWORK macro.
#ifndef USED_CUSTOM_SPARKLE_FRAMEWORK

#define SUUpdater                               DM_SUUpdater
#define SUUpdaterQueue                          DM_SUUpdaterQueue
#define SUAppcast                               DM_SUAppcast
#define SUAppcastItem                           DM_SUAppcastItem
#define SUUpdaterDelegate                       DM_SUUpdaterDelegate
#define SUUpdaterDelegate_DevMateInteraction    DM_SUUpdaterDelegate_DevMateInteraction
#define SUVersionComparison                     DM_SUVersionComparison
#define SUStandardVersionComparator             DM_SUStandardVersionComparator
#define SUVersionDisplay                        DM_SUVersionDisplay

#import "SUExport.h"
#import "SUUpdater.h"
#import "SUUpdaterQueue.h"
#import "SUUpdaterDelegate.h"
#import "SUAppcast.h"
#import "SUAppcastItem.h"
#import "SUVersionComparisonProtocol.h"
#import "SUStandardVersionComparator.h"
#import "SUVersionDisplayProtocol.h"
#import "SUErrors.h"

#endif // USED_CUSTOM_SPARKLE_FRAMEWORK
