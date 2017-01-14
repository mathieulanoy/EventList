//
//  ELLoadingViewController.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit

class LoadingViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .yellow
    }
    
    func load<A>(_ load: (@escaping (Result<A>) -> ()) -> (), build: @escaping (A) -> UIViewController) -> Self {
        load() { [weak self] result in
            guard let strongSelf = self else { return }
            guard let value = result.value else {
                if let error = result.error {
                    print("error: \(error.localizedDescription)")
                    //TODO: Display error properly :)
                }
                return
            }
            let viewController = build(value)
            strongSelf.add(content: viewController)
        }
        return self
    }
    
    func add(content: UIViewController) {
        addChildViewController(content)
        content.view.alpha = 0.0
        view.addSubview(content.view)
        content.view.translatesAutoresizingMaskIntoConstraints = false
        content.view.constrainEdges(toMarginOf: view)
        content.didMove(toParentViewController: self)
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: .calculationModeLinear, animations: {[weak self] in
            guard let strongSelf = self else { return }
            for subview in strongSelf.view.subviews {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.75, animations: {
                    subview.alpha = 0.0
                })
            }
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25, animations: {
                content.view.alpha = 1.0
            })
        }) { (finished) in
        }
    }
}
