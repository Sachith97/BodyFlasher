//
//  WorkoutViewController.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-21.
//

import UIKit

class WorkoutViewController: UIViewController {

    enum TimerState {
        case started
        case paused
    }
    
    var authDetail: LoginResponseDetail = LoginResponseDetail()
    var exerciseData: ExerciseData!
    
    var timer: Timer?
    var remainingTime: TimeInterval!
    let impactFeedBackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    var timerstate: TimerState = .paused
    
    let backgroundView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "home-background")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.4
        imageView.applyBlurEffect()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let workoutNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 23.0)
        label.backgroundColor = UIColor.clear
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name:"AppleSDGothicNeo-Regular", size: 18.0)
        label.backgroundColor = UIColor.clear
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name:"Copperplate-Bold", size: 35.0)
        label.text = "00:00:00"
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timerCircle: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.strokeColor = UIColor(named: "dark-red")?.cgColor
        shape.lineWidth = 10
        shape.fillColor = UIColor.clear.cgColor
        shape.lineCap = .round
        return shape
    }()
    
    let startPauseButton: UIButton = {
        let button = UIButton()
        button.setTitle("START", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 14.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(startPauseTimer), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("RESET", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 14.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let decisionButtonStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = UIColor.clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // update view title
        title = "WORKOUT"
        
        // prepare impact generator
        impactFeedBackGenerator.prepare()
        
        // set background image
        self.view.insertSubview(backgroundView, at: 0)
        
        workoutNameLabel.text = exerciseData.title
        instructionLabel.text = exerciseData.info
        
        self.remainingTime = TimeInterval(exerciseData.allocatedSeconds)
        updateTimerLabel()
        createCircularTimer()
        
        decisionButtonStack.addArrangedSubview(startPauseButton)
        decisionButtonStack.addArrangedSubview(resetButton)
        
        self.view.addSubview(workoutNameLabel)
        self.view.addSubview(instructionLabel)
        self.view.addSubview(timerLabel)
        self.view.layer.addSublayer(timerCircle)
        self.view.addSubview(decisionButtonStack)
        
        setupConstraints()
    }
    
    @objc func startPauseTimer() {
        switch timerstate {
        case .started:
            // pause timer
            timer?.invalidate()
            self.startPauseButton.setTitle("START", for: .normal)
            timerstate = .paused
        case .paused:
            // start or resume timer
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            self.startPauseButton.setTitle("PAUSE", for: .normal)
            timerstate = .started
        }
    }
    
    @objc func resetTimer() {
        // pause timer
        timer?.invalidate()
        self.startPauseButton.setTitle("START", for: .normal)
        timerstate = .paused
        
        remainingTime = TimeInterval(self.exerciseData.allocatedSeconds)
        updateTimerLabel()
        updateCircularPath(reset: true)
    }
    
    func formatTime(_ timeInterval: TimeInterval) -> String {
        let hours = Int(timeInterval / 3600)
        let minutes = Int((timeInterval.truncatingRemainder(dividingBy: 3600)) / 60)
        let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    @objc func updateTimer() {
        remainingTime -= 1
        if (remainingTime <= 0) {
            timer?.invalidate()
            // create a vibration
            impactFeedBackGenerator.impactOccurred()
        }
        updateTimerLabel()
        updateCircularPath(reset: false)
    }
    
    func updateTimerLabel() {
        timerLabel.text = formatTime(remainingTime)
    }
    
    func createCircularTimer() {
        let radius = min(view.bounds.width, view.bounds.height) / 2 - 70
        let circularPath = UIBezierPath(arcCenter: view.center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        timerCircle.path = circularPath.cgPath
        timerCircle.strokeEnd = 1
    }
    
    func updateCircularPath(reset: Bool) {
        let progress = CGFloat(remainingTime) / CGFloat(self.exerciseData.allocatedSeconds)
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(1.0)
        
        timerCircle.strokeEnd = reset ? 1 : progress.truncatingRemainder(dividingBy: 1.0)
        
        CATransaction.commit()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            workoutNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            workoutNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            workoutNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            instructionLabel.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: 10),
            instructionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            instructionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            timerLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -30),
            
            startPauseButton.trailingAnchor.constraint(equalTo: resetButton.leadingAnchor, constant: -10),
            startPauseButton.widthAnchor.constraint(equalToConstant: 80),
            startPauseButton.heightAnchor.constraint(equalToConstant: 40),
            
            resetButton.widthAnchor.constraint(equalToConstant: 80),
            resetButton.heightAnchor.constraint(equalToConstant: 40),
            
            decisionButtonStack.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 140),
            decisionButtonStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            
        ])
    }

}
