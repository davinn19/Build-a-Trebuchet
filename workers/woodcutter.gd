class_name Woodcutter
extends Worker

onready var woods : Woods = field.woods

func do_work_cycle() -> void:
	move_to_station(woods)
	yield(self, "turned_idle")
	
	play_anim("work")
	while !inventory.is_full():
		yield(get_tree().create_timer(1), "timeout")
		woods.work(inventory, skill_level)
	
	move_to_station(field.supply_camp)
	yield(self, "turned_idle")
	
	rest(3)
	yield(self, "turned_idle")
	
	field.supply_camp.deposit_all_items(inventory)
	emit_signal("work_cycle_completed")
