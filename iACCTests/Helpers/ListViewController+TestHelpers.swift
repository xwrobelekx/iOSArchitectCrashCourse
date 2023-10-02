//	
// Copyright © Essential Developer. All rights reserved.
//

import UIKit
@testable import iACC

///
/// This `ListViewController` test helper extension provides ways of performing
/// common operations and extracting values from the view controller without coupling the tests with
/// internal implementation details, such as table views, alerts, labels, refresh controls, and buttons.
/// So we can later change those internal details without breaking the tests.
///
extension ListViewController {
	func errorMessage() -> String? {
		presentedAlertView()?.message
	}
	
	func hideError() {
		presenterVC.dismiss(animated: false, completion: nil)
	}
	
	private func presentedAlertView() -> UIAlertController? {
		presenterVC.presentedViewController as? UIAlertController
	}
	
	func isShowingLoadingIndicator() -> Bool {
		refreshControl?.isRefreshing == true
	}
	
	func simulateRefresh() {
		refreshControl?.sendActions(for: .valueChanged)
	}
	
	func numberOfRows(atSection section: Int) -> Int {
		tableView.numberOfSections > section ? tableView.numberOfRows(inSection: section) : 0
	}
	
	func cell(at indexPath: IndexPath) -> UITableViewCell? {
		guard numberOfRows(atSection: indexPath.section) > indexPath.row else { return nil }
		
		return tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath)
	}
	
	func title(at indexPath: IndexPath) -> String? {
		cell(at: indexPath)?.textLabel?.text
	}
	
	func subtitle(at indexPath: IndexPath) -> String? {
        cell(at: indexPath)?.detailTextLabel?.text?
            .replacingOccurrences(of: " ", with: " ")
	}
	
	func select(at indexPath: IndexPath) {
		tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
	}
    
    ///
    /// This test helper extension provides a fast and reliable way of
    /// triggering lifecycle events programmatically (viewDidLoad, viewWillAppear, and viewDidAppear)
    /// to ensure the view controller is ready for testing.
    ///
    /// It replaces the UIRefreshControl with a Spy to support testing on iOS17+.
    ///
    func prepareForFirstAppearance() {
        guard !isViewLoaded else { return }
        
        loadViewIfNeeded()
        replaceRefreshControlWithSpy()
        beginAppearanceTransition(true, animated: false)
        endAppearanceTransition()
    }
    
    private func replaceRefreshControlWithSpy() {
        let currentRefreshControl = refreshControl
        let spyRefreshControl = UIRefreshControlSpy()
        
        currentRefreshControl?.allTargets.forEach { target in
            currentRefreshControl?.actions(forTarget: target, forControlEvent: .valueChanged)?.forEach { action in
                spyRefreshControl.addTarget(target, action: Selector(action), for: .valueChanged)
            }
        }
        
        refreshControl = spyRefreshControl
    }
}

private class UIRefreshControlSpy: UIRefreshControl {
    private var _isRefreshing = false
    
    override var isRefreshing: Bool { _isRefreshing }
    
    override func beginRefreshing() {
        _isRefreshing = true
    }
    
    override func endRefreshing() {
        _isRefreshing = false
    }
}
