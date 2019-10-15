// SBTIPCTransport.m
//
// Copyright (C) 2019 Subito.it S.r.l (www.subito.it)
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "SBTIPCTransport.h"

#if TARGET_OS_SIMULATOR

@implementation SBTIPCTransportRequest

@end

@implementation SBTIPCTransport
    - (void)sendSynchronousRequestWithPath:(NSString *)path params:(NSDictionary<NSString *, NSString *> *)params completion:(void(^)(NSData *data))completionBlock
    {
        NSAssert(self.hook != nil, @"nil hook???");
        SBTIPCTransportRequest *request = [[SBTIPCTransportRequest alloc] init];
        request.path = path;
        request.parameters = params;

        completionBlock(self.hook(request));
    }
@end

#endif
