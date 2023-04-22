class_name Field
extends Node2D

onready var cam : Camera2D = $Cam
onready var workers : Node2D = $Workers
onready var quarry : Quarry = $Quarry
onready var supply_camp : SupplyCamp = $SupplyCamp
onready var trebuchet : Trebuchet = $Trebuchet

export(Array, PackedScene) var worker_types = []

func _ready() -> void:
	cam.current = true
	create_miner()
	create_builder()
	

func create_miner() -> void:
	var new_miner : Node2D = worker_types[0].instance()
	workers.add_child(new_miner)


func create_builder() -> void:
	var new_builder : Node2D = worker_types[1].instance()
	workers.add_child(new_builder)
