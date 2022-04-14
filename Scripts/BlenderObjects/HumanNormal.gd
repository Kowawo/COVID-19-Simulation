extends Spatial


func _on_Area_input_event(_camera, event, _click_position, _click_normal, _shape_idx):
	if (event is InputEventMouseButton):
		if (event.button_index == BUTTON_LEFT and event.pressed == true and !Globals.inFirstPersonPerspective):
			for human in Globals.mankind:
				if (human.get_model() == self):
					Globals.chooseSpatial = self
					
					get_node("/root/Simulation/Toolbar5").show()
					get_node("/root/Simulation/Toolbar5/Panel/VBoxContainer/HBoxContainer/VBoxContainer/InfectedPersonBoolLabel").set_text(str(human.get_infected()))
					get_node("/root/Simulation/Toolbar5/Panel/VBoxContainer/HBoxContainer/VBoxContainer2/VaccinatedPersonBoolLabel").set_text(str(human.get_vaccination()))
					get_node("/root/Simulation/Toolbar5/Panel/VBoxContainer/HasBeenInfectedLabel").set_text("Has been infected " + str(human.get_hasBeenInfected()) + " times")
