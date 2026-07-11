extends Node2D

var whirlpool_scene = preload("uid://2h64y5eyev36")
@onready var obstacles: Node2D = $"../obstacles"
@onready var viewport = get_viewport().get_visible_rect().size

func _ready() -> void:
	for i in range(5):
		spawn()


func spawn():
	var new_whirlpool = whirlpool_scene.instantiate()
	
	new_whirlpool.position.x = randf_range(viewport.x / 2, -viewport.x / 2)
	new_whirlpool.position.y = randf_range(viewport.y / 2, -viewport.y / 2)
	obstacles.add_child(new_whirlpool)
