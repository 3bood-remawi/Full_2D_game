extends Area2D

@onready var timer: Timer = $Timer
@onready var player: CharacterBody2D = $"../Player"

func _on_body_entered(body: Node2D) -> void:
	print("you died")
	timer.start()

func _on_timer_timeout() -> void:
	player.position = player.last_safe_position
