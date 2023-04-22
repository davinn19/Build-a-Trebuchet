class_name Worker
extends Node

signal turned_idle
signal work_cycle_completed

onready var character_rig : CharacterRig = get_parent()
onready var inventory : Inventory = character_rig.get_node("Inventory")

onready var field : Field = get_node("../../../")

var move_speed : float = 200
var max_inventory_size : int = 10
var skill_level : int = 1


func _ready() -> void:
	connect("work_cycle_completed", self, "on_work_cycle_completed")
	yield(character_rig, "ready")
	play_anim("idle")
	do_work_cycle()
	
	
func do_work_cycle() -> void:
	assert(false, "Needs to be implemented")
	pass


func on_work_cycle_completed() -> void:
	do_work_cycle()


func play_anim(anim_name : String) -> void:
	assert(character_rig.anim.has_animation(anim_name))
	character_rig.anim.play(anim_name)


func rest(duration : float) -> void:
	play_anim("idle")
	yield(get_tree().create_timer(duration), "timeout")
	emit_signal("turned_idle")


func move_to_target(target : Node2D, stop_distance : float = 0) -> void:
	play_anim("walk")
	var start_pos : Vector2 = character_rig.global_position
	
	var target_pos : Vector2 = target.global_position
	
	var target_direction : Vector2 = start_pos.direction_to(target_pos)
	
	if sign(target_direction.x) != 0:
		character_rig.scale.x = sign(target_direction.x)
	
	var stop_vector : Vector2 = stop_distance * target_direction
	target_pos -= stop_vector
	
	var move_distance : float = target_pos.distance_to(start_pos)
	var move_duration = get_move_duration(move_distance)
	
	character_rig.move_tween.interpolate_property(character_rig, "position", start_pos, target_pos, move_duration)
	character_rig.move_tween.start()
	yield(character_rig.move_tween, "tween_completed")
	
	emit_signal("turned_idle")


func get_move_duration(move_distance : float) -> float:
	
	return move_distance / move_speed


func is_inventory_full() -> bool:
	return inventory.get_total_resource_amount() >= max_inventory_size


func is_inventory_empty() -> bool:
	return inventory.get_total_resource_amount() <= 0
