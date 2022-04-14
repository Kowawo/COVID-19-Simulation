extends Button


func _on_PlayStopButton_pressed():
	if (self.get_text() == "Play"):
		self.set_text("Pause")
	else:
		self.set_text("Play")
	Globals.run = not Globals.run
