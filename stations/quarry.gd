class_name Quarry
extends Station


func _ready() -> void:
	randomize()


func work(worker_inventory : Inventory, skill_level : int) -> void:
	var stone_amount : int = randi() % skill_level
	worker_inventory.add_resource("stone", stone_amount)
	worker_inventory.add_resource("gold", get_gold_amount(skill_level))


func get_gold_amount(skill_level : int) -> int:
	var gets_gold : bool = (randi() % 10) <= skill_level
	
	if gets_gold:
		return randi() % 5
	else:
		return 0
