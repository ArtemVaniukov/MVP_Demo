//
//  Comment.swift
//  MVP_Demo
//
//  Created by Artem Vaniukov on 06.02.2022.
//

import Foundation


struct Comment: Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
