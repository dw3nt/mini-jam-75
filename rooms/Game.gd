extends Node2D

signal room_ready
signal room_change_requested

const BULLET_SCENE = preload("res://objects/items/Bullet.tscn")

onready var player = $Player
onready var bulletsWrap = $Bullets


func _ready():
	player.connect("bullet_fired", self, "_on_Player_bullet_fired")
	
	emit_signal("room_ready")
	
	
func _on_Player_bullet_fired(target, isResetCharge):
	if (target.x < player.global_position.x && player.sprite.flip_h) || (target.x > player.global_position.x && !player.sprite.flip_h):
		var inst = BULLET_SCENE.instance()
		inst.global_position = player.bulletSpawnPost.global_position
		inst.dir = target
		bulletsWrap.add_child(inst)
		
		if isResetCharge:
			inst.setAsReset()
