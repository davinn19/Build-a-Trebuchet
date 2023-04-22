class_name Quarry
extends Station


onready var work_pos_bounds : WorkPosBounds = $WorkPosBounds
func _ready() -> void:
	randomize()


func work(worker_inventory : Inventory, skill_level : int) -> void:	
	worker_inventory.add_resource("stone", get_stone_drop(skill_level))
	worker_inventory.add_resource("iron", get_iron_drop(skill_level))


func get_work_pos() -> Vector2:
	return work_pos_bounds.get_random_pos()


func get_stone_drop(skill_level : int) -> int:
	return randi() % (skill_level + 1)


func get_iron_drop(skill_level : int) -> int:
	var drop_chance : float = (skill_level + 1) * 0.05
	var iron_dropped : bool = randf() < drop_chance
	if iron_dropped:
		return 1
	else:
		return 0
