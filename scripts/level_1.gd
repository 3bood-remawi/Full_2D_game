extends Node2D
@onready var keys_container := $Keys
@onready var panel = $AIPart/QuestionPanel
@onready var question_label = $AIPart/QuestionPanel/VBoxContainer/QuestionLabel
@onready var answer_input = $AIPart/QuestionPanel/VBoxContainer/AnswerInput
@onready var check_button = $AIPart/QuestionPanel/VBoxContainer/CheckButton
@onready var score_label = $NumOfKeysText/MarginContainer/HBoxContainer/NumOfKeys
@onready var chat = $AIPart/NobodyWhoModel/NobodyWhoChat
@onready var game_timer: Timer = $Timer/GameTimer
@onready var player: CharacterBody2D = $Player

var current_question = ""
var current_answer = ""
var ai_active := false 
@onready var door_label: Label = $door_label 

func _ready():
	if GameManager.score >= 10:
			door_label.visible = true
			door_label.text = "Congrats You Solve It All"
	panel.visible = false
	score_label.text = " : " + str(GameManager.score)
	# connect all existing keys
	for k in keys_container.get_children():
		if k is Area2D:
			print("Connected key: ", k.name)
			print("Connected key: ", k.name)
			k.body_entered.connect(_on_key_collected.bind(k))
	check_button.pressed.connect(_on_check_pressed)
	answer_input.text_submitted.connect(func(_t): _on_check_pressed())  # Enter submits
	chat.response_finished.connect(_on_nobody_who_chat_response_finished)


func _on_key_collected(body: Node, key_node: Area2D) -> void:
	if body.name != "Player":
		return
	# حذف المفتاح
	key_node.animation_player.play("PickUpAnimation")
	# تفعيل البانيل
	panel.visible = true
	question_label.text = "AI is thinking..."
	game_timer.paused=true
	player.enable_player()
	_request_ai_question()
	
func _request_ai_question():
	current_question = ""
	current_answer = ""
	question_label.text = "AI is thinking..."
	answer_input.text = ""
	chat.say(""" Give me one simple math question, like 1+1 or 2*2. Format: Question: <the question> """)
func _compute_answer_from_question(q: String) -> String:
	# normalize
	var s := q.strip_edges().to_lower()
	# 1) try symbol form:  5 + 3, 9-4, 2 x 6, 3 × 7, 4*2
	var re1 := RegEx.new()
	re1.compile(r"(-?\d+)\s*([+\-x×*])\s*(-?\d+)")
	var m1 := re1.search(s)
	if m1:
		var a := int(m1.get_string(1))
		var op := m1.get_string(2)
		var b := int(m1.get_string(3))
		var res := 0
		match op:
			"+": res = a + b
			"-": res = a - b
			"x", "×", "*": res = a * b
		return str(res)
	# 2) try word form: "what is 3 plus 4?", "7 minus 2", "6 times 3", "multiply 4 by 2"
	var re2 := RegEx.new()
	re2.compile(r"(-?\d+)\s*(plus|add|minus|subtract|times|multiply|multiplied\s+by)\s*(-?\d+)")
	var m2 := re2.search(s)
	if m2:
		var a := int(m2.get_string(1))
		var word := m2.get_string(2)
		var b := int(m2.get_string(3))
		var res := 0
		match word:
			"plus", "add": res = a + b
			"minus", "subtract": res = a - b
			"times", "multiply", "multiplied by": res = a * b
		return str(res)
	return ""
	
func _on_check_pressed():
	# if the question hasn't arrived or failed to parse
	if current_answer == "":
		question_label.text = "[Please wait for the question, then answer]"
		return

	var player_answer_i := _to_int_safe(answer_input.text)
	var correct_answer_i := _to_int_safe(current_answer)

	if player_answer_i == correct_answer_i:
		question_label.text = "Good!"
		GameManager.score += 1
		if GameManager.score >= 10:
			door_label.visible = true
			door_label.text = "Congrats You Solve It All"
		score_label.text = " : " + str(GameManager.score)
	else:
		question_label.text = "Wrong! The correct answer is " + str(correct_answer_i)
	game_timer.paused=false
	player.move_and_slide()
	# close after a short pause no matter what
	await get_tree().create_timer(1.5).timeout
	_close_question_panel()
	
func _on_nobody_who_chat_response_finished(response: String) -> void:
	current_question = ""
	current_answer = ""

	for line in response.split("\n"):
		if line.begins_with("Question:"):
			var parts := line.split(":", false)
			current_question = parts[1].strip_edges() if parts.size() >= 2 else parts[0].strip_edges()
			break

	if current_question != "":
		current_answer = _compute_answer_from_question(current_question)

	if current_answer == "":
		# parser failed — at least show the question so player isn't stuck
		question_label.text = current_question + "\n[Oops, I couldn't parse the answer. Try another key?]"
	else:
		question_label.text = current_question

	if current_question.length() > 1000:
		current_question = current_question.substr(0, 1000) + "..."

func _to_int_safe(s: String) -> int:
	# trims and converts Arabic-Indic digits too, just in case
	var t := s.strip_edges()
	# normalize arabic-indic numerals ٠١٢٣٤٥٦٧٨٩ → 0..9
	const AR_DIGITS = ["٠","١","٢","٣","٤","٥","٦","٧","٨","٩"]
	for i in AR_DIGITS.size():
		t = t.replace(AR_DIGITS[i], str(i))
	return int(t)

 

func _close_question_panel():
	panel.visible = false
	answer_input.text = ""
	ai_active = false
