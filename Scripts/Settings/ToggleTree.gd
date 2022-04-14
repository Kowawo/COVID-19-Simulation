extends AnimationTree


func _ready():
	self.active = true
	self["parameters/playback"].start("ToggleOff")


func _on_PopulationButton_toggled(button_pressed):
	var node = get_node("/root/Settings/TabContainer/Settings/LineEdit")
	
	if (button_pressed):
		self["parameters/playback"].travel("ToggleOn")
		node.show()
	else:
		self["parameters/playback"].travel("ToggleOff")
		node.hide()


func _on_InfectedPersonsButton_toggled(button_pressed):
	var node = get_node("/root/Settings/TabContainer/Settings/LineEdit2")
	
	if (button_pressed):
		self["parameters/playback"].travel("ToggleOn")
		node.show()
	else:
		self["parameters/playback"].travel("ToggleOff")
		node.hide()


func _on_VaccinatedPeopleButton_toggled(button_pressed):
	var node = get_node("/root/Settings/TabContainer/Settings/LineEdit3")
	
	if (button_pressed):
		self["parameters/playback"].travel("ToggleOn")
		node.show()
	else:
		self["parameters/playback"].travel("ToggleOff")
		node.hide()


func _on_DaysToRecoverButton_toggled(button_pressed):
	var node = get_node("/root/Settings/TabContainer/Settings/LineEdit4")
	
	if (button_pressed):
		self["parameters/playback"].travel("ToggleOn")
		node.show()
	else:
		self["parameters/playback"].travel("ToggleOff")
		node.hide()


func _on_EdgeLengthButton_toggled(button_pressed):
	var node = get_node("/root/Settings/TabContainer/Settings/LineEdit5")
	
	if (button_pressed):
		self["parameters/playback"].travel("ToggleOn")
		node.show()
	else:
		self["parameters/playback"].travel("ToggleOff")
		node.hide()


func _on_MedicalFaceMaskButton_toggled(button_pressed):
	if (button_pressed):
		self["parameters/playback"].travel("ToggleOn")
	else:
		self["parameters/playback"].travel("ToggleOff")


func _on_OutInDoorsButton_toggled(button_pressed):
	if (button_pressed):
		self["parameters/playback"].travel("ToggleOn")
	else:
		self["parameters/playback"].travel("ToggleOff")



func _on_RecoveredPeopleButton_toggled(button_pressed):
	var node = get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleRiskOfInfection/LineEdit")
	
	if (button_pressed):
		self["parameters/playback"].travel("ToggleOn")
		node.show()
	else:
		self["parameters/playback"].travel("ToggleOff")
		node.hide()


func _on_VaccinatedPeopleProbButton_toggled(button_pressed):
	var node = get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleRiskOfInfection/LineEdit2")
	
	if (button_pressed):
		self["parameters/playback"].travel("ToggleOn")
		node.show()
	else:
		self["parameters/playback"].travel("ToggleOff")
		node.hide()


func _on_RemainingPeopleButton_toggled(button_pressed):
	var node = get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleRiskOfInfection/LineEdit3")
	
	if (button_pressed):
		self["parameters/playback"].travel("ToggleOn")
		node.show()
	else:
		self["parameters/playback"].travel("ToggleOff")
		node.hide()


func _on_InfectedPeopleProbButton_toggled(button_pressed):
	var node = get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleTransmission/LineEdit")
	
	if (button_pressed):
		self["parameters/playback"].travel("ToggleOn")
		node.show()
	else:
		self["parameters/playback"].travel("ToggleOff")
		node.hide()


func _on_RecoveredPeopleProbDeathButton_toggled(button_pressed):
	var node = get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleDeath/LineEdit")
	
	if (button_pressed):
		self["parameters/playback"].travel("ToggleOn")
		node.show()
	else:
		self["parameters/playback"].travel("ToggleOff")
		node.hide()


func _on_VaccinatedPeopleProbDeathButton_toggled(button_pressed):
	var node = get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleDeath/LineEdit2")
	
	if (button_pressed):
		self["parameters/playback"].travel("ToggleOn")
		node.show()
	else:
		self["parameters/playback"].travel("ToggleOff")
		node.hide()


func _on_RemainingPeopleProbDeathButton_toggled(button_pressed):
	var node = get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleDeath/LineEdit3")
	
	if (button_pressed):
		self["parameters/playback"].travel("ToggleOn")
		node.show()
	else:
		self["parameters/playback"].travel("ToggleOff")
		node.hide()


func _on_MultiplyForIndoorButton_toggled(button_pressed):
	var node = get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleOthers/LineEdit")
	
	if (button_pressed):
		self["parameters/playback"].travel("ToggleOn")
		node.show()
	else:
		self["parameters/playback"].travel("ToggleOff")
		node.hide()


func _on_MedicalFaceMaskProbButton_toggled(button_pressed):
	var node = get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleOthers/LineEdit2")
	
	if (button_pressed):
		self["parameters/playback"].travel("ToggleOn")
		node.show()
	else:
		self["parameters/playback"].travel("ToggleOff")
		node.hide()
