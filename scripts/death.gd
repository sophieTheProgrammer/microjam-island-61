extends Area2D

@export var is_whirlpool = false

func _on_body_entered(_body: Node2D) -> void:
	if !Global.DEBUG_DEATH:
		if is_whirlpool:
			var tween = create_tween()
			_body.look_at(Vector2(global_position))
			tween.set_parallel(true)
			tween.tween_property(_body, "scale", Vector2(0,0),1)
			tween.tween_property(_body, "position", global_position,1)
			
			print("tweening")
		print("dying shall commence now")
		EventBus.game_over.emit()
