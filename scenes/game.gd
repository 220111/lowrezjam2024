class_name Game
extends Node2D

enum Mode {
	NONE,
	COFFEE,
	TEA,
	COOKIE,
	MONEY
}

const COFFEE_INDEX : int = 0;
const TEA_INDEX : int = 1;
const COOKIE_INDEX : int = 2;

@export var cat_spots: Array[Vector2]

var mode: Mode = Mode.NONE
var items: Array[int] = [0,0,0];

@onready var player: Player = $CharacterBody2D
@onready var ui: UI = $UI



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.action_pressed.connect(run_action)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func run_action():
	player.start_action_mode()
	ui.progress_done.connect(player.end_action_mode, CONNECT_ONE_SHOT)
	ui.start_progress()


func set_coffee_mode():
	mode = Mode.COFFEE

func set_tea_mode():
	mode = Mode.TEA

func set_cookie_mode():
	mode = Mode.COOKIE

func set_money_mode():
	mode = Mode.MONEY

func set_none_mode():
	mode = Mode.NONE
