extends CharacterBody2D


const SPEED = 800.0
const y_multiplier = 5
const acceleration = 20
const buffer = 100
var direction = 0
func _ready() -> void:
	Global.player_node = self
	velocity.x = 0
	
func _physics_process(delta: float) -> void:
	direction = Input.get_axis("up", "down")
	velocity.y = move_toward(velocity.y, SPEED * direction * y_multiplier, acceleration * y_multiplier)
	velocity.x = move_toward(velocity.x, SPEED, acceleration)
	if position.y + buffer > Global.viewport.y/2:
		velocity.y = 0
		position.y = Global.viewport.y/2 - buffer
	elif position.y - buffer < -Global.viewport.y/2:
		velocity.y = 0
		position.y = -Global.viewport.y/2 + buffer
	self.rotation = lerp_angle(self.rotation, direction*45, 10 * delta)
	move_and_slide()
