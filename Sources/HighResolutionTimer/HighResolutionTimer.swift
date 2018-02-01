//
// Copyright © Andrew Dunn, 2018
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

fileprivate let NANOSECONDS_IN_A_SECOND: Double = 1_000_000_000

/// A basic timing class that will let you know how much time has passed between two points in time.
public class HighResolutionTimer {
    #if os(Linux)
    fileprivate typealias EpochType = timespec
    #else
    fileprivate typealias EpochType = UInt64
    private var timeBaseInfo = mach_timebase_info_data_t()
    private let ticksPerSecond: Double
    #endif
    
    private var epoch: EpochType
    
    /// Constructor. Also sets the start time.
    public init() {
        #if os(Linux)
            epoch = timespec()
            clock_gettime(CLOCK_MONOTONIC, &epoch)
        #else
            mach_timebase_info(&timeBaseInfo)
            ticksPerSecond = Double(timeBaseInfo.numer) / Double(timeBaseInfo.denom) / NANOSECONDS_IN_A_SECOND
            epoch = mach_absolute_time()
        #endif
    }
    
    /// Set the start time.
    public func mark() {
        #if os(Linux)
            clock_gettime(CLOCK_MONOTONIC, &epoch)
        #else
            epoch = mach_absolute_time()
        #endif
    }
    
    /// Check how many seconds have elapsed since the start time was set.
    ///
    /// - Returns: The amount of time elapsed since the start time was set in seconds.
    public func check() -> Double {
        #if os(Linux)
            var now = timespec()
            clock_gettime(CLOCK_MONOTONIC, &now)
            let delta = Double(now.tv_sec - epoch.tv_sec)
                + (Double(now.tv_nsec - epoch.tv_nsec) / NANOSECONDS_IN_A_SECOND)
        #else
            let delta = Double(mach_absolute_time() - epoch) * ticksPerSecond
        #endif
        return delta;
    }
}
