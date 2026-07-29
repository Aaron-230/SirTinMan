extends CharacterBody2D

@export var Damage: int = 5

const SPEED = 50.0
const JUMP_VELOCITY = -400.0

var Target = null
var Attack = false
var canAttack = true

@onready var Sprite: AnimatedSprite2D = $Sprite
@onready var AttackTimer: Timer = $AttackTimer

@onready var WallDetectionLeft: RayCast2D = $Raycasts/WallDetectionLeft
@onready var WallDetectionRight: RayCast2D = $Raycasts/WallDetectionRight

func _physics_process(delta: float):
	Sprite.play("Idle")
	
	if Target != null and Attack and canAttack:
		Target.takeDamage(Damage)
		canAttack = false
		AttackTimer.start()
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Target != null:
		var direction = (Target.global_position - global_position).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			Sprite.flip_h = true if velocity.x < 0 else false
		elif WallDetectionLeft.is_colliding() or WallDetectionRight.is_colliding():
			velocity.y = JUMP_VELOCITY
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func _on_hitbox_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		Attack = true

func _on_sight_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		Target = body

func _on_sight_body_exited(body: Node2D):
	if body.is_in_group("Player"):
		Target = body

func _on_hitbox_body_exited(body: Node2D):
	if body.is_in_group("Player"):
		Attack = false

func _on_attack_timer_timeout():
	canAttack = true
