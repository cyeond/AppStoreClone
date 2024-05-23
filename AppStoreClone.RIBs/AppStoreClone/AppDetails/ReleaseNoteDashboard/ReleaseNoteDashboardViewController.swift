//
//  ReleaseNoteDashboardViewController.swift
//  AppStoreClone
//
//  Created by YD on 5/22/24.
//

import RIBs
import RxSwift
import UIKit

protocol ReleaseNoteDashboardPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class ReleaseNoteDashboardViewController: UIViewController, ReleaseNoteDashboardPresentable, ReleaseNoteDashboardViewControllable {
    weak var listener: ReleaseNoteDashboardPresentableListener?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20.0, weight: .semibold)
        label.textColor = .text
        label.textAlignment = .left
        return label
    }()
    
    private let versionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        return stackView
    }()
    
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15.0)
        label.textColor = .systemGray
        label.textAlignment = .left
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15.0)
        label.textColor = .systemGray
        label.textAlignment = .right
        return label
    }()
    
    private let releaseNoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15.0)
        label.textColor = .text
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(versionStackView)
        view.addSubview(releaseNoteLabel)
        
        versionStackView.addArrangedSubview(versionLabel)
        versionStackView.addArrangedSubview(dateLabel)
    }
    
    private func setLayoutConstraint() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10.0),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            titleLabel.heightAnchor.constraint(equalToConstant: 30.0),
            
            versionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            versionStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            versionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            versionStackView.heightAnchor.constraint(equalToConstant: 20.0),
            
            releaseNoteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            releaseNoteLabel.topAnchor.constraint(equalTo: versionStackView.bottomAnchor, constant: 10.0),
            releaseNoteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            releaseNoteLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10.0),
        ])
    }
    
    func update(with info: AppInfo) {
        titleLabel.text = "새로운 소식"
        versionLabel.text = "버전 " + info.version
        dateLabel.text = info.releaseDate.timePassed() ?? info.releaseDate
        releaseNoteLabel.text = info.releaseNote
        
        setLayoutConstraint()
    }
}
