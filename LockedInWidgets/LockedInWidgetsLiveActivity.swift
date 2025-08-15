//
//  LockedInWidgetsLiveActivity.swift
//  LockedInWidgets
//
//  Created by Cole Carter on 8/15/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LockedInWidgetsAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct LockedInWidgetsLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LockedInWidgetsAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension LockedInWidgetsAttributes {
    fileprivate static var preview: LockedInWidgetsAttributes {
        LockedInWidgetsAttributes(name: "World")
    }
}

extension LockedInWidgetsAttributes.ContentState {
    fileprivate static var smiley: LockedInWidgetsAttributes.ContentState {
        LockedInWidgetsAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: LockedInWidgetsAttributes.ContentState {
         LockedInWidgetsAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: LockedInWidgetsAttributes.preview) {
   LockedInWidgetsLiveActivity()
} contentStates: {
    LockedInWidgetsAttributes.ContentState.smiley
    LockedInWidgetsAttributes.ContentState.starEyes
}
