extends Node2D

var time_left := 30
@onready var time_label = get_node("CanvasLayer/Panel/Label")
@onready var game_timer = $GameTimer
@onready var player = get_node("../Player")
@onready var game_over_ui = get_node("../TryAgainPanel")

func _ready():
	update_time_label()
	game_timer.wait_time = 1
	game_timer.timeout.connect(_on_game_timer_timeout)
	game_timer.start()

func update_time_label():
	var minutes = time_left / 60
	var seconds = time_left % 60
	time_label.text = "Time: %02d:%02d" % [minutes, seconds]

	if time_left <= 10:
		time_label.add_theme_color_override("font_color", Color.RED)
	else:
		time_label.add_theme_color_override("font_color", Color.WHITE)

func _on_game_timer_timeout() -> void:
	time_left -= 1
	update_time_label()

	if time_left <= 0:
		game_timer.stop()
		player.disable_player()
		game_over_ui.show_ui()

func increase_time(amount: int):
	time_left += amount
	update_time_label()
