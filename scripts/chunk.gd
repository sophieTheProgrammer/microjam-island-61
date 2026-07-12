extends Node2D
var WHIRLPOOL = preload("res://scenes/whirlpool.tscn")
@onready var obstacles: Node = $"obstacles"
var SHARK = preload("res://scenes/shark.tscn")

var LOG = preload("res://scenes/log.tscn")
var sharks_to_spawn = randi() % 2 + 1
var whirlpools_to_spawn = 1
var logs_to_spawn = -1
var obstacle_spawn = [sharks_to_spawn, whirlpools_to_spawn, logs_to_spawn]
func _ready() -> void:
	if obstacle_spawn[2] != 0:
		if randi() % (3-Global.chunks_since_log) == 0:
			logs_to_spawn = 1
			Global.chunks_since_log = 0
		else:
			Global.chunks_since_log += 1
		obstacle_spawn[2] = logs_to_spawn
	spawn(obstacle_spawn[0], "shark")
	spawn(obstacle_spawn[1], "whirlpool")
	spawn(obstacle_spawn[2], "log")
	
func _process(_delta: float) -> void:
	pass
	
func spawn(num, type):
	for i in range(num):
		var new_obstacle
		if type == "whirlpool":
			new_obstacle = WHIRLPOOL.instantiate()
		elif type == "shark":
			new_obstacle = SHARK.instantiate()
		elif type == "log":
			new_obstacle = LOG.instantiate()
		new_obstacle.name = type
		new_obstacle.position.x = randf_range((Global.viewport.x / 2)-50, 50+(-Global.viewport.x / 2)) + self.position.x
		new_obstacle.position.y = randf_range((Global.viewport.y / 2)-50, 50+(-Global.viewport.y / 2)) + self.position.y
		obstacles.add_child(new_obstacle)



func _on_area_2d_body_entered(_body: Node2D) -> void:
	print("spawning chunk")
	EventBus.spawn_new_chunk.emit()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	#queue_free()
	pass
