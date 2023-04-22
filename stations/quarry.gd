class_name Quarry
extends Station


func _ready() -> void:
	randomize()


func work(worker_inventory : Inventory, skill_level : int) -> void:
	var gold_amount : int = (randi() % (skill_level + 1)) / 2
	
	worker_inventory.add_resource("stone", get_stone_drop(skill_level))
	worker_inventory.add_resource("iron", get_iron_drop(skill_level))
	worker_inventory.add_resource("gold", get_gold_drop(skill_level))
	# TOOD add iron drop



func get_stone_drop(skill_level : int) -> int:
	return randi() % (skill_level + 1)


func get_iron_drop(skill_level : int) -> int:
	var drop_chance : float = (skill_level + 1) * 0.05
	var iron_dropped : bool = randf() < drop_chance
	if iron_dropped:
		return 1
	else:
		return 0


func get_gold_drop(skill_level : int) -> int:
	var drop_chance : float = skill_level * 0.02
	var gold_dropped : bool = randf() > 0.99
	
	if gold_dropped:
		return 1
	else:
		return 0
