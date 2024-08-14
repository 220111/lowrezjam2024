class_name UI
extends Control

signal progress_done

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
@onready var score_label: Label = $ScoreLabel
@onready var tea_label: Label = $Control/HBoxContainer/HBoxContainer/TeaLabel
@onready var cookie_label: Label = $Control/HBoxContainer/HBoxContainer2/CookieLabel
@onready var coffee_label: Label = $Control/HBoxContainer/HBoxContainer3/CoffeeLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_progress_bar.hide()

func start_progress():
	texture_progress_bar.show()
	animation_player.play("progress bar")

func _anim_done(anim_name: StringName) -> void:
	if(anim_name == "progress bar"):
		texture_progress_bar.hide()
		progress_done.emit()

func update_score(score: int):
	score_label.text = str(score)

func update_items(items: Array[int]):
	print(items)
	coffee_label.text = str(items[0])
	tea_label.text = str(items[1])
	cookie_label.text = str(items[2])
