extends Button


func _on_CancelButton_pressed():
	if (get_tree().change_scene("res://Szenen/Root.tscn") != OK):
		print("An unexpected error occured when trying to switch to the Root scene")
