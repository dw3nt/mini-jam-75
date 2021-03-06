extends Control

signal room_ready
signal room_change_requested


func _init():
	add_user_signal("music_change_requested")


func _ready():	
	emit_signal("room_ready")
