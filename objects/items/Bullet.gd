extends KinematicBody2D

const MOVE_SPEED = 200

var canApplyCharge = true
var dir = Vector2.ZERO
var moveDir = Vector2.RIGHT
var isResetBullet = false

onready var sprite = $Sprite
onready var collisionShape = $CollisionShape2D
onready var anim = $AnimationPlayer


func _ready():
	rotation = get_angle_to(dir)
	moveDir = moveDir.rotated(rotation)
	
	sprite.self_modulate = Color("#5694ff")
	
func setAsReset():
	isResetBullet = true
	sprite.self_modulate = Color("#fff456")


func _physics_process(delta):
	move_and_slide(MOVE_SPEED * moveDir, Vector2.ZERO, false, 4, PI / 4, false)
	
	if get_slide_count() > 0:
		moveDir = Vector2.ZERO
		for index in get_slide_count():
			var collision = get_slide_collision(index)
			if collision.collider.is_in_group('moveable_obstacle') && canApplyCharge:
				if !isResetBullet:
					collision.collider.addFloatCharge()
				else:
					collision.collider.resetGravity()
				canApplyCharge = false
				collisionShape.disabled = true
				
		anim.play("hit")
