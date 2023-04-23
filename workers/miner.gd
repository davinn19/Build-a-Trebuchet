class_name Miner
extends Worker

onready var quarry : Quarry = field.get_node("Quarry")
onready var supply_camp : SupplyCamp = field.get_node("SupplyCamp")


func _init() -> void:
	worker_id = "miner"

	
func do_work_cycle() -> void:
	move_to_station(quarry)
	yield(self, "turned_idle")
	
	play_anim("work")
	while !is_inventory_full():
		work_timer.start(1)
		yield(work_timer, "timeout")
		quarry.work(inventory, get_skill())
	
	move_to_station(supply_camp)
	yield(self, "turned_idle")
	
	rest(1)
	yield(self, "turned_idle")
	
	supply_camp.deposit_all_items(inventory)
	emit_signal("work_cycle_completed")
