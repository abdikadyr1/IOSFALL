import Foundation

// 1
let firstName: String = "Amire"
let lastName: String = "Abdikadyr"
let birthYear: Int = 2006
let currentYear: Int = 2025
let age: Int = currentYear - birthYear
let isStudent: Bool = true
let height: Double = 1.80
let country: String = "Kazakhstan"

// 2
let hobby: String = "Playing football"
let numberOfHobbies: Int = 3
let favoriteNumber: Int = 16
let isHobbyCreative: Bool = false
let secondHobby: String = "Running"

// 3
let lifeStory = """
My name is \(firstName) \(lastName). I am \(age) years old, born in \(birthYear). \
I am currently\(isStudent ? "" : " not") a student. \
I enjoy \(hobby)\(isHobbyCreative ? ", which is a creative hobby" : ""). \
I also like \(secondHobby). \
I have \(numberOfHobbies) hobbies in total, and my favorite number is \(favoriteNumber). \
I am \(height) meters tall and I live in \(country).
"""

// life story
print(lifeStory)
