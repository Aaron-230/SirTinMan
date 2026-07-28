extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var isAlive: bool = true

@onready var Sprite: AnimatedSprite2D = $Sprite

func _physics_process(delta: float):
	if isAlive:
		if not is_on_floor():
			velocity += get_gravity() * delta
			Sprite.play("Jump")

		if Input.is_action_just_pressed("Jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		var direction := Input.get_axis("Left", "Right")
		if direction:
			velocity.x = direction * SPEED
			Sprite.flip_h = true if velocity.x < 0 else false
			Sprite.play("Walk")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			Sprite.play("Idle")
		
		move_and_slide()

func takeDamage(amount):
	GameManager.takeDamage(amount)
	Sprite.play("Hurt")
