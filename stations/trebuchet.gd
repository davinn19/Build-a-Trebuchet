class_name Trebuchet
extends Station

signal build_completed

var total_required_resources : Array = [
	{
		"wood" : 50,
		"stone" : 20
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
var pending_work : int = 0

var delivery_queue : Dictionary = {}

var delivery_surplus : Dictionary = {
	"wood" : 0,
	"stone" : 0
}


func _ready() -> void:
	goto_next_stage()


func work(worker_inventory : Inventory, skill_level : int) -> void:
	
	
	var work_progress : int = randi() % (skill_level + 1)
	pending_work = max(pending_work - work_progress, 0)
	
	if is_build_stage_complete():
		goto_next_stage()


func is_build_stage_complete() -> bool:
	return cur_required_resources.empty() and pending_work == 0


func goto_next_stage() -> void:
	build_stage += 1
	update_appearance()
	if build_stage >= total_required_resources.size():
		emit_signal("build_completed")
	else:
		cur_required_resources = total_required_resources[build_stage].duplicate()
	pass


func update_appearance() -> void:
	$Anim.play(str(build_stage))



func get_required_resources() -> Dictionary:
	var required_resources : Dictionary = cur_required_resources.duplicate()
	for resource in delivery_surplus:
		required_resources[resource] -= delivery_surplus[resource]
	
	return required_resources


func queue_delivery(worker_inventory : Inventory, delivery_list : Dictionary) -> void:
	assert(!delivery_queue.has(worker_inventory))
	delivery_queue[worker_inventory] = delivery_list
	
	for resource in delivery_list:
		delivery_surplus[resource] += delivery_list[resource]

	pass	# TODO combine with supply camp???


func do_delivery(worker_inventory : Inventory) -> void:
	var delivery_list : Dictionary = delivery_queue[worker_inventory]
	for resource in delivery_list:
		var delivered_amount : int = delivery_list[resource]
		delivery_surplus[resource] -= delivered_amount
		cur_required_resources[resource] -= delivered_amount
		worker_inventory.take_resource(resource, delivered_amount)
		pending_work += delivered_amount
	
	delivery_queue.erase(worker_inventory)
