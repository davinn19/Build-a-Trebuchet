class_name SupplyCamp
extends Station

onready var inventory : Inventory = $Inventory


func work(worker_inventory : Inventory, skill_level : int) -> void:
	pass


func deposit_all_items(worker_inventory : Inventory) -> void:
	for resource in worker_inventory.real_resources.keys():
		var resource_amount : int = worker_inventory.get_resource_amount(resource)
		inventory.add_resource(resource, resource_amount)
	
	worker_inventory.clear()
	pass
