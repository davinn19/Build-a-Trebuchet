class_name Field
extends Node2D

onready var cam : Camera2D = $Cam
onready var workers : Node2D = $Workers
onready var trees : Node2D = $Trees

export(Array, PackedScene) var worker_types = []

func _ready() -> void:
	cam.current = true


func get_tree_resource() -> TreeResource:
	var tree_chosen : TreeResource
	while !tree_chosen:
		var tree_index : int = randi() % trees.get_child_count()
		tree_chosen = trees.get_child(tree_index) as TreeResource
		if !tree_chosen.has_chops():
			tree_chosen = null
	
	return tree_chosen
	
