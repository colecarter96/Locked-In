//
//  LockScreenWidgetBundle.swift
//  LockScreenWidget
//
//  Created by Cole Carter on 8/15/25.
//

import WidgetKit
import SwiftUI

@main
struct LockScreenWidgetBundle: WidgetBundle {
    var body: some Widget {
        LockScreenWidget()
        LockScreenWidgetControl()
        LockScreenWidgetLiveActivity()
    }
}
