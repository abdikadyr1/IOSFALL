//
//  ViewController.swift
//  MyFavorites2
//
//  Created by Amire Abdikadyr on 20.11.2025.
//

import UIKit

struct FavoriteItem {
    let title: String
    let subtitle: String
    let review: String
    let imageName: String
}

struct FavoriteSection {
    let title: String
    let items: [FavoriteItem]
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var sections: [FavoriteSection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Favorites"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        setupData()
    }

    private func setupData() {

        let favoriteMovies = FavoriteSection(
            title: "Favorite Movies",
            items: [
                FavoriteItem(
                    title: "Город героев",
                    subtitle: "Don Hall, Chris Williams, 2014",
                    review: "The friendship between Hiro and Baymax drives a story about healing, teamwork, and using intelligence for good.",
                    imageName: "movie1"

                ),
                FavoriteItem(
                    title: "How to Train Your Dragon",
                    subtitle: "Dean DeBlois, Chris Sanders, 2010",
                    review: "A beautiful, moving adventure about overcoming fear and seeing the world through compassion.",
                    imageName: "movie2"
                ),
                FavoriteItem(
                    title: "The Gentlemen",
                    subtitle: "Guy Ritchie, 2019",
                    review: "A stylish, fast-paced crime comedy from Guy Ritchie. Sharp dialogue, charismatic performances, and clever twists make it a highly entertaining ride.",
                    imageName: "movie3"
                ),
                FavoriteItem(
                    title: "Виноваты звезды",
                    subtitle: "Josh Boone, 2014",
                    review: "A tender, emotional romance about two teenagers finding love while battling serious illness.",
                    imageName: "movie4"
                ),
                FavoriteItem(
                    title: "Baby Driver",
                    subtitle: "Edgar Wright, 2017",
                    review: "A high-energy, music-driven action film with incredible rhythm. Choreographed car chases, a killer soundtrack, and a likable protagonist make it stand out.",
                    imageName: "movie5"
                )
            ]
        )

        let favoriteMusic = FavoriteSection(
            title: "Favorite Music",
            items: [
                FavoriteItem(
                    title: "Alash",
                    subtitle: "Mursallin(remix)",
                    review: "A perfect blend of cultural and live remix instrumentation with a rush feel.",
                    imageName: "music1"
                ),
                FavoriteItem(
                    title: "There's Nothing Holdin Me Back",
                    subtitle: "Shawn Mendes",
                    review: "Good music with a catchy melody and a fun vibe that makes it easy to dance along.",
                    imageName: "music2"
                ),
                FavoriteItem(
                    title: "Pon De Replay",
                    subtitle: "Ed Marquis, Emie",
                    review: "It sounds very atmospheric when you're driving in a night city.",
                    imageName: "music3"
                ),
                FavoriteItem(
                    title: "Nite",
                    subtitle: "Elven Dior",
                    review: "Listen to this music when you're going to something risky or exciting.",
                    imageName: "music4"
                ),
                FavoriteItem(
                    title: "fiesta bby",
                    subtitle: "RRUXI(remix)",
                    review: "Real vibes and a catchy beat that will get you moving and having fun.",
                    imageName: "music5"
                )
            ]
        )

        let favoriteBooks = FavoriteSection(
            title: "Favorite Books",
            items: [
                FavoriteItem(
                    title: "Парасат майданы",
                    subtitle: "Төлен Әбдік",
                    review: "Адамның ішкі жан дүниесіне терең үңілетін, қоғамдағы зұлымдық пен ізгілікті талқылайтын қызықты кітап.",
                    imageName: "book1"
                ),
                FavoriteItem(
                    title: "Крейцерова соната",
                    subtitle: "Лев Толстой",
                    review: "В этом книге Толстой показывает, как любовь превращается в собственничество, а музыка — в спусковой крючок трагедии.",
                    imageName: "book2"
                ),
                FavoriteItem(
                    title: "Голова профессора Доуэля",
                    subtitle: "Александр Беляев",
                    review: "История оживлённой головы великого учёного превращается в драму о том, как научные открытия могут попасть в руки бесчестных людей.",
                    imageName: "book3"
                ),
                FavoriteItem(
                    title: "Martin Eden",
                    subtitle: "Jack London",
                    review: "The story of a working-class sailor who remakes himself in pursuit of culture, success, and love is both inspiring and unsettling.",
                    imageName: "book4"
                ),
                FavoriteItem(
                    title: "Қара жел",
                    subtitle: "Бекежан Тілегенов",
                    review: "Семей ядролық полигонының қасіретін терең көркемдікпен ашатын, адам тағдыры мен ұлт жарасын шынайы көрсеткен әсерлі роман.",
                    imageName: "book5"
                )
            ]
        )

        let favoriteCourses = FavoriteSection(
            title: "Favorite University Courses",
            items: [
                FavoriteItem(
                    title: "ICPC Programming Contest",
                    subtitle: "CSE1360",
                    review: "Very interesting course where you can apply your coding skills in a competitive environment.",
                    imageName: "course1"
                ),
                FavoriteItem(
                    title: "iOS Development",
                    subtitle: "INFT3136",
                    review: "The course where I'm learning to build functional and aesthetically pleasing iOS apps.",
                    imageName: "course2"
                ),
                FavoriteItem(
                    title: "History of Kazakhstan",
                    subtitle: "HUM1101_K",
                    review: "Taught me a lot about our history and culture of Kazakhstan. Highly recommend!",
                    imageName: "course3"
                ),
                FavoriteItem(
                    title: "Linear Algebra for Engineers",
                    subtitle: "MATH1203",
                    review: "I explored the new beauty of mathematics!",
                    imageName: "course4"
                ),
                FavoriteItem(
                    title: "Discrete Structures",
                    subtitle: "CSCI1102",
                    review: "This course really sharpened my problem-solving skills.",
                    imageName: "course5"
                )
            ]
        )

        sections = [favoriteMovies, favoriteMusic, favoriteBooks, favoriteCourses]
    }
}

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count 
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }

    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "FavoriteItemCell",
            for: indexPath
        ) as? FavoriteItemCell else {
            fatalError("Could not dequeue FavoriteItemCell")
        }

        let item = sections[indexPath.section].items[indexPath.row]

        cell.titleLabel.text = item.title
        cell.subtitleLabel.text = item.subtitle
        cell.reviewLabel.text = item.review

        if !item.imageName.isEmpty {
            cell.itemImageView.image = UIImage(named: item.imageName)
        } else {
            cell.itemImageView.image = nil
        }

        return cell
    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180     
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = sections[indexPath.section].items[indexPath.row]
        print("Selected: \(item.title)")
    }
}

