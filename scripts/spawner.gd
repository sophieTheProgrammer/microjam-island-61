extends Node2D


var chunk = preload("res://scenes/chunk.tscn")
var chunks_spawned = 0
func _ready() -> void:
	EventBus.spawn_new_chunk.connect(spawn_chunk)
	spawn_chunk()

func _process(delta: float) -> void:
	pass
	
func spawn_chunk():
	var new_chunk = chunk.instantiate()
	new_chunk.position.x = (chunks_spawned * Global.viewport.x)
	self.add_child.call_deferred(new_chunk)
	chunks_spawned+=1
	
	
