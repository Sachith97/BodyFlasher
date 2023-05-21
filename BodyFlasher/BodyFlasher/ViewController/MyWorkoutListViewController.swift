//
//  MyWorkoutListViewController.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-21.
//

import UIKit

class MyWorkoutListViewController: UIViewController {
    
    var authDetail: LoginResponseDetail = LoginResponseDetail()
    var headerText: String = ""
    
    private let instructExerciseData: [ExerciseData] = [
        ExerciseData(title: "Eliptical Trainer", image: "eliptical-img", info: "instr 1", allocatedSeconds: 150, goal: "Cardio"),
        ExerciseData(title: "Stationary Bike", image: "stationary-img", info: "instr 2", allocatedSeconds: 150, goal: "Cardio"),
        ExerciseData(title: "Rope Jumping", image: "ropejumping-img", info: "instr 3", allocatedSeconds: 150, goal: "Cardio"),
        ExerciseData(title: "Walking", image: "walking-img", info: "instr 4", allocatedSeconds: 150, goal: "Cardio"),
        ExerciseData(title: "Running", image: "running-img", info: "instr 5", allocatedSeconds: 150, goal: "Cardio"),
        ExerciseData(title: "Stationary Rowing", image: "rowing-img", info: "instr 6", allocatedSeconds: 150, goal: "Cardio"),
        ExerciseData(title: "Step Mill", image: "stepmill-img", info: "instr 7", allocatedSeconds: 150, goal: "Cardio"),
    ]
    
    private let customExerciseData: [ExerciseData] = [
        ExerciseData(title: "Eliptical Trainer", image: "eliptical-img", info: "instr 1", allocatedSeconds: 150, goal: "Cardio"),
        ExerciseData(title: "Stationary Bike", image: "stationary-img", info: "instr 2", allocatedSeconds: 150, goal: "Cardio"),
        ExerciseData(title: "Rope Jumping", image: "ropejumping-img", info: "instr 3", allocatedSeconds: 150, goal: "Cardio"),
        ExerciseData(title: "Walking", image: "walking-img", info: "instr 4", allocatedSeconds: 150, goal: "Cardio"),
        ExerciseData(title: "Running", image: "running-img", info: "instr 5", allocatedSeconds: 150, goal: "Cardio"),
        ExerciseData(title: "Stationary Rowing", image: "rowing-img", info: "instr 6", allocatedSeconds: 150, goal: "Cardio"),
        ExerciseData(title: "Step Mill", image: "stepmill-img", info: "instr 7", allocatedSeconds: 150, goal: "Cardio"),
    ]
    
    let backgroundView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "home-background")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.4
        imageView.applyBlurEffect()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let instructTabContainer: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    let customTabContainer: UIView = {
        let uiView = UIView()
        uiView.isHidden = true
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    let instructToggleButton: UIButton = {
        let button = UIButton()
        button.setTitle("INSTRUCT", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 13.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 3
        button.addTarget(self, action: #selector(viewInstructContainer), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let customToggleButton: UIButton = {
        let button = UIButton()
        button.setTitle("CUSTOM", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 13.0)
        button.backgroundColor = UIColor(named: "semi-dark")
        button.layer.cornerRadius = 3
        button.addTarget(self, action: #selector(viewCustomContainer), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let toggleButtonContainer: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    let instructExerciseTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let customExerciseTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Customize the appearance of the navigation bar's title
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)
        ]
        title = headerText
        
        // set background image
        self.view.insertSubview(backgroundView, at: 0)
        
        toggleButtonContainer.addSubview(instructToggleButton)
        toggleButtonContainer.addSubview(customToggleButton)
        
        instructExerciseTableView.dataSource = self
        instructExerciseTableView.delegate = self
        instructExerciseTableView.register(WorkoutTableViewCell.self, forCellReuseIdentifier: "WorkoutTableViewCell")
        instructExerciseTableView.tag = 1
        
        customExerciseTableView.dataSource = self
        customExerciseTableView.delegate = self
        customExerciseTableView.register(WorkoutTableViewCell.self, forCellReuseIdentifier: "WorkoutTableViewCell")
        customExerciseTableView.tag = 2
        
        instructTabContainer.addSubview(instructExerciseTableView)
        customTabContainer.addSubview(customExerciseTableView)
        
        self.view.addSubview(toggleButtonContainer)
        self.view.addSubview(instructTabContainer)
        self.view.addSubview(customTabContainer)
        
        setupConstraints()
    }
    
    @objc func viewInstructContainer() {
        // view visibility
        instructTabContainer.isHidden = false
        customTabContainer.isHidden = true
        // toggle button appearance
        instructToggleButton.setTitleColor(UIColor.white, for: .normal)
        instructToggleButton.backgroundColor = UIColor(named: "dark-red")
        customToggleButton.setTitleColor(UIColor.gray, for: .normal)
        customToggleButton.backgroundColor = UIColor(named: "semi-dark")
    }
    
    @objc func viewCustomContainer() {
        // view visibility
        instructTabContainer.isHidden = true
        customTabContainer.isHidden = false
        // toggle button appearance
        instructToggleButton.setTitleColor(UIColor.gray, for: .normal)
        instructToggleButton.backgroundColor = UIColor(named: "semi-dark")
        customToggleButton.setTitleColor(UIColor.white, for: .normal)
        customToggleButton.backgroundColor = UIColor(named: "dark-red")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            instructToggleButton.topAnchor.constraint(equalTo: toggleButtonContainer.topAnchor),
            instructToggleButton.widthAnchor.constraint(equalToConstant: 100),
            instructToggleButton.heightAnchor.constraint(equalToConstant: 30),
            
            customToggleButton.topAnchor.constraint(equalTo: toggleButtonContainer.topAnchor),
            customToggleButton.leadingAnchor.constraint(equalTo: instructToggleButton.trailingAnchor, constant: 1),
            customToggleButton.widthAnchor.constraint(equalToConstant: 100),
            customToggleButton.heightAnchor.constraint(equalToConstant: 30),
            
            toggleButtonContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            toggleButtonContainer.widthAnchor.constraint(equalToConstant: 200),
            toggleButtonContainer.heightAnchor.constraint(equalToConstant: 30),
            toggleButtonContainer.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            instructExerciseTableView.topAnchor.constraint(equalTo: instructTabContainer.topAnchor),
            instructExerciseTableView.bottomAnchor.constraint(equalTo: instructTabContainer.bottomAnchor),
            instructExerciseTableView.leadingAnchor.constraint(equalTo: instructTabContainer.leadingAnchor),
            instructExerciseTableView.trailingAnchor.constraint(equalTo: instructTabContainer.trailingAnchor),
            
            instructTabContainer.topAnchor.constraint(equalTo: toggleButtonContainer.bottomAnchor, constant: 20),
            instructTabContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            instructTabContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            instructTabContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            customExerciseTableView.topAnchor.constraint(equalTo: customTabContainer.topAnchor),
            customExerciseTableView.bottomAnchor.constraint(equalTo: customTabContainer.bottomAnchor),
            customExerciseTableView.leadingAnchor.constraint(equalTo: customTabContainer.leadingAnchor),
            customExerciseTableView.trailingAnchor.constraint(equalTo: customTabContainer.trailingAnchor),
            
            customTabContainer.topAnchor.constraint(equalTo: toggleButtonContainer.bottomAnchor, constant: 20),
            customTabContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            customTabContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            customTabContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

extension MyWorkoutListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var exerciseData: ExerciseData?
        
        switch tableView.tag {
        case 1:
            exerciseData = instructExerciseData[indexPath.row]
        case 2:
            exerciseData = customExerciseData[indexPath.row]
        default:
            break
        }
        
        let workoutVC = WorkoutViewController()
        workoutVC.authDetail = self.authDetail
        workoutVC.exerciseData = exerciseData
        self.navigationController?.pushViewController(workoutVC, animated: true)
    }
}

extension MyWorkoutListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 1:
            return instructExerciseData.count
        case 2:
            return customExerciseData.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: WorkoutTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WorkoutTableViewCell")! as! WorkoutTableViewCell
        
        switch tableView.tag {
        case 1:
            cell.workoutImage.image = UIImage(named: instructExerciseData[indexPath.row].image)
            cell.workoutNameLabel.text = instructExerciseData[indexPath.row].title
            cell.workoutTimeLabel.text = calculateTime(seconds: instructExerciseData[indexPath.row].allocatedSeconds)
            cell.goalTagLabel.setTitle(instructExerciseData[indexPath.row].goal, for: .normal)
            
        case 2:
            cell.workoutImage.image = UIImage(named: customExerciseData[indexPath.row].image)
            cell.workoutNameLabel.text = customExerciseData[indexPath.row].title
            cell.workoutTimeLabel.text = calculateTime(seconds: customExerciseData[indexPath.row].allocatedSeconds)
            cell.goalTagLabel.setTitle(customExerciseData[indexPath.row].goal, for: .normal)
            
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(130)
    }
    
    func calculateTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(minutes) + " Mins " + String(seconds) + " Secs"
    }
}
