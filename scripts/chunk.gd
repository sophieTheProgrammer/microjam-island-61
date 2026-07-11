extends Node2D
var WHIRLPOOL = preload("res://scenes/whirlpool.tscn")
@onready var obstacles: Node = $"obstacles"
var SHARK = preload("res://scenes/shark.tscn")
var sharks_to_spawn = 3
var whirlpools_to_spawn = 1
func _ready() -> void:
	spawn(whirlpools_to_spawn, "whirlpool")
	spawn(sharks_to_spawn, "shark")
func _process(_delta: float) -> void:
	pass
	
func spawn(num, type):
	for i in range(num):
		var new_obstacle
		if type == "whirlpool":
			new_obstacle = WHIRLPOOL.instantiate()
		else:
			new_obstacle = SHARK.instantiate()
		new_obstacle.name = type
		new_obstacle.position.x = randf_range(Global.viewport.x / 2, -Global.viewport.x / 2) + self.position.x
		new_obstacle.position.y = randf_range(Global.viewport.y / 2, -Global.viewport.y / 2) + self.position.y
		obstacles.add_child(new_obstacle)



func _on_area_2d_body_entered(_body: Node2D) -> void:
	EventBus.spawn_new_chunk.emit()
	
	


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
