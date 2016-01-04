//
//  Scholarhip.swift
//  Friendbook
//
//  Created by Faisal Khan on 11/26/15.
//  Copyright © 2015 Umbrella. All rights reserved.
//

import Foundation
import UIKit

class Scholarship {
    
    class ScholarsDetails {
        var title : String?
        var overview : String?
        var image: UIImage?
        var url: String?
        var location: String?
        var degree: String?
        var majors: String?
    
    init(title: String, overview: String, image: String, url: String, location: String, degree: String, majors: String) {
        
        self.title = title
        self.overview = overview
        let img = image
        self.image = UIImage(named: img)
        self.url = url
        self.location = location
        self.degree = degree
        self.majors = majors
    }
}
    
    let scholarshipArray = [

        
        ScholarsDetails(title: "Fulbright", overview: "The Fulbright Masters and PhD Program funds graduate study in the United States for a Master's or Ph.D. degree . Funded by the United States Agency for International Development (USAID), these grants cover tuition, required textbooks, airfare, a living stipend, and health insurance. ", image: "fulbright.png", url: "http://us.fulbrightonline.org", location: "USA", degree: "Masters", majors: "Business, Agriculture"),
        
        ScholarsDetails(title: "Humphrey", overview: "Mid-career", image: "humphrey.png", url: "https://www.humphreyfellowship.org", location: "UK", degree: "Masters", majors: "Business, Agriculture, Media, Finance, Legal")
    ]
    
}





