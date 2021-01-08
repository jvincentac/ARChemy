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
    
    var text: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        addSphere(x: 0, y: 0, z: -1)
        addText(text: text)
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
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home") as! Home
        sb.modalPresentationStyle = .fullScreen
        present(sb, animated: true, completion: nil)
    }
    
    @IBAction func addElement(_ sender: Any) {
        addSphere(x: 10, y: -10, z: -1)
        addSphere(x: -10, y: -10, z: -1)
    }
    @IBAction func toDesc(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ElementDesc") as! DescriptionViewController
        present(sb, animated: true, completion: nil)
    }
}

extension ARView {
    func addText(text: String) {
        let text = SCNText(string: "\(text)", extrusionDepth: 1.0)
        text.firstMaterial?.diffuse.contents = UIColor.black
        
        let textNode = SCNNode(geometry: text)
        textNode.position = SCNVector3(0.2, 0, -1)
        textNode.scale = SCNVector3(0.005, 0.005, 0.005)
        
        sceneView.scene.rootNode.addChildNode(textNode)
    }
    
    func addBox() {
        //ini kerangkanya, kyk tulang di badan
        let box = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)

        //ini material yang dipasang ke tulangnya
        let material = SCNMaterial()
        material.name = "Color"
        material.diffuse.contents = UIColor.cyan
        box.materials = [material]

        let boxNode = SCNNode(geometry: box)
        boxNode.position = SCNVector3(0, 0, -1)
        boxNode.name = "box"
        
        sceneView.scene.rootNode.addChildNode(boxNode)
    }
    
    func addSphere(x: Int, y: Int, z: Int) {
        let sphere = SCNSphere(radius: 0.1)
        sphere.firstMaterial?.diffuse.contents = UIColor.green
        
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3(x, y, z)
        sceneView.scene.rootNode.addChildNode(sphereNode)
    }
    
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped2))
        sceneView.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapped(recognizer: UIGestureRecognizer) {
        let sceneView = recognizer.view as! SCNView
        let touchLocation = recognizer.location(in: sceneView)
        let hitTouchResult = sceneView.hitTest(touchLocation, options: [:])
        
        if !hitTouchResult.isEmpty {
            let node = hitTouchResult[0].node
            let material = node.geometry?.material(named: "Color")
            
            material?.diffuse.contents = UIColor.init(red: CGFloat(arc4random())/CGFloat(UInt32.max), green: CGFloat(arc4random())/CGFloat(UInt32.max), blue: CGFloat(arc4random())/CGFloat(UInt32.max), alpha: 1)
        }
    }
    
    @objc func tapped2(recognizer: UIGestureRecognizer) {
        guard let boxNode = self.sceneView.scene.rootNode.childNode(withName: "box", recursively: true) else {
            fatalError("box not found")
        }
        
        boxNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        boxNode.physicsBody?.isAffectedByGravity = false
        boxNode.physicsBody?.damping = 0.0
        boxNode.physicsBody?.applyForce(SCNVector3(0,10,0), asImpulse: false)
    }
}
