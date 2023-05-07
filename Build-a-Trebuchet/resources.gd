extends Node

const resource_ids : Array = ["wood", "stone", "iron", "fibers", "gold"]


static func get_resource_dictionary() -> Dictionary:
	var dict : Dictionary = {}
	for resource_id in resource_ids:
		dict[resource_id] = 0
		
	return dict
