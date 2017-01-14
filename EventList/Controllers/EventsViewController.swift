//
//  ELEventsViewController.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit

class EventsViewController: ViewController, LoadingProtocol {

    //MARK: Attributes
    var indexes:[String] = []
    var events:[String:[EventModel]] = [:]
    
    //MARK: IBOutlets
    @IBOutlet weak var cv_events: UICollectionView!
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func configure(_ value: (indexes:[String], values:[String: [EventModel]])) {
        self.events = value.values
        self.indexes = value.indexes
        view.backgroundColor = .white
        cv_events.delegate = self
        cv_events.dataSource = self
        cv_events.register(UINib(nibName: EventCell.identifier, bundle: nil), forCellWithReuseIdentifier: EventCell.identifier)
        cv_events.register(UINib(nibName: EventHeaderView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: EventHeaderView.identifier)
        cv_events.reloadData()
    }
}

extension EventsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return indexes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let key = indexes[section]
        if let current_events = events[key] {
            return current_events.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.identifier, for: indexPath)
        let key = indexes[indexPath.section]
        if let event = events[key]?[indexPath.item] {
            (cell as! EventCell).display(event: event)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EventHeaderView.identifier, for: indexPath) as! EventHeaderView
            let key = indexes[indexPath.section]
            headerView.display(title: key)
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
}


extension EventsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let key = indexes[indexPath.section]
        if let event = events[key]?[indexPath.item] {
            return EventCell.size(forEvent: event, referenceWidth: self.cv_events.bounds.width)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0.0, 0.0, 30.0, 0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return EventHeaderView.size(referenceWidth: self.cv_events.bounds.width)
    }
}

