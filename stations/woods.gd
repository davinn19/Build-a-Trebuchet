class_name Woods
extends Station

var chopping_progress : int = 0
var available_wood : int = 0

onready var work_pos_bounds : WorkPosBounds = $WorkPosBounds


func get_work_pos() -> Vector2:
	return work_pos_bounds.get_random_pos()


func work(worker_inventory : Inventory, skill_level : int) -> void:
	# TODO implement
	if available_wood:
		var wood_collected : int = get_wood_drop(skill_level)
		worker_inventory.add_resource("wood", wood_collected)
		available_wood -= wood_collected
		
		worker_inventory.add_resource("fibers", get_fiber_drop(skill_level))
	else:
		chopping_progress += skill_level + 1
		if chopping_progress >= 50:
			chopping_progress = 0
			available_wood = randi() % 50 + 50

	
func get_wood_drop(skill_level : int) -> int:
	return int(max(available_wood, skill_level + 1))


func get_fiber_drop(skill_level : int) -> int:
	return randi() % ((skill_level + 1) / 2)
