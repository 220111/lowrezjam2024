class_name UI
extends Control

signal progress_done

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_progress_bar.hide()

func start_progress():
	texture_progress_bar.show()
	animation_player.play("progress bar")

func _anim_done(name: StringName) -> void:
	if(name == "progress bar"):
		texture_progress_bar.hide()
		progress_done.emit()
