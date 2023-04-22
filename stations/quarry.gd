class_name Quarry
extends Station


func _ready() -> void:
	randomize()


func work(worker_inventory : Inventory, skill_level : int) -> void:
	var stone_amount : int = randi() % (skill_level + 1)		# TODO tweak drop amount
	var gold_amount : int = (randi() % (skill_level + 1)) / 2
	
	worker_inventory.add_resource("stone", stone_amount)
	worker_inventory.add_resource("gold", gold_amount)

