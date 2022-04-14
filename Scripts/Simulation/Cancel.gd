extends Button


func _on_CancelButton_pressed():
	# Windowsfenster zurücksetzen
	OS.window_resizable = false
	OS.set_window_size(Vector2(960, 540))
	
	# Simulationseinstellungen zurücksetzen
	Globals.run = false
	Globals.stepChange = false
	Globals.step = 0.1
	Globals.day = 0
	Globals.indexForResult = 0
	Globals.deaths = [0]
	Globals.infected = [Globals.infectedPeople]
	
	# First-Person-Perspektive zurücksetzen
	if (Globals.inFirstPersonPerspective):
		get_node("/root/Simulation/Toolbar5").hide()
		get_node("/root/Simulation/Toolbar5/Panel/VBoxContainer/HBoxContainer3/TakeFirstPersonPerspectiveButton")._on_TakeFirstPersonPerspectiveButton_pressed()
	else:
		get_node("/root/Simulation/Toolbar5").hide()
	
	if (get_tree().change_scene("res://Szenen/Root.tscn") != OK):
		print("An unexpected error occured when trying to switch to the Root scene")
