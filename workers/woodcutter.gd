class_name Woodcutter
extends Worker

onready var woods : Woods = field.get_node("Woods")
onready var supply_camp : SupplyCamp = field.get_node("SupplyCamp")

func do_work_cycle() -> void:
	move_to_station(woods)
	yield(self, "turned_idle")
	
	play_anim("work")
	while !is_inventory_full():
		yield(get_tree().create_timer(1), "timeout")
		woods.work(inventory, skill_level)
	
	move_to_station(supply_camp)
	yield(self, "turned_idle")
	
	rest(1)
	yield(self, "turned_idle")
	
	supply_camp.deposit_all_items(inventory)
	emit_signal("work_cycle_completed")
