extends Area2D

signal goal_reached


func _on_LevelGoal_body_entered(body):
	emit_signal("goal_reached")
