class_name Miner
extends Worker

var quarry : Quarry
var supply_camp : SupplyCamp


func _ready() -> void:
	quarry = field.get_node("Quarry")
	supply_camp = field.get_node("SupplyCamp")
	pass


func do_work_cycle() -> void:
	move_to_target(quarry)
	yield(self, "turned_idle")
	
	play_anim("work")
	while !is_inventory_full():
		yield(get_tree().create_timer(1), "timeout")
		quarry.work(inventory, skill_level)
	
	move_to_target(supply_camp)
	yield(self, "turned_idle")
	
	rest(3)
	yield(self, "turned_idle")
	
	supply_camp.deposit_all_items(inventory)
	emit_signal("work_cycle_completed")
