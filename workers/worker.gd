class_name Worker
extends Node

signal finished_moving

onready var character_rig : CharacterRig = get_parent()

var field : Field

var move_speed : float = 100
var is_idle : bool = true
var is_asleep : bool = false


func _init(field : Field) -> void:
	self.field = field
	pass


func _ready():
	field = get_node("../../")
	play_anim("idle")


func _process(delta : float) -> void:
	pass


func play_anim(anim_name : String) -> void:
	assert(character_rig.anim.has_animation(anim_name))
	character_rig.anim.play(anim_name)


func move_to_target(target : Node2D, stop_distance : float = 0) -> void:
	is_idle = false
	
	var start_pos : Vector2 = character_rig.global_position
	
	var target_pos : Vector2 = target.global_position
	var target_direction : Vector2 = start_pos.direction_to(target_pos)
	var stop_vector : Vector2 = stop_distance * target_direction
	target_pos -= stop_vector
	
	var move_distance : float = target_pos.distance_to(start_pos)
	var move_duration = get_move_duration(move_distance)
	
	character_rig.move_tween.interpolate_property(character_rig, "position", start_pos, target_pos, move_duration)
	play_anim("walk")
	
	yield(character_rig.move_tween, "tween_completed")
	is_idle = true


func get_move_duration(move_distance : float) -> float:
	return move_distance / move_speed
