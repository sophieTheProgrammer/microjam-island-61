class_name player
extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D

const SPEED = 500
const y_multiplier = 5
const acceleration = 10
const buffer = 50
var log_ref = null
var direction = 0
func _ready() -> void:
	Global.player_node = self
	EventBus.player_attaches_to_log.connect(attach_to_log)
	EventBus.deattached_log.connect(detach_from_log)
	velocity.x = 0
	
func _physics_process(delta: float) -> void:
	if not Global.game_is_running:
		cpu_particles_2d.hide()
		animated_sprite_2d.stop()
		animated_sprite_2d.frame = 3
		Global.is_decreasing = false
		Global.attached = false
	else:
		if Global.attached and Global.game_is_running:
				self.position.x = move_toward(self.position.x, log_ref.position.x, 10)
				self.position.y = move_toward(self.position.y, log_ref.position.y, 10)
			#log_ref.velocity = self.velocity
		else:
			cpu_particles_2d.show()
		if Input.is_action_just_pressed("escapethelog"):
			detach_from_log()
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

func attach_to_log(log_ref):
	print("attaching shall commence")
	cpu_particles_2d.hide()
	Global.attached = true
	self.log_ref = log_ref
	animated_sprite_2d.stop()
	animated_sprite_2d.frame = 3
	

func detach_from_log():
	EventBus.player_deattaches_to_log.emit()
	cpu_particles_2d.show()
	Global.attached = false
	animated_sprite_2d.play()
