class_name StartMenu
extends Control

signal start;

@onready var play_button: TextureButton = $PlayButton
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	play_button.pressed.connect(_start_trans);
	animation_player.play("RESET")
	animation_player.play("wobble")

func _start_trans():
	animation_player.animation_finished.connect(anim_done)
	animation_player.play("transition")

func anim_done(name:String) -> void:
	if(name == "transition"):
		start.emit();
