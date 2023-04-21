class_name Field
extends Node2D

onready var cam : Camera2D = $Cam
onready var workers : Node2D = $Workers

export(Array, PackedScene) var worker_types = []

func _ready() -> void:
	cam.current = true
	create_miner()
	

func create_miner() -> void:
	var new_miner : Node2D = worker_types[0].instance()
	workers.add_child(new_miner)
