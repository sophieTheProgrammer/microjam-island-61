extends Node2D


var chunk = preload("res://scenes/chunk.tscn")
var chunks_spawned = 0
func _ready() -> void:
	EventBus.spawn_new_chunk.connect(spawn_chunk)
	spawn_obstacleless_chunk()
	spawn_obstacleless_chunk()

func _process(_delta: float) -> void:
	pass
	
func spawn_chunk():
	var new_chunk = chunk.instantiate()
	new_chunk.position.x = (chunks_spawned * Global.viewport.x)
	self.add_child.call_deferred(new_chunk)
	chunks_spawned += 1
	
func spawn_obstacleless_chunk():
	var new_chunk = chunk.instantiate()
	new_chunk.position.x = (chunks_spawned * Global.viewport.x)
	var i := 0
	while i < new_chunk.obstacle_spawn.size():
		new_chunk.obstacle_spawn[i] = 0
		i += 1
	self.add_child.call_deferred(new_chunk)
	new_chunk.get_node("Waves").hide()
	chunks_spawned += 1
	
