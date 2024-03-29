class_name CommandCenter
extends Station

const hire_cost : int = 50

export(PackedScene) var miner
export(PackedScene) var builder
export(PackedScene) var woodcutter

var upgrades : Dictionary = {
	"miner" : {
		"skill" : 0,
		"carry" : 0,
		"speed" : 0
	},
	
	"builder" : {
		"skill" : 0,
		"carry" : 0,
		"speed" : 0
	},
	
	"woodcutter" : {
		"skill" : 0,
		"carry" : 0,
		"speed" : 0
	}
}

var num_workers : Dictionary = {
	"miner" : 0,
	"builder" : 0,
	"woodcutter" : 0
}

onready var supply_camp : SupplyCamp = $"../SupplyCamp"
onready var work_pos_bounds : WorkPosBounds = $WorkPosBounds

var workers : Array = []


func create_worker(worker_template : PackedScene) -> void:
	var new_worker : Node2D = worker_template.instance()
	add_child(new_worker)
	new_worker.global_position = work_pos_bounds.get_random_pos()
	
	if worker_template == miner:
		num_workers["miner"] += 1
	elif worker_template == builder:
		num_workers["builder"] += 1
	elif worker_template == woodcutter:
		num_workers["woodcutter"] += 1
	else:
		assert(false)
	
	workers.append(new_worker)


func hire_worker(worker_type : String) -> void:
	supply_camp.buy(hire_cost)
	
	match worker_type:
		"miner":
			create_worker(miner)
		"builder":
			create_worker(builder)
		"woodcutter":
			create_worker(woodcutter)
	pass


func get_upgrade_level(worker_type : String, upgrade : String) -> int:
	return upgrades[worker_type][upgrade]
	
	
func get_upgrade_cost(worker_type : String, upgrade : String) -> int:
	return get_upgrade_level(worker_type, upgrade) * 30 + 30
	

func upgrade_stat(worker_type : String, upgrade : String) -> void:
	var upgrade_cost : int = get_upgrade_cost(worker_type, upgrade)
	
	upgrades[worker_type][upgrade] += 1
	supply_camp.buy(upgrade_cost)


func freeze_workers() -> void:
	for worker in workers:
		worker.emit_signal("freeze_requested")
