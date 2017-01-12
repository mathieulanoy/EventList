//
//  ELViewController.swift
//  EventList
//
//  Created by Mathieu LANOY on 12/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit

class ELViewController: UIViewController {
}

extension ELViewController: ELStoryboardInstantiable {
    static var storyboardName: String { return "Main" }
    static var storyboardIdentifier: String? { return String(describing: self)}
}
