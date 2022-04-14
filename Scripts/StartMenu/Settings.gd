extends Button


func _on_Settings_pressed():
	if (get_tree().change_scene("res://Szenen/Settings.tscn") != OK):
		print("An unexpected error occured when trying to switch to the Settings scene")
