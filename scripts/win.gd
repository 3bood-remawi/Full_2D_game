extends TextureRect


@onready var title: Label = $"../TitleOverlay/TitleLabel"
@export var pause_on_show: bool = false  

func show_banner(text: String) -> void:
	if pause_on_show:
		get_tree().paused = true
		process_mode = Node.PROCESS_MODE_WHEN_PAUSED 
	title.text = text
	title.modulate.a = 0.0
	title.scale = Vector2(0.85, 0.85)
	var t := create_tween()
	t.tween_property(title, "modulate:a", 1.0, 0.20)
	t.parallel().tween_property(title, "scale", Vector2.ONE, 0.30).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _ready() -> void:
	show_banner("🎉 CONGRATULATIONS! You Won The Game! 🎉")


func _on_play_button_pressed() -> void:
	GameManager.start_game()
	queue_free()


func _on_exit_button_pressed() -> void:
	GameManager.exit_game()
