//
//  SearchViewController.swift
//  Hack The Rack Z5
//
//  Created by Kevin Lo on 23/6/2018.
//  Copyright © 2018 Zuhlke. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet var searchingTextField: UITextField?

    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.title = self.searchingTextField?.text
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return !(self.searchingTextField?.text ?? "").isEmpty
    }

}
