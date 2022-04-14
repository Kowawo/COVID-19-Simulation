extends Button

func changeCameraPosition():
	for human in Globals.mankind:
		if (human.get_model() == Globals.chooseSpatial):
			var camera = get_node("/root/Simulation/Camera")
			
			camera.translation = human.get_position() + Vector3(0, 0.24, 0)
			camera.rotation_degrees = Vector3(0, 180 + human.get_model().rotation_degrees.y, 0)

func _on_TakeFirstPersonPerspectiveButton_pressed():
	if (Globals.inFirstPersonPerspective):
		self.set_text("Take first person perspective")
		var camera = get_node("/root/Simulation/Camera")
		camera.rotation_degrees = Vector3(-90, 0, 0)
		
		camera.translation.x = Globals.edgeLength / 2
		camera.translation.y = tan(deg2rad(50)) * Globals.edgeLength / 2
		camera.translation.z = Globals.edgeLength / 2
		
		Globals.chooseSpatial.show()
	else:
		self.set_text("Leave first person perspective")
		Globals.chooseSpatial.hide()
		changeCameraPosition()
	
	Globals.inFirstPersonPerspective = !Globals.inFirstPersonPerspective
