class Human:
	var model
	var vaccination
	var infected
	var recovered
	var targetPosition
	var position
	var hasBeenInfected
	var daysOfInfected
	
	# Konstruktor
	func _init(mod, vac, inf, targetPos, pos):
		self.model = mod
		self.vaccination = vac
		self.infected = inf
		self.targetPosition = targetPos
		self.position = pos
		self.daysOfInfected = 0
		
		if (inf):
			self.hasBeenInfected = 1
		else:
			self.hasBeenInfected = 0
	
	# Setter-/Getter-Methoden
	func get_model():
		return self.model
	
	func get_vaccination():
		return self.vaccination
	
	func set_vaccination(vac):
		self.vaccination = vac
	
	func get_infected():
		return self.infected
	
	func set_infected(inf):
		self.infected = inf
	
	func get_recovered():
		return self.recovered
	
	func set_recovered(rec):
		self.recovered = rec
	
	func get_targetPosition():
		return self.targetPosition
	
	func set_targetPosition(pos):
		self.targetPosition = pos
	
	func get_position():
		return self.position
	
	func set_position(pos):
		self.position = pos
	
	func get_daysOfInfected():
		return self.daysOfInfected
	
	func set_daysOfInfected(days):
		self.daysOfInfected = days
	
	func get_hasBeenInfected():
		return self.hasBeenInfected
	
	func set_hasBeenInfected():
		self.hasBeenInfected += 1
	
	# Methoden
	func changeModel():
		var newModel
		if (self.infected):
			newModel = load("res://BlenderObjects/Infected/HumanInfected.tscn").instance()
		elif (self.vaccination):
			newModel = load("res://BlenderObjects/Vaccinated/HumanVaccinated.tscn").instance()
		elif (self.recovered):
			newModel = load("res://BlenderObjects/Recovered/HumanRecovered.tscn").instance()
		else :
			newModel = load("res://BlenderObjects/Normal/HumanNormal.tscn").instance()
		
		newModel.scale = Vector3(0.22, 0.22, 0.22)
		newModel.translation = self.model.translation
		
		# Falls das Model ausgetauscht wird, welches man repräsentiert,
		# muss dieses aktualisiert werden und unsichtbar gemacht werden
		# Zusätzlich müssen die Werte, welche angezeigt werden, aktualisiert werden
		if (self.model == Globals.chooseSpatial):
			Globals.chooseSpatial = newModel
			newModel.hide()
			self.model.get_node("/root/Simulation/Toolbar5").show()
			self.model.get_node("/root/Simulation/Toolbar5/Panel/VBoxContainer/HBoxContainer/VBoxContainer/InfectedPersonBoolLabel").set_text(str(self.get_infected()))
			self.model.get_node("/root/Simulation/Toolbar5/Panel/VBoxContainer/HBoxContainer/VBoxContainer2/VaccinatedPersonBoolLabel").set_text(str(self.get_vaccination()))
			self.model.get_node("/root/Simulation/Toolbar5/Panel/VBoxContainer/HasBeenInfectedLabel").set_text("Has been infected " + str(self.get_hasBeenInfected()) + " times")
			
		self.model.queue_free()
		self.model = newModel
