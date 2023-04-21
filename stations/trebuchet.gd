class_name Trebuchet
extends Station

signal build_completed

var total_required_resources : Array = [
	{
		"wood" : 50,
	},
	{
		"wood" : 100,
		"stone" : 100
	},
	{
		"wood" : 200,
		"stone" : 100
	}
	# TODO add more stages ???
]

var build_stage : int = -1
var cur_required_resources : Dictionary

onready var inventory : Inventory = $Inventory

func _ready() -> void:
	goto_next_stage()


func work(worker_inventory : Inventory, skill_level : int) -> void:
	update_appearance()
	
	if is_build_stage_complete():
		goto_next_stage()


func is_build_stage_complete() -> bool:
	var resources_remaining : int = 0
	for required_resource in cur_required_resources.keys():
		var resource_remaining : int = cur_required_resources[required_resource]
		resources_remaining += resource_remaining
	
	return resources_remaining <= 0


func get_remaining_resources() -> Array:
	return inventory.get_


func goto_next_stage() -> void:
	build_stage += 1
	if build_stage >= total_required_resources.size():
		emit_signal("build_completed")
	else:
		cur_required_resources = total_required_resources[build_stage].duplicate()
	pass


func update_appearance() -> void:
	# TODO implement
	pass
