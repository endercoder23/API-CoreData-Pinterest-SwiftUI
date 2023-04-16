
import SwiftUI

internal extension EnvironmentValues {
    var masonryPlacementMode: MasonryPlacementMode {
        get { self[MasonryPlacementModeKey.self] }
        set { self[MasonryPlacementModeKey.self] = newValue }
    }
}


private struct MasonryPlacementModeKey: EnvironmentKey {
    static let defaultValue = MasonryPlacementMode.fill
}
