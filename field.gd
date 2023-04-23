extends Node2D


onready var cam : Camera2D = $Cam
onready var quarry : Quarry = $Quarry
onready var supply_camp : SupplyCamp = $SupplyCamp
onready var trebuchet : Trebuchet = $Trebuchet
onready var command_center : CommandCenter = $CommandCenter

func _ready() -> void:
	cam.current = true
	command_center.create_worker(command_center.miner)
	command_center.create_worker(command_center.woodcutter)
	command_center.create_worker(command_center.builder)
	
	trebuchet.connect("build_completed", self, "end_game")


func _process(delta : float) -> void:
	if Input.is_action_pressed("fast_forward"):
		Engine.time_scale = 10000
	else:
		Engine.time_scale = 1
	pass


func end_game() -> void:
	# cam.freecam_enabled = false
	trebuchet.anim.play("Prime")
	yield(trebuchet.anim, "animation_finished")
	trebuchet.anim.play("Fire")
