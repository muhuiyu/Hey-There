//
//  Constants.swift
//  Lango
//
//  Created by Mu Yu on 8/1/21.
//

import UIKit

struct Constants {
    /// 8
    static let cornerRadius: CGFloat = 8
    /// 16
    static let paddingToTop: CGFloat = 16
    /// 4
    static let textSpacingSmall: CGFloat = 4
    /// 8
    static let horizonalPadding: CGFloat = 8
    /// 8
    static let horizonalPaddingLarge: CGFloat = 8
    struct TextButton {
        /// 16
        static let cornerRadius: CGFloat = 16
        /// 24
        static let cornerRadiusLarge: CGFloat = 24
        struct Height {
            /// 44
            static let medium: CGFloat = 44
            /// 60
            static let large: CGFloat = 60
            /// 32
            static let small: CGFloat = 32
        }
    }
    struct HeaderHeight {
        /// 100
        static let withLargeTitle: CGFloat = 100
    }
    struct Card {
        /// 8
        static let cornerRadius: CGFloat = 8
        struct Size {
            /// 120
            static let small: CGFloat = 120
            /// 200
            static let medium: CGFloat = 200
            /// 300
            static let large: CGFloat = 300
        }
    }
    struct Grid {
        /// 8
        static let cornerRadius: CGFloat = 8
        static let inset: CGFloat = Constants.Spacing.medium
        struct Size {
            /// 60
            static let small: CGFloat = 60
            /// 120
            static let medium: CGFloat = 120
            /// 180
            static let large: CGFloat = 180
            /// 240
            static let enormous: CGFloat = 240
        }
    }
    struct AvatarImageSize {
        /// 96
        static let enormous: CGFloat = 96
        /// 44
        static let large: CGFloat = 44
        /// 32
        static let medium: CGFloat = 32
        /// 24
        static let small: CGFloat = 24
    }
    struct IconButtonSize {
        /// 80
        static let superb: CGFloat = 80
        /// 60
        static let enormous: CGFloat = 60
        /// 44
        static let large: CGFloat = 44
        /// 32
        static let medium: CGFloat = 32
        /// 24
        static let small: CGFloat = 24
        /// 20
        static let trivial: CGFloat = 20
        /// 12
        static let slight: CGFloat = 12
    }
    struct ChipView {
        /// 16
        static let cornerRadius: CGFloat = 16
        /// 4
        static let iconPadding: CGFloat = 4
    }
    struct Spacing {
        /// 48
        static let sectionBreak: CGFloat = 48
        /// 36
        static let enormous: CGFloat = 36
        /// 24
        static let large: CGFloat = 24
        /// 16
        static let medium: CGFloat = 16
        /// 8
        static let small: CGFloat = 8
        /// 4
        static let trivial: CGFloat = 4
        /// 2
        static let slight: CGFloat = 2
    }
    struct ProgressBar {
        /// 8
        static let height: CGFloat = 8
        /// 4
        static let cornerRadius: CGFloat = 4
    }
    struct ImageSize {
        /// 250
        static let cover: CGFloat = 250
        /// 200
        static let illustation: CGFloat = 200
        /// 150
        static let header: CGFloat = 150
        /// 44
        static let thumbnail: CGFloat = 44
        /// 64
        static let cellBackground: CGFloat = 64
        /// 375
        static let fitScreen: CGFloat = 375
        /// 200
        static let sessionQuizFlagHeight: CGFloat = 200
    }
    struct TextField {
        /// 8
        static let cornerRaduis: CGFloat = 8
        /// 44
        static let height: CGFloat = 44
    }
}
