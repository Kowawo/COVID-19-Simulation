extends Button


func _on_ResultButton_pressed():
	var windowDialog = get_node("/root/Simulation/ResultDialog")
	windowDialog.popup_centered()
