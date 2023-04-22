class_name Field
extends Node2D

onready var cam : Camera2D = $Cam
onready var workers : Node2D = $Workers
onready var quarry : Quarry = $Quarry
onready var supply_camp : SupplyCamp = $SupplyCamp
onready var trebuchet : Trebuchet = $Trebuchet
onready var command_center : CommandCenter = $CommandCenter

export(Array, PackedScene) var worker_types = []

func _ready() -> void:
	cam.current = true

