#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSURLRequest+SBTUITestTunnelMatch.h"
#import "SBTIPCTransport.h"
#import "SBTMonitoredNetworkRequest.h"
#import "SBTSwizzleHelpers.h"
#import "SBTTunnelRequest.h"
#import "SBTUITestTunnel.h"
#import "SBTUITestTunnelCommon.h"

FOUNDATION_EXPORT double SBTUITestTunnelCommonVersionNumber;
FOUNDATION_EXPORT const unsigned char SBTUITestTunnelCommonVersionString[];

