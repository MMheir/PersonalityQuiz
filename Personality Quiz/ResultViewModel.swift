import Foundation

public class ResultsViewModel {
    
    var responses = [Answer : Bool]() // This is the model
    
    init(){}
    
    func getAnswerText() -> String {
        
        let mostCommonAnswer = ResultsViewModel.calculatePersonalityResult(responses: responses)
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
    
    static func calculatePersonalityResult(responses: [Answer : Bool]) -> [AnimalType] { //Dictionnaries
        var answersFrequency: [AnimalType: Int] = [:]
        //        var answersFrequency2: Dictionary<AnimalType, Int> = [:]
        //        var answersFrequency3 = Dictionary<AnimalType, Int>()
        //
        //        var arr1: [AnimalType] = [] // initializing with a litteral
        //        var arr2 = [AnimalType].init() // calling an initializer using swift shorthand
        //        var arr3 = Array<AnimalType>.init() // calling an initializer using generic syntax
        //
        //        var test1: [AnimalType: [Int]] = [:]
        //        var test2: Dictionary<AnimalType, Array<Int>> = [:]
        //        var test3 = Dictionary<AnimalType, Array<Int>>.init()
        
        // Builds the histogram
        for (answer, isSelected) in responses {
            //            answersFrequency[response] = (answersFrequency[response] ?? 0) + 1
            if isSelected {
               answersFrequency[answer.type, default: 0] += 1
            }
        }
        
        let answersAndCountSortedDecreasingByCount = answersFrequency.sorted { $0.value > $1.value }
        
        // Take all top answers equal by count
        let highestCount: Int? = answersAndCountSortedDecreasingByCount.first?.value
        let topAnswersAndCount = answersAndCountSortedDecreasingByCount.prefix { (_ , value: Int) -> Bool in
            return highestCount == value
        }
        
        // Extracting only the top answers
        let topAnswers = topAnswersAndCount.map { (key: AnimalType, value: Int) -> AnimalType in
            return key
        }
        
        // Build an array from the ArraySlice
        return Array<AnimalType>(topAnswers)
        // return [AnimalType](topAnswers)
        
        // For a future app: Madrid chaining
        
    }
}
