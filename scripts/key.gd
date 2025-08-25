# Key.gd
extends Area2D

@export var quiz_panel: Control        
@export var remove_after_pickup := true
@export var pause_game_on_open := true
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:	
	if body.is_in_group("player"):
		if quiz_panel:
			quiz_panel.show()

		quiz_panel.grab_focus() 
		
		if pause_game_on_open:
			get_tree().paused = true
			if remove_after_pickup:
				animation_player.play("PickUpAnimation")
