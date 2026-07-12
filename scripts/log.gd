extends Node2D
@onready var sprite: Sprite2D = $Sprite2D
var rand_x = position.x
var rand_y = position.y
var min_wait_time = 1
var max_wait_time = 5 - min_wait_time
var velocity = Vector2.ZERO
var min_speed = 3
var max_speed = 6 - min_speed
var speed = 4.0
const ACCELERATION = 4
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#look_at(Vector2(rand_x, rand_y))
	#self.rotate(PI/2)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += 250*delta
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	EventBus.player_attaches_to_log.emit(self)
	


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	await get_tree().create_timer(2.0).timeout
	queue_free()
