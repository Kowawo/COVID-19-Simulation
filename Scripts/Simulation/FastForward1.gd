extends Button


func _on_FastForward1Button_pressed():
	Globals.stepChange = true
	Globals.step = 0.1
