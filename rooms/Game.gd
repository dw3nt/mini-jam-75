extends Node2D

signal room_ready
signal room_change_requested


func _ready():
	emit_signal("room_ready")
