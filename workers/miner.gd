class_name Miner
extends Worker


func do_work_cycle() -> void:
	move_to_target(field.quarry)
	yield(self, "turned_idle")
	
	play_anim("work")
	while !is_inventory_full():
		yield(get_tree().create_timer(1), "timeout")
		field.quarry.work(inventory, skill_level)
	
	move_to_target(field.supply_camp)
	yield(self, "turned_idle")
	
	rest(3)
	yield(self, "turned_idle")
	
	field.supply_camp.deposit_all_items(inventory)
	emit_signal("work_cycle_completed")
