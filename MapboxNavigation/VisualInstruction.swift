import MapboxDirections
#if canImport(CarPlay)
import CarPlay
#endif

extension VisualInstruction {
    
    var containsLaneIndications: Bool {
        return components.contains(where: { $0 is LaneIndicationComponent })
    }

#if canImport(CarPlay)
    @available(iOS 12.0, *)
    func maneuverImageSet(side: DrivingSide = .right) -> CPImageSet? {
        let colors: [UIColor] = [.black, .white]
        let blackAndWhiteManeuverIcons: [UIImage] = colors.compactMap { (color) in
            let mv = ManeuverView()
            mv.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            mv.primaryColor = color
            mv.backgroundColor = .clear
            mv.scale = UIScreen.main.scale
            mv.visualInstruction = self
            let image = mv.imageRepresentation
            return shouldFlipImage(side: side) ? image?.withHorizontallyFlippedOrientation() : image
        }
        guard blackAndWhiteManeuverIcons.count == 2 else { return nil }
        return CPImageSet(lightContentImage: blackAndWhiteManeuverIcons[1], darkContentImage: blackAndWhiteManeuverIcons[0])
    }
    
    func shouldFlipImage(side: DrivingSide) -> Bool {
        let leftDirection = [.left, .slightLeft, .sharpLeft].contains(maneuverDirection)
        
        switch maneuverType {
        case _ where maneuverDirection == .uTurn, .takeRoundabout, .turnAtRoundabout, .takeRotary:
            return side == .left
        default:
            return leftDirection
        }
    }

    @available(iOS 12.0, *)
    func maneuverLabelAttributedText(bounds: @escaping () -> (CGRect), shieldHeight: CGFloat) -> NSAttributedString? {
        let instructionLabelPrimary = InstructionLabel()
        instructionLabelPrimary.availableBounds = bounds
        instructionLabelPrimary.shieldHeight = shieldHeight
        instructionLabelPrimary.instruction = self
        return instructionLabelPrimary.attributedText
    }
#endif
}
