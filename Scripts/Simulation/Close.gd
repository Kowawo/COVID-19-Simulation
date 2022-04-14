extends Button


func _on_CloseButton_pressed():
	if (Globals.inFirstPersonPerspective):
		get_node("/root/Simulation/Toolbar5").hide()
		get_node("/root/Simulation/Toolbar5/Panel/VBoxContainer/HBoxContainer3/TakeFirstPersonPerspectiveButton")._on_TakeFirstPersonPerspectiveButton_pressed()
	else:
		get_node("/root/Simulation/Toolbar5").hide()
