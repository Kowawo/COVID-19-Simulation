extends Node


# Settings
var population = 1000
var infectedPeople = 10
var vaccinatedPeople = 300
var daysToRecover = 7
var edgeLength = 50
var medicalFaceMask = false
var outdoor = true


# Wahrscheinlichkeiten
# Ansteckungsgefahr
var recoveredPeopleProb = 0.05
var vaccinatedPeopleProb = 0.025
var remainingPeopleProb = 0.5

# Übertragungsgefahr
var infectedPeopleProb = 0.5

# Tod
var recoveredPeopleProbdeath = 0.001
var vaccinatedPeopleProbdeath = 0.001
var remainingPeopleProbdeath = 0.002

# Sonstiges
var multiplyForIndoorProb = 2
var medicalFaceMaskProb = 2


# Für Simulation
var run = false
var stepChange = false
var step = 0.1

# Für Graph
var day = 0
var indexForResult = 0
var deaths = [0]
var infected = [infectedPeople]

# Für Ego-Perspektive
var mankind = []
var chooseSpatial
var inFirstPersonPerspective = false
