extends Node2D
var whirlpool_scene = preload("res://scenes/whirlpool.tscn")
@onready var obstacles: Node2D = $"../obstacles"
@onready var viewport = get_viewport().get_visible_rect().size

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
	
func spawn():
	var new_whirlpool = whirlpool_scene.instantiate()
	
	new_whirlpool.position.x = randf_range(viewport.x / 2, -viewport.x / 2)
	new_whirlpool.position.y = randf_range(viewport.y / 2, -viewport.y / 2)
	obstacles.add_child(new_whirlpool)




func _on_area_2d_body_entered(body: Node2D) -> void:
	print("YAY SOMETHING HAS ENTERED")
	EventBus.spawn_new_chunk.emit()
