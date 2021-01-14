//
//  ViewController.swift
//  ARKit_1
//
//  Created by Vincent Alexander Christian on 24/10/20.
//

import UIKit
import SceneKit
import ARKit

class ARView: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var symbol = ""
    var elementCount = InitViewController.arrayOfElements.count
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        configureAR()
//        addLine(x: 0, y: 0, z: -1.5)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    @IBAction func backToHome(_ sender: Any) {
        InitViewController.arrayOfElements.removeAll()
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InitTab")
        sb.modalPresentationStyle = .fullScreen
        present(sb, animated: true, completion: nil)
    }
    
    @IBAction func addElement(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ARMode")
        sb.modalPresentationStyle = .fullScreen
        present(sb, animated: true, completion: nil)
    }
    
    @IBAction func toDesc(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ElementDesc") as! DescriptionViewController
        present(sb, animated: true, completion: nil)
    }
}

extension ARView {
    func configureAR() {
        if elementCount == 1 {
            symbol = InitViewController.arrayOfElements[elementCount-1].symbol
            addSphere(x: 0, y: 0, z: -1.5, symbol: symbol, color: UIColor.orange)
        }
        else if elementCount == 2 {
            symbol = InitViewController.arrayOfElements[0].symbol
            addSphere(x: -0.2, y: 0, z: -1.5, symbol: symbol, color: UIColor.orange)
            symbol = InitViewController.arrayOfElements[1].symbol
            addSphere(x: 0.2, y: 0, z: -1.5, symbol: symbol, color: UIColor.blue)
        }
        else if elementCount == 3 {
            symbol = InitViewController.arrayOfElements[0].symbol
            addSphere(x: 0, y: 0, z: -1.5, symbol: symbol, color: UIColor.orange)
            symbol = InitViewController.arrayOfElements[1].symbol
            addSphere(x: 0.25, y: -0.25, z: -1.5, symbol: symbol, color: UIColor.blue)
            symbol = InitViewController.arrayOfElements[2].symbol
            addSphere(x: -0.25, y: -0.25, z: -1.5, symbol: symbol, color: UIColor.red)
        }
        else if elementCount == 4 {
            symbol = InitViewController.arrayOfElements[0].symbol
            addSphere(x: 0, y: 0, z: -1.5, symbol: symbol, color: UIColor.orange)
            symbol = InitViewController.arrayOfElements[1].symbol
            addSphere(x: 0.25, y: -0.25, z: -1.5, symbol: symbol, color: UIColor.blue)
            symbol = InitViewController.arrayOfElements[2].symbol
            addSphere(x: -0.25, y: -0.25, z: -1.5, symbol: symbol, color: UIColor.red)
            symbol = InitViewController.arrayOfElements[3].symbol
            addSphere(x: -0.25, y: 0.25, z: -1.5, symbol: symbol, color: UIColor.yellow)
        }
        else if elementCount == 5 {
            symbol = InitViewController.arrayOfElements[0].symbol
            addSphere(x: 0, y: 0, z: -1.5, symbol: symbol, color: UIColor.orange)
            symbol = InitViewController.arrayOfElements[1].symbol
            addSphere(x: 0.25, y: -0.25, z: -1.5, symbol: symbol, color: UIColor.blue)
            symbol = InitViewController.arrayOfElements[2].symbol
            addSphere(x: -0.25, y: -0.25, z:-1.5, symbol: symbol, color: UIColor.red)
            symbol = InitViewController.arrayOfElements[3].symbol
            addSphere(x: -0.25, y: 0.25, z: -1.5, symbol: symbol, color: UIColor.yellow)
            symbol = InitViewController.arrayOfElements[4].symbol
            addSphere(x: 0.25, y: 0.25, z: -1.5, symbol: symbol, color: UIColor.green)
        }
    }
    
    func addSphere(x: CGFloat, y: CGFloat, z: CGFloat, symbol: String, color: UIColor) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        view.backgroundColor = color
        let label = UILabel(frame: CGRect(x: 0, y: 35, width: 200, height: 30))
        label.font = UIFont.systemFont(ofSize: 30)
        view.addSubview(label)
        label.textAlignment = .center
        label.text = symbol
        label.textColor = .white
        
        let sphere = SCNSphere(radius: 0.1)
        sphere.firstMaterial?.diffuse.contents = view
        
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3(x, y, z)
        sceneView.scene.rootNode.addChildNode(sphereNode)
    }
    
    func addLine(x: CGFloat, y: CGFloat, z: CGFloat) {
        let line = SCNCylinder(radius: 0.05, height: 0.2)
        line.firstMaterial?.diffuse.contents = UIColor.black
        
        let lineNode = SCNNode(geometry: line)
        lineNode.position = SCNVector3(x, y, z)
        
        sceneView.scene.rootNode.addChildNode(lineNode)
    }
}
