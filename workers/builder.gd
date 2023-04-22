class_name Builder
extends Worker

onready var trebuchet : Trebuchet = field.get_node("Trebuchet")
onready var supply_camp : SupplyCamp = field.get_node("SupplyCamp")


func do_work_cycle() -> void:
	var delivery_list : Dictionary = get_delivery_list()
	if !delivery_list.empty():
		trebuchet.queue_delivery(inventory, delivery_list)
		supply_camp.queue_delivery(inventory, delivery_list)
		
		move_to_station(supply_camp)
		yield(self, "turned_idle")
		
		rest(1)
		yield(self, "turned_idle")
		supply_camp.do_delivery(inventory)
		
		move_to_station(trebuchet)
		yield(self, "turned_idle")
		
		rest(1)
		yield(self, "turned_idle")
		
		trebuchet.do_delivery(inventory)

	if trebuchet.pending_work > 0:
		move_to_station(trebuchet)
		yield(self, "turned_idle")
		
		play_anim("work")
		while trebuchet.pending_work > 0:
			yield(get_tree().create_timer(1), "timeout")
			trebuchet.work(inventory, skill_level)
	
	rest(1)
	yield(self, "turned_idle")
	emit_signal("work_cycle_completed")


func get_delivery_list() -> Dictionary:
	var delivery_list : Dictionary = {}
	var available_inventory_space : int = max_inventory_size
	
	var required_resources : Dictionary = trebuchet.get_required_resources()
	
	for resource in required_resources:
		var available_amount : int = supply_camp.get_resource_amount(resource)
		var required_amount : int = required_resources[resource]
		var amount_to_take : int = min(available_amount, min(required_amount, available_inventory_space))
		
		available_inventory_space -= amount_to_take
		delivery_list[resource] = amount_to_take
	
	if available_inventory_space == max_inventory_size:	# no resources were chosen for delivery
		return {}
	
	return delivery_list
