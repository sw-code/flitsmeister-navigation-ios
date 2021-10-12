import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections

// To use these delegate methods, set the `VoiceControllerDelegate` on your `VoiceController`.
extension SpotARNavigationViewController: VoiceControllerDelegate {
    // Called when there is an error with speaking a voice instruction.
    public func voiceController(_ voiceController: RouteVoiceController, spokenInstructionsDidFailWith error: Error) {
        print(error.localizedDescription)
    }
    
    // Called when an instruction is interrupted by a new voice instruction.
    public func voiceController(_ voiceController: RouteVoiceController, didInterrupt interruptedInstruction: SpokenInstruction, with interruptingInstruction: SpokenInstruction) {
        print(interruptedInstruction.text, interruptingInstruction.text)
    }
    
    public func voiceController(_ voiceController: RouteVoiceController, willSpeak instruction: SpokenInstruction, routeProgress: RouteProgress) -> SpokenInstruction? {
        return SpokenInstruction(distanceAlongStep: instruction.distanceAlongStep, text: "New Instruction!", ssmlText: "<speak>New Instruction!</speak>")
    }
    
    // By default, the routeController will attempt to filter out bad locations.
    // If however you would like to filter these locations in,
    // you can conditionally return a Bool here according to your own heuristics.
    // See CLLocation.swift `isQualified` for what makes a location update unqualified.
    public func navigationViewController(_ navigationViewController: NavigationViewController, shouldDiscard location: CLLocation) -> Bool {
        return true
    }
}
