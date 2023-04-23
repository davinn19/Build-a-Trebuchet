extends Menu

onready var resume_button : Button = $Content/Resume
onready var quit_button : Button = $Content/Quit


func _ready() -> void:
	resume_button.connect("pressed", self, "close")
	quit_button.connect("pressed", self, "quit")


func open() -> void:
	.open()
	get_tree().paused = true
	


func close() -> void:
	.close()
	get_tree().paused = false


func quit() -> void:
	get_tree().quit()
	pass
