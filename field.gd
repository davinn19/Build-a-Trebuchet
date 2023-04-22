class_name Field
extends Node2D

onready var cam : Camera2D = $Cam
onready var workers : Node2D = $Workers
onready var quarry : Quarry = $Quarry
onready var supply_camp : SupplyCamp = $SupplyCamp
onready var trebuchet : Trebuchet = $Trebuchet
onready var woods : Woods = $Woods

export(Array, PackedScene) var worker_types = []

func _ready() -> void:
	cam.current = true
	create_miner()
	create_builder()
	create_woodcutter()
	

func create_miner() -> void:
	var worker : Node2D = worker_types[0].instance()
	worker.global_position = $SpawnPos.global_position
	workers.add_child(worker)
	

func create_builder() -> void:
	var worker : Node2D = worker_types[1].instance()
	worker.global_position = $SpawnPos.global_position
	workers.add_child(worker)


func create_woodcutter() -> void:
	var worker : Node2D = worker_types[2].instance()
	worker.global_position = $SpawnPos.global_position
	workers.add_child(worker)
