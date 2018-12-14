import Foundation

public class ResultsViewModel {
    
    init(){}
    
    private var mostCommonAnswers: [AnimalType] = [] // This is the model
    
    internal func update(from viewModel: QuestionsViewModel) {
        mostCommonAnswers = viewModel.mostCommonAnswers
    }
    
    func getAnswerText() -> String {
        
        var answerText = NSLocalizedString("Results", comment: "Text that comes before the animal(s)")
        // Add view model for results view
        if !mostCommonAnswers.isEmpty {
            for answer in mostCommonAnswers {
                answerText = answerText + " \(answer.rawValue)"
            }
            return answerText
        } else {
            return answerText + NSLocalizedString("carnivore", comment: "When the user does not select any answers")
        }
        // TODO: Make a list of results and pass that list to localized string
    }
}
