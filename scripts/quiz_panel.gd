extends Control
@onready var question_label = $VBoxContainer/QuestionLabel
@onready var option1 = $VBoxContainer/Option1
@onready var option2 = $VBoxContainer/Option2
@onready var option3 = $VBoxContainer/Option3
@onready var result_label = $VBoxContainer/ResultLabel
var correct_answer : int = 0
@onready var nobody_who_chat: NobodyWhoChat = $"../../NobodyWhoModel/NobodyWhoChat"

func _ready():
	_generate_question_ai()
	option1.pressed.connect(_on_option_pressed.bind(option1))
	option2.pressed.connect(_on_option_pressed.bind(option2))
	option3.pressed.connect(_on_option_pressed.bind(option3))
	result_label.gui_input.connect(_on_check_pressed)
func _generate_question_ai():
	var prompt = """
Generate a simple math question for kids with 3 multiple-choice options.
Return only valid JSON in this exact format:
{
	"question": "What is 3 + 4?",
	"options": [6, 7, 8],
	"answer": 7
}
"""
	nobody_who_chat.ask(prompt, self, "_on_ai_response")
	
func _on_ai_response(response: String) -> void:
	var data = {}
	var json = JSON.parse_string(response)
	if typeof(json) == TYPE_DICTIONARY:
		data = json
	else:
		question_label.text = "Error: invalid AI response"
		return
	question_label.text = str(data.get("question", "No question"))
	var options = data.get("options", [])
	correct_answer = data.get("answer", 0)
	if options.size() >= 3:
		option1.text = str(options[0])
		option2.text = str(options[1])
		option3.text = str(options[2])
	result_label.text = "Check"
	result_label.add_theme_color_override("font_color", Color.WHITE)
	option1.set_pressed(false)
	option2.set_pressed(false)
	option3.set_pressed(false)
func _on_option_pressed(button):
	for b in [option1, option2, option3]:
		if b != button:
			b.set_pressed(false)
# لما يضغط Check
func _on_check_pressed(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var selected = ""
		if option1.button_pressed:
			selected = option1.text
		elif option2.button_pressed:
			selected = option2.text
		elif option3.button_pressed:
			selected = option3.text
		if selected == "":
			result_label.text = "Select an answer!"
			result_label.add_theme_color_override("font_color", Color.YELLOW)
			return
		if int(selected) == correct_answer:
			result_label.text = "Good!"
			result_label.add_theme_color_override("font_color", Color.GREEN)
		else:
			result_label.text = "Wrong!"
			result_label.add_theme_color_override("font_color", Color.RED)
		await get_tree().create_timer(2.0).timeout
		_generate_question_ai()
