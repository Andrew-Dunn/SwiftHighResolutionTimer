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

import XCTest
import HighResolutionTimer

public class HighResolutionTimerTests: XCTestCase {
    func testAccuracy() {
        let hrt = HighResolutionTimer()
        XCTAssertLessThan(hrt.check(), 0.001)
        hrt.mark()
        Thread.sleep(forTimeInterval: TimeInterval(2.0))
        var elapsed = hrt.check()
        XCTAssertGreaterThan(elapsed, 2.000)
        XCTAssertLessThan(elapsed, 2.005)
        hrt.mark()
        Thread.sleep(forTimeInterval: TimeInterval(5.0))
        elapsed = hrt.check()
        XCTAssertGreaterThan(elapsed, 5.000)
        XCTAssertLessThan(elapsed, 5.005)
        hrt.mark()
        Thread.sleep(forTimeInterval: TimeInterval(10.0))
        elapsed = hrt.check()
        XCTAssertGreaterThan(elapsed, 10.000)
        XCTAssertLessThan(elapsed, 10.005)
    }
    public static var allTests = [
        ("testAccuracy", testAccuracy),
    ]
}
