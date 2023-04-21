class_name CharacterRig
extends Node2D

onready var anim : AnimationPlayer = $Anim
onready var move_tween : Tween = $MoveTween


func _ready() -> void:
	randomize_skin_color()
	

func randomize_skin_color() -> void:
	# TODO implement
	pass
