extends Spatial


var mankind = []
var allPossiblePositions = []

var countInfected = 0
var countVaccinated = 0
var countDeath = 0

var day = Globals.day
var step = Globals.step


func get_random_number(modulo):
	randomize()
	return stepify((randi() % int(modulo)), 0.1)


func _ready():
	# Window auf bestimmte Größe setzen und Vergrößern erlauben
	OS.window_resizable = true
	OS.set_window_size(Vector2(1260, 620))
	OS.min_window_size = Vector2(1260, 620)
	
	# Informationen aktualisieren
	get_node("Toolbar4/Panel/VBoxContainer/VBoxContainer/DayCounter").set_text(str(Globals.day))
	
	get_node("Toolbar4/Panel/VBoxContainer/VBoxContainer2/HBoxContainer/VBoxContainer/PopulationCounterTotal").set_text(str(Globals.population))
	get_node("Toolbar4/Panel/VBoxContainer/VBoxContainer2/HBoxContainer/VBoxContainer2/PopulationCounterDay").set_text("0")
	
	get_node("Toolbar4/Panel/VBoxContainer/VBoxContainer3/HBoxContainer/VBoxContainer/InfectedPeopleCounterTotal").set_text(str(Globals.infectedPeople))
	get_node("Toolbar4/Panel/VBoxContainer/VBoxContainer3/HBoxContainer/VBoxContainer2/InfectedPeopleCounterDay").set_text("0")
	
	get_node("Toolbar4/Panel/VBoxContainer/VBoxContainer4/HBoxContainer/VBoxContainer/DeathsCounterTotal").set_text("0")
	get_node("Toolbar4/Panel/VBoxContainer/VBoxContainer4/HBoxContainer/VBoxContainer2/DeathsCounterDay").set_text("0")
	
	# Plattform erzeugen
	var cubeMesh = MeshInstance.new()
	cubeMesh.mesh = CubeMesh.new()
	
	cubeMesh.mesh.size.x = Globals.edgeLength
	cubeMesh.mesh.size.y = 0.5
	cubeMesh.mesh.size.z = Globals.edgeLength
	
	var boxCollision = CollisionShape.new()
	boxCollision.shape = BoxShape.new()
	
	var platform = KinematicBody.new()
	platform.add_child(cubeMesh)
	platform.add_child(boxCollision)
	
	var material = SpatialMaterial.new()
	if (Globals.outdoor):
		material.albedo_texture = load("res://Images/Outdoor.png")
	else :
		material.albedo_texture = load("res://Images/Indoor.png")
	material.uv1_scale = Vector3(3, 2, 1)
	cubeMesh.set_surface_material(0, material)
	
	platform.translation = Vector3(Globals.edgeLength / 2, 0, Globals.edgeLength / 2)
	
	add_child(platform)
	
	# Kamera positionieren
	var camera = get_node("Camera")
	camera.rotation_degrees.x = - 90
	
	camera.translation.x = Globals.edgeLength / 2
	camera.translation.y = tan(deg2rad(50)) * Globals.edgeLength / 2
	camera.translation.z = Globals.edgeLength / 2
	
	# Alle möglichen Positionen speichern
	for i in range(Globals.edgeLength):
		for j in range(Globals.edgeLength):
			allPossiblePositions.append(Vector3(i, 0.55, j))
	allPossiblePositions.shuffle()
	
	# Menschen erzeugen
	var HumanClass = preload("res://Scripts/Human.gd")
	
	var probabilityForInfection
	var probabilityForVaccinated
	
	for human in Globals.population:
		var vaccination = false
		var infected = false
		
		probabilityForInfection = (Globals.infectedPeople - countInfected) / (Globals.population - human) * 100
		probabilityForVaccinated = (Globals.vaccinatedPeople - countVaccinated) / (Globals.population - human) * 100
		
		if (probabilityForVaccinated >= get_random_number(100) + 1):
			vaccination = true
		if (probabilityForInfection >= get_random_number(100) + 1):
			infected = true
		
		var player
		if (infected):
			player = load("res://BlenderObjects/Infected/HumanInfected.tscn").instance()
		elif (vaccination):
			player = load("res://BlenderObjects/Vaccinated/HumanVaccinated.tscn").instance()
		else:
			player = load("res://BlenderObjects/Normal/HumanNormal.tscn").instance()
		
		player.translation = allPossiblePositions[human]
		
		add_child(player)
		
		mankind.append(HumanClass.Human.new(player, vaccination, infected, allPossiblePositions[human], allPossiblePositions[human]))
		
		if (vaccination):
			countVaccinated += 1
		if (infected):
			countInfected += 1
	Globals.mankind = mankind


var dayIsOver = true
func _process(_delta):
	# Ego-Perspektive wird betreten
	if (Globals.inFirstPersonPerspective):
		get_node("/root/Simulation/Toolbar5/Panel/VBoxContainer/HBoxContainer3/TakeFirstPersonPerspectiveButton").changeCameraPosition()
	
	if (Globals.run):
		# Wenn der Tag vorbei ist, bekommt jeder eine neue Position zugeteilt
		if (dayIsOver):
			allPossiblePositions.shuffle()
			
			for human in range(len(mankind)):
				mankind[human].set_targetPosition(allPossiblePositions[human])
		
			if (Globals.stepChange):
				step = Globals.step
				Globals.stepChange = false
		
		
		dayIsOver = true
		# Jeder läuft zu seiner Zielposition
		for human in range(len(mankind)):
			var position = mankind[human].get_position()
			var target = mankind[human].get_targetPosition()
			
			if (position != target):
				dayIsOver = false
				
				var vectorLength = sqrt(pow((target - position).x, 2) + pow((target - position).z, 2))
				
				if (vectorLength <= step):
					# Der Weg ist kleiner als die mögliche Reichweite
					mankind[human].get_model().translation = target
					mankind[human].set_position(mankind[human].get_model().translation)
				else:
					mankind[human].get_model().translation = mankind[human].get_model().translation + (step / vectorLength) * (target - position)
					mankind[human].set_position(mankind[human].get_model().translation)
				
				# Figur in die Richtung blicken lassen, in der er sich bewegt
				var angle = rad2deg(asin(abs(target.z - position.z) / vectorLength))
				if (position.z > target.z):
					if (position.x > target.x):
						mankind[human].get_model().set_rotation_degrees(Vector3(0, 270 - angle, 0))
					else:
						mankind[human].get_model().set_rotation_degrees(Vector3(0, 90 + angle, 0))
				else:
					if (position.x > target.x):
						mankind[human].get_model().set_rotation_degrees(Vector3(0, 270 + angle, 0))
					else:
						mankind[human].get_model().set_rotation_degrees(Vector3(0, 90 - angle, 0))
				
			
		# Wenn der Tag vorbei ist...
		if (dayIsOver):
			# ...wird der Tag kummuliert
			day += 1
			
			# ...werden die Infiziertentage für Infizierte um eins inkrementiert
			for human in range(len(mankind)):
				if (mankind[human].get_infected()):
					mankind[human].set_daysOfInfected(mankind[human].get_daysOfInfected() + 1)
			
			# ...wird geschaut, ob sich Infizierte genesen
			for human in range(len(mankind)):
				if (mankind[human].get_infected() and mankind[human].get_daysOfInfected() == Globals.daysToRecover):
					mankind[human].set_daysOfInfected(0)
					mankind[human].set_infected(false)
					mankind[human].set_recovered(true)
					mankind[human].changeModel()
					add_child(mankind[human].get_model())
					countInfected -= 1
			
			# ...wird geschaut, ob ein Infizierter stirbt
			for human in range(len(mankind)):
				if (mankind[human - countDeath].get_infected()):
					
					var death = get_random_number(1000) + 1
					
					if (mankind[human - countDeath].get_vaccination()):
						# Person ist geimpft
						if (Globals.vaccinatedPeopleProbdeath * 1000 >= death):
							if (mankind[human - countDeath].get_model() == Globals.chooseSpatial):
								get_node("/root/Simulation/Toolbar5/Panel/VBoxContainer/HBoxContainer3/TakeFirstPersonPerspectiveButton")._on_TakeFirstPersonPerspectiveButton_pressed()
								get_node("/root/Simulation/Toolbar5").hide()
							mankind[human - countDeath].get_model().queue_free()
							mankind.remove(human - countDeath)
							countInfected -= 1
							countDeath += 1
					elif (mankind[human - countDeath].get_recovered()):
						# Person ist genesen
						if (Globals.recoveredPeopleProbdeath * 1000 >= death):
							if (mankind[human - countDeath].get_model() == Globals.chooseSpatial):
								get_node("/root/Simulation/Toolbar5/Panel/VBoxContainer/HBoxContainer3/TakeFirstPersonPerspectiveButton")._on_TakeFirstPersonPerspectiveButton_pressed()
								get_node("/root/Simulation/Toolbar5").hide()
							mankind[human - countDeath].get_model().queue_free()
							mankind.remove(human - countDeath)
							countInfected -= 1
							countDeath += 1
					else :
						# Person ist weder genesen noch geimpft
						if (Globals.remainingPeopleProbdeath * 1000 >= death):
							if (mankind[human - countDeath].get_model() == Globals.chooseSpatial):
								get_node("/root/Simulation/Toolbar5/Panel/VBoxContainer/HBoxContainer3/TakeFirstPersonPerspectiveButton")._on_TakeFirstPersonPerspectiveButton_pressed()
								get_node("/root/Simulation/Toolbar5").hide()
							mankind[human - countDeath].get_model().queue_free()
							mankind.remove(human - countDeath)
							countInfected -= 1
							countDeath += 1
			
			# ...wird die Simulation beendet, wenn es keine Infizierten mehr gibt
			if (countInfected == 0):
				Globals.run = false
				get_node("/root/Simulation/Toolbar/Panel/HBoxContainer/HBoxContainer/PlayStopButton").set_text("Play")
			
			# ...wird geschaut, ob ein Infizierter einen anderen infiziert
			for infectedHuman in range(len(mankind)):
				if (mankind[infectedHuman].get_infected()):
					var position = mankind[infectedHuman].get_targetPosition()
					
					var fieldOfInfluence = []
					fieldOfInfluence.append(Vector3(position.x, position.y, position.z - 1))
					fieldOfInfluence.append(Vector3(position.x + 1, position.y, position.z - 1))
					fieldOfInfluence.append(Vector3(position.x + 1, position.y, position.z))
					fieldOfInfluence.append(Vector3(position.x + 1, position.y, position.z + 1))
					fieldOfInfluence.append(Vector3(position.x, position.y, position.z + 1))
					fieldOfInfluence.append(Vector3(position.x - 1, position.y, position.z - 1))
					fieldOfInfluence.append(Vector3(position.x - 1, position.y, position.z))
					fieldOfInfluence.append(Vector3(position.x - 1, position.y, position.z))
					
					for human in range(len(mankind)):
						if (mankind[human].get_position() in fieldOfInfluence and not mankind[human].get_infected()):
							
							var transmission = get_random_number(1000) + 1
							var RiskOfInfection = get_random_number(1000) + 1
							
							if (mankind[human].get_vaccination()):
								# Zu ansteckende Person ist geimpft
								if (Globals.medicalFaceMask):
									if (Globals.outdoor):
										# Es werden Masken getragen und es ist Outdoor
										if (Globals.infectedPeopleProb * 1000 >= transmission):
											if (Globals.vaccinatedPeopleProb * Globals.medicalFaceMaskProb * 1000 >= RiskOfInfection):
												mankind[human].set_infected(true)
												mankind[human].set_hasBeenInfected()
												mankind[human].changeModel()
												add_child(mankind[human].get_model())
												countInfected += 1
									else :
										# Es werden Masken getragen und es ist Indoor
										if (Globals.infectedPeopleProb * Globals.multiplyForIndoorProb * 1000 >= transmission):
											if (Globals.vaccinatedPeopleProb * Globals.medicalFaceMaskProb * 1000 >= RiskOfInfection):
												mankind[human].set_infected(true)
												mankind[human].set_hasBeenInfected()
												mankind[human].changeModel()
												add_child(mankind[human].get_model())
												countInfected += 1
								else :
									if (Globals.outdoor):
										# Es werden keine Masken getragen und es ist Outdoor
										if (Globals.infectedPeopleProb * 1000 >= transmission):
											if (Globals.vaccinatedPeopleProb * 1000 >= RiskOfInfection):
												mankind[human].set_infected(true)
												mankind[human].set_hasBeenInfected()
												mankind[human].changeModel()
												add_child(mankind[human].get_model())
												countInfected += 1
									else :
										# Es werden keine Masken getragen und es ist Indoor
										if (Globals.infectedPeopleProb * Globals.multiplyForIndoorProb * 1000 >= transmission):
											if (Globals.vaccinatedPeopleProb * 1000 >= RiskOfInfection):
												mankind[human].set_infected(true)
												mankind[human].set_hasBeenInfected()
												mankind[human].changeModel()
												add_child(mankind[human].get_model())
												countInfected += 1
							elif (mankind[human].get_recovered()):
								# Zu ansteckende Person ist genesen
								if (Globals.medicalFaceMask):
									if (Globals.outdoor):
										# Es werden Masken getragen und es ist Outdoor
										if (Globals.infectedPeopleProb * 1000 >= transmission):
											if (Globals.recoveredPeopleProb * Globals.medicalFaceMaskProb * 1000 >= RiskOfInfection):
												mankind[human].set_infected(true)
												mankind[human].set_hasBeenInfected()
												mankind[human].changeModel()
												add_child(mankind[human].get_model())
												countInfected += 1
									else :
										# Es werden Masken getragen und es ist Indoor
										if (Globals.infectedPeopleProb * Globals.multiplyForIndoorProb * 1000 >= transmission):
											if (Globals.recoveredPeopleProb * Globals.medicalFaceMaskProb * 1000 >= RiskOfInfection):
												mankind[human].set_infected(true)
												mankind[human].set_hasBeenInfected()
												mankind[human].changeModel()
												add_child(mankind[human].get_model())
												countInfected += 1
								else :
									if (Globals.outdoor):
										# Es werden keine Masken getragen und es ist Outdoor
										if (Globals.infectedPeopleProb * 1000 >= transmission):
											if (Globals.recoveredPeopleProb * 1000 >= RiskOfInfection):
												mankind[human].set_infected(true)
												mankind[human].set_hasBeenInfected()
												mankind[human].changeModel()
												add_child(mankind[human].get_model())
												countInfected += 1
									else :
										# Es werden keine Masken getragen und es ist Indoor
										if (Globals.infectedPeopleProb * Globals.multiplyForIndoorProb * 1000 >= transmission):
											if (Globals.recoveredPeopleProb * 1000 >= RiskOfInfection):
												mankind[human].set_infected(true)
												mankind[human].set_hasBeenInfected()
												mankind[human].changeModel()
												add_child(mankind[human].get_model())
												countInfected += 1
							else :
								# Zu ansteckende Person ist weder genesen noch geimpft
								if (Globals.medicalFaceMask):
									if (Globals.outdoor):
										# Es werden Masken getragen und es ist Outdoor
										if (Globals.infectedPeopleProb * 1000 >= transmission):
											if (Globals.remainingPeopleProb * Globals.medicalFaceMaskProb * 1000 >= RiskOfInfection):
												mankind[human].set_infected(true)
												mankind[human].set_hasBeenInfected()
												mankind[human].changeModel()
												add_child(mankind[human].get_model())
												countInfected += 1
									else :
										# Es werden Masken getragen und es ist Indoor
										if (Globals.infectedPeopleProb * Globals.multiplyForIndoorProb * 1000 >= transmission):
											if (Globals.remainingPeopleProb * Globals.medicalFaceMaskProb * 1000 >= RiskOfInfection):
												mankind[human].set_infected(true)
												mankind[human].set_hasBeenInfected()
												mankind[human].changeModel()
												add_child(mankind[human].get_model())
												countInfected += 1
								else :
									if (Globals.outdoor):
										# Es werden keine Masken getragen und es ist Outdoor
										if (Globals.infectedPeopleProb * 1000 >= transmission):
											if (Globals.remainingPeopleProb * 1000 >= RiskOfInfection):
												mankind[human].set_infected(true)
												mankind[human].set_hasBeenInfected()
												mankind[human].changeModel()
												add_child(mankind[human].get_model())
												countInfected += 1
									else :
										# Es werden keine Masken getragen und es ist Indoor
										if (Globals.infectedPeopleProb * Globals.multiplyForIndoorProb * 1000 >= transmission):
											if (Globals.remainingPeopleProb * 1000 >= RiskOfInfection):
												mankind[human].set_infected(true)
												mankind[human].set_hasBeenInfected()
												mankind[human].changeModel()
												add_child(mankind[human].get_model())
												countInfected += 1
			
			# ...werden die Werte gespeichert und aktualisiert
			Globals.day = day
			Globals.deaths.append(Globals.deaths[len(Globals.deaths) - 1] + countDeath)
			Globals.infected.append(countInfected)
			
			get_node("Toolbar4/Panel/VBoxContainer/VBoxContainer/DayCounter").set_text(str(Globals.day))
			
			get_node("Toolbar4/Panel/VBoxContainer/VBoxContainer2/HBoxContainer/VBoxContainer/PopulationCounterTotal").set_text(str(Globals.population - Globals.deaths[len(Globals.deaths) - 1]))
			get_node("Toolbar4/Panel/VBoxContainer/VBoxContainer2/HBoxContainer/VBoxContainer2/PopulationCounterDay").set_text(str( - countDeath))
			
			get_node("Toolbar4/Panel/VBoxContainer/VBoxContainer3/HBoxContainer/VBoxContainer/InfectedPeopleCounterTotal").set_text(str(countInfected))
			get_node("Toolbar4/Panel/VBoxContainer/VBoxContainer3/HBoxContainer/VBoxContainer2/InfectedPeopleCounterDay").set_text(str(Globals.infected[len(Globals.infected) - 1] - Globals.infected[len(Globals.infected) - 2]))
			
			get_node("Toolbar4/Panel/VBoxContainer/VBoxContainer4/HBoxContainer/VBoxContainer/DeathsCounterTotal").set_text(str(Globals.deaths[len(Globals.deaths) - 1]))
			get_node("Toolbar4/Panel/VBoxContainer/VBoxContainer4/HBoxContainer/VBoxContainer2/DeathsCounterDay").set_text(str(countDeath))
				
			countDeath = 0
