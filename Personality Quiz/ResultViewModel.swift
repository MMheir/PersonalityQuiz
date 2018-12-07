import Foundation

public class ResultsViewModel {
    
    init(){}
    
    internal var mostCommonAnswer: [AnimalType] = [] // This is the model
    
    func getAnswerText() -> String {
        
        var answerText = NSLocalizedString("Results", comment: "Text that comes before the animal(s)")
        // Add view model for results view
        if mostCommonAnswer.count != 0 {
            for answer in mostCommonAnswer {
                answerText = answerText + " \(answer.rawValue)"
            }
            return answerText
        } else {
            return answerText + NSLocalizedString("carnivore", comment: "When the user does not select any answers")
        }
        // TODO: Make a list of results and pass that list to localized string
    }
}
