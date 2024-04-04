//
//  User.swift
//  LoginApp
//
//  Created by Matvei Khlestov on 04.04.2024.
//

import Foundation

struct User {
    let id = UUID()
    let login: String
    let password: String
    let person: Person
    
       static func getUser() -> User {
        User(
            login: "User",
            password: "Password",
            person: Person.getPerson()
        )
    }
}

struct Person {
    let name: String
    let surname: String
    let photo: String
    let bio: String
    let job: Company
    
    var fullName: String {
        "\(name) \(surname)"
    }
    
    static func getPerson() -> Person {
        Person(
            name: "Tim",
            surname: "Cook",
            photo: "TimCook",
            bio: "Тим Кук родился в 1960 году в городе Мобил, штат Алабама, но детство провел в городке Робертсдейл. Мать будущего предпринимателя была фармацевтом, а отец — рабочим верфи. Кук мало рассказывал о своем детстве. Известна история о том, как он увидел расправу Ку-клукс-клана над негритянской семьей. Испугавшись, Тим крикнул, чтобы они остановились, но, приглядевшись, узнал в одном из участников действа местного священника и сбежал. Эта история, по словам предпринимателя, серьезно повлияла на его взгляды.",
            job: Company.getCompany()
        )
    }
}

struct Company {
    let title: String
    let jobTitle: JobTitle
    let department: Department
    
    static func getCompany() -> Company {
        Company(
            title: "Apple",
            jobTitle: .ceo,
            department: .management
        )
    }
}

enum JobTitle: String {
    case ceo = "CEO"
    case cto = "CTO"
}

enum Department: String {
    case management = "Management"
    case marketing = "Marketing"
}

