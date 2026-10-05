//
//  LogoLayout.swift
//  a1-s4115492
//
//  Created by Johnson Chang on 2026/8/29.
//

import SwiftUI

// Custom Layout for the app mark, sized from the Figma frame:
// ivy card 300×280, header 300×70, rings 45×45, capsules 40×10.
// SwiftUI scales that design to whatever space is proposed.
struct LogoLayout: Layout {
    private let designWidth: CGFloat = 300
    private let designHeight: CGFloat = 280
    private let headerHeight: CGFloat = 70

    private let circleSide: CGFloat = 25
    private let capsuleSize = CGSize(width: 40, height: 10)

    private let padding: CGFloat = 16
    private let headerIndex = 0

    private let rowCount = 3
    private let capsulesPerRow = 4

    private var expectedCount: Int { 1 + rowCount * (1 + capsulesPerRow) }

     func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
         let aspect = designHeight / designWidth
         let proposedWidth = proposal.width ?? designWidth
         let proposedHeight = proposal.height ?? proposedWidth * aspect
         let width = min(proposedWidth, proposedHeight / aspect)
         return CGSize(width: width, height: width * aspect)
     }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard subviews.count == expectedCount else { return }

        let s = bounds.width / designWidth
        let pad = padding * s
        let content = bounds.insetBy(dx: pad, dy: pad)

        let headerH = headerHeight * s
        subviews[headerIndex].place(
            at: CGPoint(x: bounds.midX, y: bounds.minY + headerH / 2),
            anchor: .center,
            proposal: ProposedViewSize(width: bounds.width, height: headerH)
        )
        let circle = circleSide * s
        let capW = capsuleSize.width * s
        let capH = capsuleSize.height * s
        let capGap = 0 * s
        let circleToCapsules = 14 * s

        let rowsTop = content.minY + headerH + pad
        let rowGap = 20 * s

        for row in 0..<rowCount {
            let rowY = rowsTop + CGFloat(row) * (circle + rowGap) + circle / 2
            let circleIndex = 1 + row * (1 + capsulesPerRow)
            let rowIndent: CGFloat = 25 * s

            subviews[circleIndex].place(
                at: CGPoint(x: content.minX + rowIndent + circle / 2, y: rowY),
                anchor: .center,
                proposal: ProposedViewSize(width: circle, height: circle)
            )

            let capsulesStartX = content.minX + rowIndent + circle + circleToCapsules
            for capsule in 0..<capsulesPerRow {
                let x = capsulesStartX + CGFloat(capsule) * (capW + capGap) + capW / 2
                subviews[circleIndex + 1 + capsule].place(
                    at: CGPoint(x: x, y: rowY),
                    anchor: .center,
                    proposal: ProposedViewSize(width: capW, height: capH)
                )
            }
        }
    }
}

struct LogoMark: View {
    private let topPurple = Color(red: 195 / 255, green: 112 / 255, blue: 243 / 255)
    private let rowPurple = Color(red: 147 / 255, green: 55 / 255, blue: 200 / 255)
    private let rowGray = Color(red: 126 / 255, green: 126 / 255, blue: 126 / 255)
    private let ivy = Color(red: 217 / 255, green: 217 / 255, blue: 217 / 255)

    var body: some View {
        LogoLayout {
          RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(topPurple)
                .overlay(
                            RoundedRectangle(cornerRadius: 24, style: .continuous)
                                .stroke(.black, lineWidth: 1.5)
                        )

            ForEach(0..<3, id: \.self) { row in
                let isGray = (row == 2)
                Circle()
                    .strokeBorder(isGray ? rowGray : .black, lineWidth: 5)

                ForEach(0..<4, id: \.self) { _ in
                    Capsule()
                        .fill(isGray ? rowGray : rowPurple)
                        .overlay {
                            if !isGray {
                                Capsule().stroke(.black, lineWidth: 1)
                            }
                        }
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(ivy)
                .overlay(
                            RoundedRectangle(cornerRadius: 32, style: .continuous)
                                .stroke(.black, lineWidth: 1.5)
                        )
        )
    }
}

#Preview {
    LogoMark()
        .frame(width: 300)
        .padding()
}
