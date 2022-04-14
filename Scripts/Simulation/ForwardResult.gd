extends Button


func _on_Forward_pressed():
	if (Globals.indexForResult != 0):
		Globals.indexForResult += 1
