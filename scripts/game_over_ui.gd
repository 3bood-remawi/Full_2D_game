extends CanvasLayer

@onready var panel = $Panel
@onready var vbox = panel.get_node("VBoxContainer")
@onready var label = vbox.get_node("Label")
@onready var try_again_button = vbox.get_node("Button")

func _ready() -> void:
	visible = false
	panel.visible = false
	vbox.visible = false
	label.visible = false
	try_again_button.visible = false

	try_again_button.pressed.connect(_on_TryAgainButton_pressed)

func show_ui():
	print("✅ GameOverUI is showing") 
	visible = true
	panel.visible = true
	vbox.visible = true
	label.visible = true
	try_again_button.visible = true

func _on_TryAgainButton_pressed() -> void:
	get_tree().reload_current_scene()
