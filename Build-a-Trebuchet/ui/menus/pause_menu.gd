extends Menu

onready var resume_button : Button = $Content/Resume


func _ready() -> void:
	resume_button.connect("pressed", self, "close")


func open() -> void:
	.open()
	get_tree().paused = true
	


func close() -> void:
	.close()
	get_tree().paused = false
