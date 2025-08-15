//
//  LockedInWidgetsBundle.swift
//  LockedInWidgets
//
//  Created by Cole Carter on 8/15/25.
//

import WidgetKit
import SwiftUI

@main
struct LockedInWidgetsBundle: WidgetBundle {
    var body: some Widget {
        LockedInWidgets()
        LockedInWidgetsControl()
        LockedInWidgetsLiveActivity()
    }
}
