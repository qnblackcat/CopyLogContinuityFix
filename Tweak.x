// CopyLogContinuityFix: keeps pasted alive under CopyLog's paste-authorization hook.
//
// CopyLogPasteD hooks -[PBCFUserNotificationPasteAnnouncer requestAuthorizationForPaste:replyHandler:]
// and compares [[announcement source] persistentIdentifier] with the home screen endpoint's.
// Only DRPasteAnnouncementApplicationEndpoint has -persistentIdentifier; a paste copied on
// another device has a DRPasteAnnouncementContinuityEndpoint source (deviceName only), so the
// message raises unrecognized selector and the uncaught exception aborts pasted (crash at
// CopyLogPasteD+0x717C on iOS 17.1.1).
//
// Fix: give the base class DRPasteAnnouncementEndpoint a -persistentIdentifier that returns nil.
// The application endpoint keeps its own method; every other endpoint answers nil, so
// isEqualToData: is NO and CopyLog falls through to %orig (the normal authorization path).
// Works whichever of the two tweaks loads first, because the fix is not on the hooked method.

#import <Foundation/Foundation.h>
#include <objc/runtime.h>
#include <dlfcn.h>

@interface DRPasteAnnouncementEndpoint : NSObject
@end

%hook DRPasteAnnouncementEndpoint

%new(@@:)
- (NSData *)persistentIdentifier {
	return nil;
}

%end

%ctor {
	// DragUI holds the endpoint classes; pasted links it, load it anyway in case it is not up yet.
	if (!objc_getClass("DRPasteAnnouncementEndpoint"))
		dlopen("/System/Library/PrivateFrameworks/DragUI.framework/DragUI", RTLD_NOW);
	if (objc_getClass("DRPasteAnnouncementEndpoint"))
		%init;
}
