extends Button


func _on_ResetButton_pressed():
	# Einstellungen
	Globals.population = 1000
	Globals.infectedPeople = 10
	Globals.vaccinatedPeople = 300
	Globals.daysToRecover = 7
	Globals.edgeLength = 50
	Globals.medicalFaceMask = false
	Globals.outdoor = true
	
	# Wahrscheinlichkeiten
	# Ansteckungsgefahr
	Globals.recoveredPeopleProb = 0.05
	Globals.vaccinatedPeopleProb = 0.025
	Globals.remainingPeopleProb = 0.5
	
	# Übertragungswahrscheinlichkeit
	Globals.infectedPeopleProb = 0.5
	
	# Wahrscheinlichkeit für Tod
	Globals.recoveredPeopleProbdeath = 0.001
	Globals.vaccinatedPeopleProbdeath = 0.001
	Globals.remainingPeopleProbdeath = 0.002
	
	# Sonstiges
	Globals.multiplyForIndoorProb = 2
	Globals.medicalFaceMaskProb = 2
	
	# Simulation
	Globals.run = false
	Globals.stepChange = false
	Globals.step = 0.1
	
	Globals.day = 0
	Globals.indexForResult = 0
	Globals.deaths = [0]
	Globals.infected = [Globals.infectedPeople]
	
	if (get_tree().change_scene("res://Szenen/Root.tscn") != OK):
		print("An unexpected error occured when trying to switch to the Root scene")
