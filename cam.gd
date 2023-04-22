extends Camera2D

const scroll_speed : int = 1000
var freecam_enabled : bool = true



func _ready() -> void:
	pass
	

func _process(delta : float) -> void:
	if !freecam_enabled:
		return
	
	var direction : int = 0
	if Input.is_action_pressed("left"):
		direction -= 1
	if Input.is_action_pressed("right"):
		direction += 1
	
	position.x += direction * scroll_speed * delta
	pass
