class_name CommandCenter
extends Station

export(PackedScene) var miner
export(PackedScene) var builder
export(PackedScene) var woodcutter

var upgrades : Dictionary = {
	"speed" : 0,
	"skill" : 0,
	"inventory" : 0,
}

onready var work_pos_bounds : WorkPosBounds = $WorkPosBounds

func create_worker(worker_template : PackedScene) -> void:
	var new_worker : Worker = worker_template.instance()
	new_worker.global_position = work_pos_bounds.get_random_pos()
	add_child(new_worker)