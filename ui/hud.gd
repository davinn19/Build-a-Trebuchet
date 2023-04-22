extends Control

onready var ui : Control = $"../UI"


func _ready():
	$Buttons/Settings.connect("pressed", ui, "open_ui", ["Settings"])
	$Buttons/Progress.connect("pressed", ui, "open_ui", ["Progress"])
	$Buttons/Supplies.connect("pressed", ui, "open_ui", ["Supplies"])
	$Buttons/Workers.connect("pressed", ui, "open_ui", ["Workers"])
