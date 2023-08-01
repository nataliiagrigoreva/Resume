//
//  ResumeViewController.swift
//  Testovoe
//
//  Created by Nataly on 01.08.2023.
//

import UIKit

class ResumeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let maxSkillsRowCount = 5
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profile_image"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Григорьева\nНаталия Сергеевна"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let professionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.text = "iOS разработчик"
        label.textColor = .gray
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "г.Санкт-Петербург"
        label.textColor = .gray
        return label
    }()
    
    let skillsHeaderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Мои навыки"
        return label
    }()
    
    let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "edit_icon"), for: .normal)
        return button
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "edit_icon"), for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "save_icon"), for: .normal)
        return button
    }()
    
    let aboutMeTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.text = "Как iOS разработчик, у меня есть опыт работы со Swift, в Xcode, UIKit, SwiftUI и Core Data, WidgetKit, Push notifications, SQL. Моя страсть к разработке мобильных приложений побуждает меня постоянно совершенствовать свои технические навыки и делать карьеру в индустрии технологий. У меня есть опыт работы в командной среде, которая придерживается принципов методологии Agile, и я горю желанием сотрудничать с другими разработчиками и командами для создания уникальных и инновационных мобильных приложений для платформы iOS. Я стремлюсь использовать свой опыт и знания, чтобы приносить пользу компании и помогать достигать целей в разработке мобильных приложений.ь"
        return textView
    }()
    
    var skills: [String] = ["iOS Development", "Swift", "Objective-C", "Xcode"]
    var isEditingSkills: Bool = false {
            didSet {
                skillsCollectionView.reloadData()
                updateButtonVisibility()
            }
        }

    let skillsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let skillsContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupUI()
        setupCollectionView()
        setupButtons()
   
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)

        skillsCollectionView.register(SkillsCollectionViewCell.self, forCellWithReuseIdentifier: SkillsCollectionViewCell.identifier)
        skillsCollectionView.register(AddSkillCollectionViewCell.self, forCellWithReuseIdentifier: "AddSkillCell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
    }
    
    private func setupNavigationBar() {
        // Создаем и настраиваем навигационный бар
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = .white
        
        // Создаем экземпляр UINavigationItem и устанавливаем заголовок
        let navigationItem = UINavigationItem(title: "Профиль")
        
        // Устанавливаем экземпляр UINavigationItem для навигационного бара
        navigationBar.items = [navigationItem]
        
        // Добавляем навигационный бар на экран
        view.addSubview(navigationBar)
        
        // Устанавливаем ограничения для навигационного бара
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupUI() {
        // Добавляем элементы на экран
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(professionLabel)
        view.addSubview(locationLabel)
        view.addSubview(skillsHeaderLabel)
        view.addSubview(editButton)
        view.addSubview(saveButton)
        view.addSubview(skillsCollectionView)
        view.addSubview(aboutMeTextView)
        view.addSubview(skillsContainerView)
        
        skillsContainerView.addSubview(skillsCollectionView)
        aboutMeTextView.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавляем ограничения для элементов интерфейса
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 64),
            profileImageView.widthAnchor.constraint(equalToConstant: 150),
            profileImageView.heightAnchor.constraint(equalToConstant: 150),
            
            nameLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            nameLabel.widthAnchor.constraint(equalToConstant: 240),
            nameLabel.heightAnchor.constraint(equalToConstant: 70),
            
            professionLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            professionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            
            locationLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            locationLabel.topAnchor.constraint(equalTo: professionLabel.bottomAnchor, constant: 4),
            
            skillsHeaderLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            skillsHeaderLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16),
            
            editButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            editButton.centerYAnchor.constraint(equalTo: skillsHeaderLabel.centerYAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 30),
            editButton.heightAnchor.constraint(equalToConstant: 30),
            
            saveButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            saveButton.centerYAnchor.constraint(equalTo: skillsHeaderLabel.centerYAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 30),
            saveButton.heightAnchor.constraint(equalToConstant: 30),
            
            skillsContainerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            skillsContainerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            skillsContainerView.topAnchor.constraint(equalTo: skillsHeaderLabel.bottomAnchor, constant: 16),
            skillsContainerView.bottomAnchor.constraint(lessThanOrEqualTo: aboutMeTextView.topAnchor, constant: -16),
            
            skillsCollectionView.leadingAnchor.constraint(equalTo: skillsContainerView.leadingAnchor),
            skillsCollectionView.trailingAnchor.constraint(equalTo: skillsContainerView.trailingAnchor),
            skillsCollectionView.topAnchor.constraint(equalTo: skillsContainerView.topAnchor),
            skillsCollectionView.bottomAnchor.constraint(equalTo: skillsContainerView.bottomAnchor),
   
            aboutMeTextView.topAnchor.constraint(equalTo: skillsCollectionView.bottomAnchor, constant: 16),
                        aboutMeTextView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16),
            
                        skillsCollectionView.heightAnchor.constraint(equalToConstant: calculateSkillsCollectionViewHeight()),
                    ])
    }
    
    private func calculateSkillsCollectionViewHeight() -> CGFloat {
            let numberOfRows = ceil(CGFloat(skills.count) / CGFloat(maxSkillsRowCount))
            let cellHeight: CGFloat = 30
            let interItemSpacing: CGFloat = 8
            return (cellHeight * numberOfRows) + (interItemSpacing * (numberOfRows - 1))
        }
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        skillsCollectionView.collectionViewLayout = layout
        skillsCollectionView.delegate = self
        skillsCollectionView.dataSource = self
    }
    
    // MARK: - Button Actions
    
    @objc private func editButtonTapped() {
        updateButtonVisibility()
        skillsCollectionView.reloadData()
    }
    
    @objc private func saveButtonTapped() {
        showAddSkillAlert()
    }
    
    @objc private func addButtonTapped() {
        showAddSkillAlert()
    }
    
    @objc private func deleteSkill(_ sender: UIButton) {
        let index = sender.tag
        showDeleteConfirmationAlert(at: index)
    }
    
    // MARK: - Add Skill Alert
    
    private func showAddSkillAlert() {
        let alert = UIAlertController(title: "Добавление навыка", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Введите название навыка"
        }
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { [weak self] _ in
            if let skill = alert.textFields?.first?.text, !skill.isEmpty {
                self?.skills.append(skill)
                self?.skillsCollectionView.reloadData()
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func showDeleteConfirmationAlert(at index: Int) {
        let skill = skills[index]
        let alert = UIAlertController(title: "Удаление навыка", message: "Вы уверены, что хотите удалить навык \"\(skill)\"?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { [weak self] _ in
            self?.skills.remove(at: index)
            self?.skillsCollectionView.reloadData()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Private Methods
    
    private func setupButtons() {
        let editButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItems = [editButtonItem, addButton, saveButton]
    }
    
    private func updateButtonVisibility() {
        editButton.isHidden = isEditingSkills
        saveButton.isHidden = !isEditingSkills
        navigationItem.rightBarButtonItem?.isEnabled = !isEditingSkills
    }
    
    // MARK: - Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return isEditingSkills ? skills.count : skills.count + 1
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isEditingSkills && indexPath.item < skills.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SkillsCollectionViewCell.identifier, for: indexPath) as! SkillsCollectionViewCell
            let skill = skills[indexPath.item]
            cell.skillLabel.text = skill
            cell.deleteButton.isHidden = false
            cell.deleteButton.tag = indexPath.item
            cell.deleteButton.addTarget(self, action: #selector(deleteSkill(_:)), for: .touchUpInside)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddSkillCell", for: indexPath) as! AddSkillCollectionViewCell
            cell.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
            return cell
        }
    }
    
    // MARK: - Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEditingSkills {
            showDeleteConfirmationAlert(at: indexPath.item)
        }
    }
    
    // MARK: - Collection View Flow Layout Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isEditingSkills && indexPath.item < skills.count {
            let numberOfItemsInRow = 3
            let padding: CGFloat = 8
            let availableWidth = collectionView.bounds.width - padding * CGFloat((numberOfItemsInRow + 1))
            let itemWidth = availableWidth / CGFloat(numberOfItemsInRow)
            return CGSize(width: itemWidth, height: 30)
        } else {
            return CGSize(width: collectionView.bounds.width, height: 44)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerHeight: CGFloat = 40
        let rowCount = min(ceil(CGFloat(skills.count) / CGFloat(maxSkillsRowCount)), CGFloat(maxSkillsRowCount))
        let totalHeight = headerHeight + (rowCount * 30) + (rowCount - 1) * 8
        return CGSize(width: collectionView.bounds.width, height: totalHeight)
    }
}

