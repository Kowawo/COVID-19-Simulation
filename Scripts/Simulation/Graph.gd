extends Node2D

var window
var font
var colorForCoordinateSystem

func _ready():
	window = get_node("/root/Simulation/ResultDialog")
	font = load("res://Ressource/SettingsFont.tres")
	colorForCoordinateSystem = Color(255, 255, 255)

func _draw():
	var size = window.rect_size
	
	# Koordinatensystem
	# y-Achse
	draw_line(Vector2(70, 70), Vector2(70, size.y - 40), colorForCoordinateSystem)
	draw_line(Vector2(70, 70), Vector2(75, 80), colorForCoordinateSystem)
	draw_line(Vector2(70, 70), Vector2(65, 80), colorForCoordinateSystem)
	
	var yItems = floor((size.y - 120) / 82.5)
	
	for i in range(yItems + 1):
		draw_string(font, 
					Vector2(30 + (len(str(Globals.population)) - len(str(round(Globals.population / yItems * i)))) * 10, 
					size.y - 40 - 82.5 * i), 
					str(round(Globals.population / yItems * i)), 
					colorForCoordinateSystem)
	
	# x-Achse
	draw_line(Vector2(70, size.y - 40), Vector2(size.x - 40, size.y - 40), colorForCoordinateSystem)
	draw_line(Vector2(size.x - 40, size.y - 40), Vector2(size.x - 50, size.y - 45), colorForCoordinateSystem)
	draw_line(Vector2(size.x - 40, size.y - 40), Vector2(size.x - 50, size.y - 35), colorForCoordinateSystem)
	
	var xItems = min(floor((size.x - 120) / 82.5), Globals.day)
	
	if (xItems + abs(Globals.indexForResult) > Globals.day):
		Globals.indexForResult += 1
	
	for i in range(xItems + 1):
		draw_string(font, 
					Vector2(70 + 82.5 * i, 
					size.y - 10), 
					str(Globals.day - xItems + i + Globals.indexForResult), 
					colorForCoordinateSystem)
	
	# Werte einzeichnen
	var values = min(floor((size.x - 120) / 82.5), Globals.day)
	var oldVectorForPopulation
	var oldVectorForDeaths
	var oldVectorForInfected
	
	var colorForPopulation = Color(255, 255, 255)
	var colorForDeaths = Color(0, 0, 0)
	var colorForInfected = Color(255, 0, 0)
	
	for i in range(values + 1):
		for j in range(yItems + 1):
			# Population
			if (Globals.population - Globals.deaths[Globals.day - values + i + Globals.indexForResult] >= round(Globals.population / yItems * j)):
				if (Globals.population - Globals.deaths[Globals.day - values + i + Globals.indexForResult] < round(Globals.population / yItems * (j + 1))):
					var valuePerPixel = 82.5 / (round(Globals.population / yItems * (j + 1)) - round(Globals.population / yItems * j))
					var vector = Vector2(70 + 82.5 * i, size.y - 40 - 82.5 * j - (Globals.population - Globals.deaths[Globals.day - values + i + Globals.indexForResult] - round(Globals.population / yItems * j)) * valuePerPixel)
					
					draw_circle(vector, 3, colorForPopulation)
					
					if (i > 0):
						draw_line(vector, oldVectorForPopulation, colorForPopulation)
						
					oldVectorForPopulation = vector
			
			# Tote
			if (Globals.deaths[Globals.day - values + i + Globals.indexForResult] >= round(Globals.population / yItems * j)):
				if (Globals.deaths[Globals.day - values + i + Globals.indexForResult] < round(Globals.population / yItems * (j + 1))):
					var valuePerPixel = 82.5 / (round(Globals.population / yItems * (j + 1)) - round(Globals.population / yItems * j))
					var vector = Vector2(70 + 82.5 * i, size.y - 40 - 82.5 * j - (Globals.deaths[Globals.day - values + i + Globals.indexForResult] - round(Globals.population / yItems * j)) * valuePerPixel)
					
					draw_circle(vector, 3, colorForDeaths)
					
					if (i > 0):
						draw_line(vector, oldVectorForDeaths, colorForDeaths)
						
					oldVectorForDeaths = vector
			
			# Infizierte
			if (Globals.infected[Globals.day - values + i + Globals.indexForResult] >= round(Globals.population / yItems * j)):
				if (Globals.infected[Globals.day - values + i + Globals.indexForResult] < round(Globals.population / yItems * (j + 1))):
					var valuePerPixel = 82.5 / (round(Globals.population / yItems * (j + 1)) - round(Globals.population / yItems * j))
					var vector = Vector2(70 + 82.5 * i, size.y - 40 - 82.5 * j - (Globals.infected[Globals.day - values + i + Globals.indexForResult] - round(Globals.population / yItems * j)) * valuePerPixel)
					
					draw_circle(vector, 3, colorForInfected)
					
					if (i > 0):
						draw_line(vector, oldVectorForInfected, colorForInfected)
						
					oldVectorForInfected = vector
	
	# Legende
	draw_rect(Rect2(Vector2(size.x - 380, 10), Vector2(370, 50)), colorForCoordinateSystem, false)
	draw_circle(Vector2(size.x - 360, 34), 4, colorForPopulation)
	draw_string(font, Vector2(size.x - 340, 40), "Population", colorForPopulation)
	draw_circle(Vector2(size.x - 220, 34), 4, colorForDeaths)
	draw_string(font, Vector2(size.x - 200, 40), "Deaths", colorForPopulation)
	draw_circle(Vector2(size.x - 110, 34), 4, colorForInfected)
	draw_string(font, Vector2(size.x - 90, 40), "Infected", colorForPopulation)

func _process(_delta):
	update()
