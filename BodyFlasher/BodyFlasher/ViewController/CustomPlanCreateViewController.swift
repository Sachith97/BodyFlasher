//
//  CustomPlanCreateViewController.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-20.
//

import UIKit
import AVKit

class CustomPlanCreateViewController: UIViewController {
    
    enum PlayState {
        case playing
        case stoped
    }

    private let goalData: [GoalData] = [
        GoalData(title: "Cardio", image: "cardio-img"),
        GoalData(title: "Shoulders", image: "shoulders-img"),
        GoalData(title: "Biceps", image: "biceps-img"),
        GoalData(title: "Chest", image: "chest-img"),
        GoalData(title: "Abs", image: "abs-img"),
        GoalData(title: "Forearms", image: "forearms-img"),
        GoalData(title: "Triceps", image: "triceps-img"),
        GoalData(title: "Lower Back", image: "lowerback-img"),
        GoalData(title: "Quads", image: "quads-img"),
        GoalData(title: "Calves", image: "calves-img")
    ]
    
    private let exerciseData: [ExerciseData] = [
        ExerciseData(title: "Eliptical Trainer", image: "eliptical-img", info: "Pedal forward while alternating the arm levers back and fourth.", allocatedSeconds: 600, goal: "Cardio"),
        ExerciseData(title: "Stationary Bike", image: "stationary-img", info: "Sit in the seat with your back in full contact with the back rest. Place your feet on the padels. Begin pedalling as you would on a bicycle.", allocatedSeconds: 300, goal: "Cardio"),
        ExerciseData(title: "Rope Jumping", image: "ropejumping-img", info: "instr 3", allocatedSeconds: 150, goal: "Cardio"),
        ExerciseData(title: "Walking", image: "walking-img", info: "instr 4", allocatedSeconds: 600, goal: "Cardio"),
        ExerciseData(title: "Running", image: "running-img", info: "instr 5", allocatedSeconds: 600, goal: "Cardio"),
        ExerciseData(title: "Stationary Rowing", image: "rowing-img", info: "instr 6", allocatedSeconds: 300, goal: "Cardio"),
        ExerciseData(title: "Step Mill", image: "stepmill-img", info: "instr 7", allocatedSeconds: 600, goal: "Cardio")
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
    
    let customPlanCreateRequestContainer: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        uiView.layer.cornerRadius = 10
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    let requestTitleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name:"AppleSDGothicNeo-Regular", size: 17.0)
        label.text = "Select your goal to check available workout list"
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let playerContainer: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    let pauseButton: UIButton = {
        let button = UIButton()
        button.setTitle("PAUSE", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 14.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(pauseOrResumeVideo), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let replayButton: UIButton = {
        let button = UIButton()
        button.setTitle("REPLAY", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 14.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(replayVideo), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let instructionContainer: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    let goalView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.text = "sample instruction"
        label.font = UIFont(name:"AppleSDGothicNeo-Regular", size: 17.0)
        label.backgroundColor = UIColor.clear
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let goalTagLabel: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 15.0)
        button.backgroundColor = UIColor(named: "dark-green")
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let timeStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = UIColor.clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let incrementButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 17.0)
        button.backgroundColor = UIColor(named: "dark-yellow")
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(incrementTime), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    let decrementButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 17.0)
        button.backgroundColor = UIColor(named: "dark-yellow")
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(decrementTime), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.text = "0 Sec"
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 20.0)
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let startInstantButton : UIButton = {
        let button = UIButton()
        button.setTitle("START INSTANT WORKOUT", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 14.0)
        button.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(startInstantWorkout), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let addToListButton : UIButton = {
        let button = UIButton()
        button.setTitle("ADD TO CUSTOM LIST", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 14.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(addToCustomeList), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var goalListView: UICollectionView!
    
    var exerciseListView: UICollectionView!
    
    var avPlayer: AVPlayer?
    var avPlayerLayer: AVPlayerLayer?
    var playState: PlayState = .playing
    
    var authDetail: LoginResponseDetail = LoginResponseDetail()
    var headerText: String = ""
    
    var selectedGoalData: GoalData!
    var selectedExerciseData: ExerciseData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Customize the appearance of the navigation bar's title
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)
        ]
        title = headerText
        
        // set background image
        self.view.insertSubview(backgroundView, at: 0)
        
        let layout = GridViewFlowLayout(width: 115, height: 230)
        goalListView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        goalListView.backgroundColor = UIColor.clear
        goalListView.dataSource = self
        goalListView.delegate = self
        goalListView.tag = 1
        goalListView.register(GridViewCell.self, forCellWithReuseIdentifier: "GridCell")
        goalListView.translatesAutoresizingMaskIntoConstraints = false
        
//        customPlanCreateRequestContainer.addSubview(goalListView)
        
        self.view.addSubview(requestTitleLabel)
        self.view.addSubview(goalListView)
        
        setupConstraints()
    }
    
    func proceedGoal(selectedGoal: GoalData) {
        self.selectedGoalData = selectedGoal
        
        // change nav bar back button
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-icon"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(goBackToGoalSelection))
        
        // update view title
        title = selectedGoal.title.uppercased()
        
        // remove elements from super view
        requestTitleLabel.removeFromSuperview()
        goalListView.removeFromSuperview()
        
        let layout = GridViewFlowLayout(width: 180, height: 210)
        exerciseListView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        exerciseListView.backgroundColor = UIColor.clear
        exerciseListView.dataSource = self
        exerciseListView.delegate = self
        exerciseListView.tag = 2
        exerciseListView.register(GridViewCell.self, forCellWithReuseIdentifier: "GridCell")
        exerciseListView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(exerciseListView)
        setupExerciseListConstraints()
    }
    
    @objc func goBackToGoalSelection() {
        // reset back button
        navigationItem.leftBarButtonItem = nil
        
        title = headerText
        
        // remove elements from super view
        exerciseListView.removeFromSuperview()
        
        self.view.addSubview(requestTitleLabel)
        self.view.addSubview(goalListView)
        setupConstraints()
    }
    
    func proceedExercise(selectedExercise: ExerciseData) {
        self.selectedExerciseData = selectedExercise
        
        // change nav bar back button
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-icon"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(goBackToExerciseSelection))
        
        // update view title
        title = selectedExercise.title.uppercased()
        
        // remove elements from super view
        exerciseListView.removeFromSuperview()
        
        // exercise video url
        guard let videoURL = URL(string: "https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4") else {
            return
        }
        avPlayer = AVPlayer(url: videoURL)
        
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer?.frame = CGRect(x: 0, y: 0, width: Int(view.bounds.width), height: 200)
        
        if let avPlayerLayer = avPlayerLayer {
            playerContainer.layer.addSublayer(avPlayerLayer)
        }
        // start play
        avPlayer?.play()
        
        goalView.image = UIImage(named: selectedGoalData.image)
        instructionLabel.text = selectedExercise.info
        goalTagLabel.setTitle(selectedGoalData.title, for: .normal)
        instructionContainer.addSubview(goalView)
        instructionContainer.addSubview(instructionLabel)
        instructionContainer.addSubview(goalTagLabel)
        
        timeLabel.text = calculateTime(seconds: selectedExercise.allocatedSeconds)
        timeStack.addArrangedSubview(decrementButton)
        timeStack.addArrangedSubview(timeLabel)
        timeStack.addArrangedSubview(incrementButton)
        
        self.view.addSubview(playerContainer)
        self.view.addSubview(pauseButton)
        self.view.addSubview(replayButton)
        self.view.addSubview(instructionContainer)
        self.view.addSubview(timeStack)
        self.view.addSubview(startInstantButton)
        self.view.addSubview(addToListButton)
        
        setupExerciseInfoConstraints()
    }
    
    @objc func pauseOrResumeVideo() {
        switch playState {
        case .playing:
            avPlayer?.pause()
            self.pauseButton.setTitle("PLAY", for: .normal)
            self.playState = PlayState.stoped
        case .stoped:
            avPlayer?.play()
            self.pauseButton.setTitle("PAUSE", for: .normal)
            self.playState = PlayState.playing
        }
    }
    
    @objc func replayVideo() {
        avPlayer?.pause()
        avPlayer?.seek(to: CMTime.zero)
        avPlayer?.play()
    }
    
    func calculateTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(minutes) + " Mins " + String(seconds) + " Secs"
    }
    
    @objc func incrementTime() {
        if ((selectedExerciseData.allocatedSeconds + 30) != 3600) {
            selectedExerciseData.allocatedSeconds = selectedExerciseData.allocatedSeconds + 30
            timeLabel.text = calculateTime(seconds: selectedExerciseData.allocatedSeconds)
        }
    }
    
    @objc func decrementTime() {
        if ((selectedExerciseData.allocatedSeconds - 30) != 0) {
            selectedExerciseData.allocatedSeconds = selectedExerciseData.allocatedSeconds - 30
            timeLabel.text = calculateTime(seconds: selectedExerciseData.allocatedSeconds)
        }
    }
    
    @objc func startInstantWorkout() {
        // stop player from playing background
        avPlayer?.pause()
        self.pauseButton.setTitle("PLAY", for: .normal)
        self.playState = PlayState.stoped
        
        let workoutVC = WorkoutViewController()
        workoutVC.authDetail = self.authDetail
        workoutVC.exerciseData = self.selectedExerciseData
        self.navigationController?.pushViewController(workoutVC, animated: true)
    }
    
    @objc func addToCustomeList() {
        let alert = UIAlertController(title: nil, message: "Successful", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { _ in
            self.goBackToExerciseSelection()
            self.goBackToGoalSelection()
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func goBackToExerciseSelection() {
        // change nav bar back button
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-icon"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(goBackToGoalSelection))
        
        title = selectedGoalData.title.uppercased()
        
        // remove elements from super view
        avPlayer?.pause()
        avPlayerLayer?.player = nil
        avPlayerLayer?.removeFromSuperlayer()
        pauseButton.removeFromSuperview()
        replayButton.removeFromSuperview()
        instructionContainer.removeFromSuperview()
        timeStack.removeFromSuperview()
        startInstantButton.removeFromSuperview()
        addToListButton.removeFromSuperview()
        
        self.view.addSubview(exerciseListView)
        setupExerciseListConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            requestTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            requestTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            requestTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            goalListView.topAnchor.constraint(equalTo: requestTitleLabel.bottomAnchor, constant: 10),
            goalListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            goalListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            goalListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func setupExerciseListConstraints() {
        NSLayoutConstraint.activate([
            exerciseListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            exerciseListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            exerciseListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            exerciseListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func setupExerciseInfoConstraints() {
        NSLayoutConstraint.activate([
            playerContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            playerContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            playerContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            playerContainer.heightAnchor.constraint(equalToConstant: 200),
            
            pauseButton.topAnchor.constraint(equalTo: playerContainer.bottomAnchor, constant: 20),
            pauseButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            pauseButton.widthAnchor.constraint(equalToConstant: 100),
            
            replayButton.topAnchor.constraint(equalTo: playerContainer.bottomAnchor, constant: 20),
            replayButton.leadingAnchor.constraint(equalTo: pauseButton.trailingAnchor, constant: 10),
            replayButton.widthAnchor.constraint(equalToConstant: 100),
            
            goalView.topAnchor.constraint(equalTo: instructionContainer.topAnchor),
            goalView.leadingAnchor.constraint(equalTo: instructionContainer.leadingAnchor),
            goalView.heightAnchor.constraint(equalToConstant: 170),
            goalView.widthAnchor.constraint(equalToConstant: 100),
            
            instructionLabel.topAnchor.constraint(equalTo: instructionContainer.topAnchor),
            instructionLabel.leadingAnchor.constraint(equalTo: goalView.trailingAnchor, constant: 20),
            instructionLabel.trailingAnchor.constraint(equalTo: instructionContainer.trailingAnchor),
            
            goalTagLabel.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 20),
            goalTagLabel.leadingAnchor.constraint(equalTo: goalView.trailingAnchor, constant: 20),
            goalTagLabel.widthAnchor.constraint(equalToConstant: 100),
            
            instructionContainer.topAnchor.constraint(equalTo: pauseButton.bottomAnchor, constant: 40),
            instructionContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            instructionContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            decrementButton.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -15),
            
            timeLabel.trailingAnchor.constraint(equalTo: incrementButton.leadingAnchor, constant: -15),
            
            timeStack.topAnchor.constraint(equalTo: goalView.bottomAnchor, constant: 30),
            timeStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            startInstantButton.bottomAnchor.constraint(equalTo: addToListButton.topAnchor, constant: -10),
            startInstantButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            startInstantButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            startInstantButton.heightAnchor.constraint(equalToConstant: 40),
            
            addToListButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addToListButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            addToListButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addToListButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension CustomPlanCreateViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return goalData.count
        case 2:
            return exerciseData.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as! GridViewCell
        
        if (collectionView.tag == 1) {
            let data = goalData[indexPath.item]
            cell.titleLabel.text = data.title
            cell.imageView.image = UIImage(named: goalData[indexPath.row].image)
            
        } else if (collectionView.tag == 2){
            let data = exerciseData[indexPath.item]
            cell.titleLabel.text = data.title
            cell.imageView.image = UIImage(named: exerciseData[indexPath.row].image)
        }
        
        return cell
    }
}

extension CustomPlanCreateViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (collectionView.tag == 1) {
            proceedGoal(selectedGoal: goalData[indexPath.item])
            
        } else if (collectionView.tag == 2){
            proceedExercise(selectedExercise: exerciseData[indexPath.item])
        }
    }
}
