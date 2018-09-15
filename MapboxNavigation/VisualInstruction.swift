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
    var maneuverImageSet: CPImageSet? {
        let colors: [UIColor] = [.black, .white]
        let blackAndWhiteManeuverIcons: [UIImage] = colors.compactMap { (color) in
            let mv = ManeuverView()
            mv.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            mv.primaryColor = color
            mv.backgroundColor = .clear
            mv.scale = UIScreen.main.scale
            mv.visualInstruction = self
            return mv.imageRepresentation
        }
        guard blackAndWhiteManeuverIcons.count == 2 else { return nil }
        return CPImageSet(lightContentImage: blackAndWhiteManeuverIcons[1], darkContentImage: blackAndWhiteManeuverIcons[0])
    }

    @available(iOS 12.0, *)
    func maneuverLabelAttributedText(bounds: @escaping () -> (CGRect), shieldHeight: CGFloat) -> NSAttributedString? {
        let instructionLabel = InstructionLabel()
        instructionLabel.availableBounds = bounds
        instructionLabel.shieldHeight = shieldHeight
        
        // Temporarily add the view to the view hierarchy for UIAppearance to work its magic.
        if let carWindow = CarPlayManager.shared.carWindow {
            carWindow.addSubview(instructionLabel)
            instructionLabel.instruction = self
            instructionLabel.removeFromSuperview()
        } else {
            instructionLabel.instruction = self
        }
        
        return instructionLabel.attributedText
    }
#endif
}
