extends Button


func _ready():
	OS.center_window()


func _on_StartSimulation_pressed():
	if (get_tree().change_scene("res://Szenen/Simulation.tscn") != OK):
		print("An unexpected error occured when trying to switch to the Simulation scene")
