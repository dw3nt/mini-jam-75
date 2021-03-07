extends KinematicBody2D

const MOVE_SPEED = 200

var canApplyCharge = true
var canBounce = true
var dir = Vector2.ZERO
var moveDir = Vector2.RIGHT
var isResetBullet = false

onready var sprite = $Sprite
onready var collisionShape = $CollisionShape2D
onready var anim = $AnimationPlayer
onready var bounceAudio = $BounceAudio
onready var wallAudio = $WallAudio


func _ready():
	rotation = get_angle_to(dir)
	moveDir = moveDir.rotated(rotation)
	
	sprite.self_modulate = Color("#5694ff")
	
func setAsReset():
	isResetBullet = true
	sprite.self_modulate = Color("#fff456")
	
	
func stopBullet():
	moveDir = Vector2.ZERO
	anim.play("hit")
	canApplyCharge = false
	collisionShape.disabled = true


func _physics_process(delta):
	move_and_slide(MOVE_SPEED * moveDir, Vector2.ZERO, false, 4, PI / 4, false)
	
	if get_slide_count() > 0:
		for index in get_slide_count():
			var collision = get_slide_collision(index)
			if (collision.collider.is_in_group('moveable_obstacle') || collision.collider.is_in_group('player')) && canApplyCharge:
				if !isResetBullet:
					collision.collider.addFloatCharge()
				else:
					collision.collider.resetGravity()
				
				stopBullet()
			elif collision.collider.is_in_group('reflecting') && canApplyCharge && canBounce:
				moveDir = moveDir.bounce(collision.normal)
				look_at(global_position + (moveDir * 100))
				bounceAudio.play()
				canBounce = false
				set_deferred("canBounce", true)	 # let it bounce of other mirrors, but only hit current mirror once
			elif collision.collider is TileMap:
				stopBullet()
				wallAudio.play()
