extends Button


func _on_SaveButton_pressed():
	# Einstellungen
	var populationButton = get_node("/root/Settings/TabContainer/Settings/HBoxContainer/Column2/VBoxContainer/PopulationButton").is_pressed()
	var population = int(get_node("/root/Settings/TabContainer/Settings/LineEdit").get_text())
	
	var infectedPeopleButton = get_node("/root/Settings/TabContainer/Settings/HBoxContainer/Column2/VBoxContainer/InfectedPeopleButton").is_pressed()
	var infectedPeople = float(get_node("/root/Settings/TabContainer/Settings/LineEdit2").get_text().replace(",", "."))
	
	var vaccinatedPeopleButton = get_node("/root/Settings/TabContainer/Settings/HBoxContainer/Column2/VBoxContainer/VaccinatedPeopleButton").is_pressed()
	var vaccinatedPeople = float(get_node("/root/Settings/TabContainer/Settings/LineEdit3").get_text().replace(",", "."))
	
	var daysToRecoverButton = get_node("/root/Settings/TabContainer/Settings/HBoxContainer/Column2/VBoxContainer/DaysToRecoverButton").is_pressed()
	var daysToRecover = int(get_node("/root/Settings/TabContainer/Settings/LineEdit4").get_text())
	
	var edgeLengthButton = get_node("/root/Settings/TabContainer/Settings/HBoxContainer/Column2/VBoxContainer/EdgeLengthButton").is_pressed()
	var edgeLength = int(get_node("/root/Settings/TabContainer/Settings/LineEdit5").get_text())
	
	var medicalFaceMask = get_node("/root/Settings/TabContainer/Settings/HBoxContainer/Column2/VBoxContainer/MedicalFaceMaskButton").is_pressed()
	var outIndoor = get_node("/root/Settings/TabContainer/Settings/HBoxContainer/Column2/VBoxContainer/OutInDoorsButton").is_pressed()


	# Wahrscheinlichkeiten
	var recoveredPeopleProbButton = get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleRiskOfInfection/HBoxContainer/Column2/VBoxContainer/RecoveredPeopleButton").is_pressed()
	var recoveredPeopleProb = float(get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleRiskOfInfection/LineEdit").get_text().replace(",", "."))

	var vaccinatedPeopleProbButton = get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleRiskOfInfection/HBoxContainer/Column2/VBoxContainer/VaccinatedPeopleProbButton").is_pressed()
	var vaccinatedPeopleProb = float(get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleRiskOfInfection/LineEdit2").get_text().replace(",", "."))

	var remainingPeopleProbButton = get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleRiskOfInfection/HBoxContainer/Column2/VBoxContainer/RemainingPeopleButton").is_pressed()
	var remainingPeopleProb = float(get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleRiskOfInfection/LineEdit3").get_text().replace(",", "."))

	var infectedPeopleProbButton = get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleTransmission/HBoxContainer/Column2/VBoxContainer/InfectedPeopleProbButton").is_pressed()
	var infectedPeopleProb = float(get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleTransmission/LineEdit").get_text().replace(",", "."))

	var recoveredPeopleProbDeathButton = get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleDeath/HBoxContainer/Column2/VBoxContainer/RecoveredPeopleProbDeathButton").is_pressed()
	var recoveredPeopleProbDeath = float(get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleDeath/LineEdit").get_text().replace(",", "."))

	var vaccinatedPeopleProbDeathButton = get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleDeath/HBoxContainer/Column2/VBoxContainer/VaccinatedPeopleProbDeathButton").is_pressed()
	var vaccinatedPeopleProbDeath = float(get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleDeath/LineEdit2").get_text().replace(",", "."))

	var remainingPeopleProbDeathButton = get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleDeath/HBoxContainer/Column2/VBoxContainer/RemainingPeopleProbDeathButton").is_pressed()
	var remainingPeopleProbDeath = float(get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleDeath/LineEdit3").get_text().replace(",", "."))

	var multiplyForIndoorProbButton = get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleOthers/HBoxContainer/Column2/VBoxContainer/MultiplyForIndoorButton").is_pressed()
	var multiplyForIndoorProb = float(get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleOthers/LineEdit").get_text().replace(",", "."))

	var medicalFaceMaskProbButton = get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleOthers/HBoxContainer/Column2/VBoxContainer/MedicalFaceMaskProbButton").is_pressed()
	var medicalFaceMaskProb = float(get_node("/root/Settings/TabContainer/Probabilities/ScrollContainer/VBoxContainer/TitleOthers/LineEdit").get_text().replace(",", "."))
	
	
	# Einstellung speichern
	if (populationButton and population > 0):
		Globals.population = population
	
	if (infectedPeopleButton and infectedPeople >= 0):
		Globals.infectedPeople = int(Globals.population * infectedPeople)
	
	if (vaccinatedPeopleButton and vaccinatedPeople >= 0):
		Globals.vaccinatedPeople = int(Globals.population * vaccinatedPeople)
	
	if (daysToRecoverButton and daysToRecover > 0):
		Globals.daysToRecover = daysToRecover
	
	# Jedem steht ein Quadratmeter mindestens zur Verfügung
	if (edgeLengthButton):
		if (edgeLength * edgeLength >= Globals.population):
			Globals.edgeLength = edgeLength
		else:
			Globals.edgeLength = ceil(sqrt(Globals.population))
	
	Globals.medicalFaceMask = medicalFaceMask
	Globals.outdoor = not outIndoor
	
	# Wahrscheinlichkeiten speichern
	if (recoveredPeopleProbButton):
		Globals.recoveredPeopleProb = recoveredPeopleProb
	
	if (vaccinatedPeopleProbButton):
		Globals.vaccinatedPeopleProb = vaccinatedPeopleProb
	
	if (remainingPeopleProbButton):
		Globals.remainingPeopleProb = remainingPeopleProb
	
	if (infectedPeopleProbButton):
		Globals.infectedPeopleProb = infectedPeopleProb
	
	if (recoveredPeopleProbDeathButton):
		Globals.recoveredPeopleProbdeath = recoveredPeopleProbDeath
	
	if (vaccinatedPeopleProbDeathButton):
		Globals.vaccinatedPeopleProbdeath = vaccinatedPeopleProbDeath
	
	if (remainingPeopleProbDeathButton):
		Globals.remainingPeopleProbdeath = remainingPeopleProbDeath
	
	if (multiplyForIndoorProbButton):
		Globals.multiplyForIndoorProb = multiplyForIndoorProb
	
	if (medicalFaceMaskProbButton):
		Globals.medicalFaceMaskProb = medicalFaceMaskProb
	
	
	if (get_tree().change_scene("res://Szenen/Root.tscn") != OK):
		print("An unexpected error occured when trying to switch to the Root scene")
