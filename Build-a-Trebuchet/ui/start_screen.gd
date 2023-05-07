extends Control

signal screen_dismissed

onready var start_button : Button = $StartButton

func _ready():
	$StartButton.connect("pressed", self, "on_start_screen_pressed")


func on_start_screen_pressed() -> void:
	emit_signal("screen_dismissed")
	pass
