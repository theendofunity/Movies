//
//  Observable.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 21.06.2021.
//

import Foundation

protocol Observable: AnyObject {
    var updateCompletion: (() -> Void)? { get set }
}
