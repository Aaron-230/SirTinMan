extends CharacterBody2D

@export var Damage: int = 5

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var Target = null
var Attack = false

@onready var Sprite: AnimatedSprite2D = $Sprite

func _physics_process(delta: float):
	Sprite.play("Idle")
	
	if Target != null and Attack:
		Target.takeDamage(Damage)
		await get_tree().create_timer(1).timeout
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction = (Target.global_position - global_position).normalised()
	if direction:
		velocity.x = direction * SPEED
		Sprite.flip_h = true if velocity.x < 0 else false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func _on_hitbox_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		Attack = true

func _on_sight_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		Target = body

func _on_sight_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Target = body

func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Attack = false
