class_name Field
extends Node2D

signal game_ended

onready var quarry : Quarry = $Quarry
onready var supply_camp : SupplyCamp = $SupplyCamp
onready var trebuchet : Trebuchet = $Trebuchet
onready var command_center : CommandCenter = $CommandCenter

onready var anim : AnimationPlayer = $Anim
onready var cam : Camera2D = $Cam

onready var hud : Control = $CanvasLayer/HUD
onready var start_screen : Control = $CanvasLayer/StartScreen


func _ready() -> void:
	play_intro()


func _process(delta : float) -> void:
#	if Input.is_action_pressed("fast_forward"):
#		Engine.time_scale = 100000
#	else:
#		Engine.time_scale = 1
	pass


func play_intro() -> void:
	cam.current = true
	cam.freecam_enabled = false
	anim.play("StartScene")
	start_screen.connect("screen_dismissed", self, "start_game")
	yield(anim, "animation_finished")
	

func start_game() -> void:
	start_screen.visible = false
	hud.visible = true
	cam.freecam_enabled = true
	
	$StartGame.play()
	
	command_center.create_worker(command_center.miner)
	command_center.create_worker(command_center.woodcutter)
	command_center.create_worker(command_center.builder)
	
	trebuchet.connect("build_completed", self, "end_game")


func end_game() -> void:
	hud.visible = false
	$CanvasLayer/UI.visible = false
	
	cam.freecam_enabled = false
	
	var cam_start_pos : Vector2 = Vector2(1004, -408)
	var cam_tween : Tween = $Cam/Tween
	var tween_duration : int = 3

	cam_tween.interpolate_property(cam, "global_position", cam.global_position, cam_start_pos, tween_duration, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	cam_tween.interpolate_property(cam, "zoom", cam.zoom, Vector2(2, 2), tween_duration, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	cam_tween.start()
	
	command_center.freeze_workers()
	
	trebuchet.anim.play("Prime")
	yield(trebuchet.anim, "animation_finished")
	trebuchet.anim.play("Fire")
	$Anim.play("EndScene")

	yield($CanvasLayer/WinScreen/Button, "pressed")
	$CanvasLayer/WinScreen/Button.visible = false
	
	emit_signal("game_ended")

