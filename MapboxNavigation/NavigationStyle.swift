import Mapbox
import SwiftUI
import GLKit

@objc(MBDayStyle)
open class NavigationStyle: Style {
    
    public required init() {
        super.init()
        mapStyleURL = URL(string: Bundle.main.object(forInfoDictionaryKey: "MGLMapboxStyleUrl") as? String ?? MGLStyle.navigationGuidanceDayStyleURL.absoluteString)!
        styleType = .day
        statusBarStyle = .default
    }
    
    open override func apply() {
        super.apply()
        
        // General styling
        if let color = UIApplication.shared.delegate?.window??.tintColor {
            tintColor = color
        } else {
            tintColor = UIColor(named: "accentColor", in: Bundle.main, compatibleWith: nil) ?? .blue
        }
        
        ArrivalTimeLabel.appearance().isHidden = true
        BaseInstructionsBannerView.appearance().isHidden = true
        BottomBannerContentView.appearance().isHidden = true
        BottomBannerView.appearance().isHidden = true
        DismissButton.appearance().isHidden = true
        DistanceLabel.appearance().isHidden = true
        DistanceRemainingLabel.appearance().isHidden = true
        EndOfRouteButton.appearance().isHidden = true
        EndOfRouteContentView.appearance().isHidden = true
        EndOfRouteStaticLabel.appearance().isHidden = true
        EndOfRouteTitleLabel.appearance().isHidden = true
        FloatingButton.appearance().isHidden = true
        GenericRouteShield.appearance().isHidden = true
        InstructionsBannerContentView.appearance().isHidden = true
        InstructionsBannerView.appearance().isHidden = true
        InstructionLabel.appearance().isHidden = true
        LaneView.appearance().isHidden = true
        LanesView.appearance().isHidden = true
        LineView.appearance().isHidden = true
        ManeuverContainerView.appearance().isHidden = true
        ManeuverView.appearance().isHidden = true
        NavigationView.appearance().backgroundColor = .white
        NavigationMapView.appearance().isHidden = true
        NextBannerView.appearance().isHidden = true
        NextInstructionLabel.appearance().isHidden = true
        PrimaryLabel.appearance().isHidden = true
        ProgressBar.appearance().isHidden = true
        ReportButton.appearance().isHidden = true
        ResumeButton.appearance().isHidden = true
        SecondaryLabel.appearance().isHidden = true
        SeparatorView.appearance().isHidden = true
        StatusView.appearance().isHidden = true
        UILabel.appearance(whenContainedInInstancesOf: [StatusView.self]).isHidden = true
        StepInstructionsView.appearance().isHidden = true
        StepListIndicatorView.appearance().isHidden = true
        StepTableViewCell.appearance().isHidden = true
        StepsBackgroundView.appearance().isHidden = true
        StylableTextView.appearance().isHidden = true
        SubtitleLabel.appearance().isHidden = true
        TitleLabel.appearance().isHidden = true
        TimeRemainingLabel.appearance().isHidden = true
        WayNameLabel.appearance().isHidden = true
        WayNameView.appearance().isHidden = true
        
        UserPuckCourseView.appearance().puckColor = .white
        UserPuckCourseView.appearance().fillColor = .red
        UserPuckCourseView.appearance().shadowColor = .white
        UserPuckCourseView.appearance().backgroundColor = .clear
        UserPuckCourseView.appearance().tintColor = .red
    }
}
