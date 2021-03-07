extends Node2D

signal room_ready
signal room_change_requested

const BULLET_SCENE = preload("res://objects/items/Bullet.tscn")

var currentLevel = null

onready var levelWrap = $Level
onready var player = $Player
onready var bulletsWrap = $Bullets


func _ready():
	currentLevel = levelWrap.get_child(0)
	player.global_position = currentLevel.playerSpawnPos.position
	
	player.connect("bullet_fired", self, "_on_Player_bullet_fired")
	
	emit_signal("room_ready")
	
	
func _input(event):
	if event.is_action_pressed("reset_level"):
		var oldLevel = currentLevel
		var newLevel = load(currentLevel.filename).instance()
		levelWrap.remove_child(oldLevel)
		levelWrap.add_child(newLevel)
		currentLevel = newLevel
		oldLevel.queue_free()
		player.global_position = currentLevel.playerSpawnPos.position
	
	
func _on_Player_bullet_fired(target, isResetCharge):
	if (target.x < player.global_position.x && player.sprite.flip_h) || (target.x > player.global_position.x && !player.sprite.flip_h):
		var inst = BULLET_SCENE.instance()
		inst.global_position = player.bulletSpawnPost.global_position
		inst.dir = target
		bulletsWrap.add_child(inst)
		
		if isResetCharge:
			inst.setAsReset()
