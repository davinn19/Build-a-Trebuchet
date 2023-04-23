class_name Worker
extends Node

signal turned_idle
signal work_cycle_completed

const base_speed : float = 1.0
const base_inventory_size : int = 5
const base_skill_level : int = 0

onready var character_rig : CharacterRig = get_parent()
onready var inventory : Inventory = character_rig.get_node("Inventory")

onready var field : Node = get_node("../../../")
onready var command_center : CommandCenter = field.get_node("CommandCenter")


func _ready() -> void:
	connect("work_cycle_completed", self, "on_work_cycle_completed")
	yield(character_rig, "ready")
	rest(1)
	yield(self, "turned_idle")
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


func move_to_station(station : Station) -> void:
	var target_pos : Vector2 = station.get_work_pos()
	move_to_pos(target_pos)
	yield(self, "turned_idle")
	face_target_pos(station.global_position)


func move_to_target(target : Node2D, stop_distance : float = 0) -> void:
	var target_pos : Vector2 = target.global_position
	var start_pos : Vector2 = character_rig.global_position
	
	var target_direction : Vector2 = start_pos.direction_to(target_pos)
	var stop_vector : Vector2 = stop_distance * target_direction
	target_pos -= stop_vector
	
	move_to_pos(target_pos)


func move_to_pos(target_pos : Vector2) -> void:
	var start_pos : Vector2 = character_rig.global_position
	
	var move_distance : float = target_pos.distance_to(start_pos)
	var move_duration = get_move_duration(move_distance)
	
	play_anim("walk")
	face_target_pos(target_pos)
	
	character_rig.move_tween.interpolate_property(character_rig, "global_position", start_pos, target_pos, move_duration)
	character_rig.move_tween.start()
	yield(character_rig.move_tween, "tween_completed")
	
	emit_signal("turned_idle")


func face_target_pos(target_pos : Vector2) -> void:
	var start_pos : Vector2 = character_rig.global_position
	
	var target_direction : Vector2 = start_pos.direction_to(target_pos)
	if sign(target_direction.x) != 0:
		character_rig.scale.x = sign(target_direction.x)


func get_move_duration(move_distance : float) -> float:
	return move_distance / get_speed()


func is_inventory_full() -> bool:
	return inventory.get_total_resource_amount() >= get_inventory_size()


func is_inventory_empty() -> bool:
	return inventory.get_total_resource_amount() <= 0
	

func get_speed() -> float:
	assert(false, "Needs to be implemented")
	return 0.0


func get_inventory_size() -> int:
	assert(false, "Needs to be implemented")
	return 0


func get_skill() -> int:
	assert(false, "Needs to be implemented")
	return 0
