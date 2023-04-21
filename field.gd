class_name Field
extends Node2D

onready var cam : Camera2D = $Cam
onready var workers : Node2D = $Workers

export(Array, PackedScene) var worker_types = []

func _ready() -> void:
	cam.current = true
	
	

