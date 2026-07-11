extends CharacterBody2D


const SPEED = 800.0
const y_multiplier = 2
const acceleration = 10
var direction = 0
func _ready() -> void:
	velocity.x = 0
func _physics_process(delta: float) -> void:
	var viewport := get_viewport_rect().size
	direction = Input.get_axis("up", "down")
	print(direction)
	velocity.y = move_toward(velocity.y, SPEED * direction * y_multiplier, acceleration * y_multiplier)
	velocity.x = move_toward(velocity.x, SPEED, acceleration)
	#if position.y > viewport.y/2:
		#velocity.y = 0
		#position.y = viewport.y
	move_and_slide()
