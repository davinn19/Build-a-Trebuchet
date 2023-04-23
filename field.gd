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
	cam.freecam_enabled = false
	
	var cam_start_pos : Vector2 = Vector2(1004, -408)
	var cam_tween : Tween = $Cam/Tween
	var tween_duration : int = 3

	cam_tween.interpolate_property(cam, "global_position", cam.global_position, cam_start_pos, tween_duration, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	cam_tween.interpolate_property(cam, "zoom", cam.zoom, Vector2(2, 2), tween_duration, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	cam_tween.start()
	
	trebuchet.anim.play("Prime")
	yield(trebuchet.anim, "animation_finished")
	trebuchet.anim.play("Fire")
	$Anim.play("EndScene")
