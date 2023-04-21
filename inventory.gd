class_name Inventory
extends Node

var real_resources : Dictionary = {
	"wood" : 0,
	"stone" : 0,
	"gold" : 0
}


var queued_for_removal : Dictionary = real_resources.duplicate()	# TODO is this necessary
var queued_for_insertion : Dictionary = real_resources.duplicate()


func add_resource(resource_name : String, amount : int) -> void:
	real_resources[resource_name] += amount
	pass


func has_resource(resource_name : String, amount : int = 1) -> bool:
	var effective_amount : int = real_resources[resource_name] + queued_for_removal[resource_name]
	return effective_amount >= amount


func take_resource(resource_name : String, amount : int) -> void:
	assert(has_resource(resource_name, amount))
	real_resources[resource_name] -= amount


func get_resource_amount(resource : String) -> int:
	return real_resources[resource]
	
	
func get_total_resource_amount() -> int:
	var total_amount : int = 0
	for resource in real_resources.keys():
		total_amount += get_resource_amount(resource)
	return total_amount
	

func clear() -> void:
	for resource in real_resources.keys():
		real_resources[resource] = 0
