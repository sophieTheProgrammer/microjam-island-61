extends Node2D

@onready var obstacles: Node2D = $"../obstacles"
@onready var viewport = get_viewport().get_visible_rect().size
var chunk = preload("res://scenes/chunk.tscn")
func _ready() -> void:
	spawn_chunk()
func _process(delta: float) -> void:
	pass
func spawn_chunk():
	var new_chunk = chunk.instantiate()
	self.add_child(new_chunk)
	viewport.x
