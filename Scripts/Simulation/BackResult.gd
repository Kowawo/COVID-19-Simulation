extends Button


func _on_Back_pressed():
	var window = get_node("/root/Simulation/ResultDialog")
	var size = window.rect_size
	var xItems = floor((size.x - 120) / 82.5)
	
	if (abs(Globals.indexForResult) <= Globals.day - xItems - 1):
		Globals.indexForResult -= 1
