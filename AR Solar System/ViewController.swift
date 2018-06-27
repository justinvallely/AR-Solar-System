//
//  ViewController.swift
//  AR Solar System
//
//  Created by Justin Vallely on 6/26/18.
//  Copyright © 2018 Pajama Donkey. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.session.run(configuration)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let sunNode =  planet(radius: 0.35, diffuse: #imageLiteral(resourceName: "sun"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, 0))
        let mercuryNode = planet(radius: 0.1, diffuse: #imageLiteral(resourceName: "mercury"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0.333, 0, 0))
        let venusNode = planet(radius: 0.1, diffuse: #imageLiteral(resourceName: "venus"), specular: nil, emission: #imageLiteral(resourceName: "venus atmosphere"), normal: nil, position: SCNVector3(0.666, 0, 0))
        let earthNode = planet(radius: 0.2, diffuse: #imageLiteral(resourceName: "earth daymap"), specular: #imageLiteral(resourceName: "earth specular"), emission: #imageLiteral(resourceName: "earth clouds"), normal: #imageLiteral(resourceName: "earth normal"), position: SCNVector3(1, 0, 0))
        let marsNode = planet(radius: 0.2, diffuse: #imageLiteral(resourceName: "mars"), specular: nil, emission: nil, normal: nil, position: SCNVector3(1.333, 0, 0))
        let jupiterNode = planet(radius: 0.2, diffuse: #imageLiteral(resourceName: "jupiter"), specular: nil, emission: nil, normal: nil, position: SCNVector3(1.666, 0, 0))
        let saturnNode = planet(radius: 0.2, diffuse: #imageLiteral(resourceName: "saturn"), specular: nil, emission: nil, normal: nil, position: SCNVector3(2, 0, 0))
        let uranusNode = planet(radius: 0.2, diffuse: #imageLiteral(resourceName: "uranus"), specular: nil, emission: nil, normal: nil, position: SCNVector3(2.333, 0, 0))
        let neptuneNode = planet(radius: 0.2, diffuse: #imageLiteral(resourceName: "nepture"), specular: nil, emission: nil, normal: nil, position: SCNVector3(2.666, 0, 0))
        let moonNode = planet(radius: 0.05, diffuse: #imageLiteral(resourceName: "moon"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0.3, 0, 0))

        let mercuryParent = SCNNode()
        mercuryParent.position = SCNVector3(0, 0, 0)
        sceneView.scene.rootNode.addChildNode(mercuryParent)
        mercuryParent.addChildNode(mercuryNode)

        let venusParent = SCNNode()
        venusParent.position = SCNVector3(0, 0, 0)
        sceneView.scene.rootNode.addChildNode(venusParent)
        venusParent.addChildNode(venusNode)

        let earthParent = SCNNode()
        earthParent.position = SCNVector3(0, 0, 0)
        sceneView.scene.rootNode.addChildNode(earthParent)
        earthParent.addChildNode(earthNode)

        let marsParent = SCNNode()
        marsParent.position = SCNVector3(0, 0, 0)
        sceneView.scene.rootNode.addChildNode(marsParent)
        marsParent.addChildNode(marsNode)

        let jupiterParent = SCNNode()
        jupiterParent.position = SCNVector3(0, 0, 0)
        sceneView.scene.rootNode.addChildNode(jupiterParent)
        jupiterParent.addChildNode(jupiterNode)

        let saturnParent = SCNNode()
        saturnParent.position = SCNVector3(0, 0, 0)
        sceneView.scene.rootNode.addChildNode(saturnParent)
        saturnParent.addChildNode(saturnNode)

        let uranusParent = SCNNode()
        uranusParent.position = SCNVector3(0, 0, 0)
        sceneView.scene.rootNode.addChildNode(uranusParent)
        uranusParent.addChildNode(uranusNode)

        let neptuneParent = SCNNode()
        neptuneParent.position = SCNVector3(0, 0, 0)
        sceneView.scene.rootNode.addChildNode(neptuneParent)
        neptuneParent.addChildNode(neptuneNode)

        let moonParent = SCNNode()
        moonParent.position = SCNVector3(0, 0, 0)
        earthNode.addChildNode(moonParent)
        moonParent.addChildNode(moonNode)

        sceneView.scene.rootNode.addChildNode(sunNode)
        sceneView.scene.rootNode.addChildNode(mercuryParent)
        sceneView.scene.rootNode.addChildNode(venusParent)
        sceneView.scene.rootNode.addChildNode(earthParent)
        sceneView.scene.rootNode.addChildNode(marsParent)
        sceneView.scene.rootNode.addChildNode(jupiterParent)
        sceneView.scene.rootNode.addChildNode(saturnParent)
        sceneView.scene.rootNode.addChildNode(uranusParent)
        sceneView.scene.rootNode.addChildNode(neptuneParent)

        sunNode.runAction(rotation(time: 8))
        earthNode.runAction(rotation(time: 8))
        moonNode.runAction(rotation(time: 5))
        venusNode.runAction(rotation(time: 10))

        earthParent.runAction(rotation(time: 14))
        venusParent.runAction(rotation(time: 8))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        sceneView.session.pause()
    }

    private func rotation(time: TimeInterval) -> SCNAction {
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        let foreverAction = SCNAction.repeatForever(action)
        return foreverAction
    }

    private func planet(radius: CGFloat, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        let planet = SCNNode(geometry: SCNSphere(radius: radius))
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }
}

extension Int {
    var degreesToRadians: Double {
        return Double(self) * .pi/180
    }
}
