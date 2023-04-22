class_name SupplyCamp
extends Station

onready var inventory : Inventory = $Inventory
onready var work_pos_bounds : WorkPosBounds = $WorkPosBounds

var delivery_queue : Dictionary = {}
var delivery_deficit : Dictionary = Resources.get_resource_dictionary()


func get_work_pos() -> Vector2:
	return work_pos_bounds.get_random_pos()


func get_resource_amount(resource : String) -> int:
	return inventory.get_resource_amount(resource) - delivery_deficit[resource]


func deposit_all_items(worker_inventory : Inventory) -> void:
	for resource in worker_inventory.real_resources.keys():
		var resource_amount : int = worker_inventory.get_resource_amount(resource)
		inventory.add_resource(resource, resource_amount)
	
	worker_inventory.clear()
	pass


func queue_delivery(worker_inventory : Inventory, delivery_list : Dictionary) -> void:
	assert(!delivery_queue.has(worker_inventory))
	delivery_queue[worker_inventory] = delivery_list
	
	for resource in delivery_list:
		delivery_deficit[resource] += delivery_list[resource]

	pass
	

func do_delivery(worker_inventory : Inventory) -> void:
	var delivery_list : Dictionary = delivery_queue[worker_inventory]
	for resource in delivery_list:
		var delivered_amount : int = delivery_list[resource]
		delivery_deficit[resource] -= delivered_amount
		inventory.take_resource(resource, delivered_amount)
		worker_inventory.add_resource(resource, delivered_amount)
	
	delivery_queue.erase(worker_inventory)
