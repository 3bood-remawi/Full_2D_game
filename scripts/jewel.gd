extends Area2D

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		var game = get_node_or_null("../../Timer")
		if game:
			game.increase_time(15)
		else:
			print("❌ Timer غير موجود في المسار المحدد")
		queue_free()
