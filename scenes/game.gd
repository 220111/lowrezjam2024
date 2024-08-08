class_name Game
extends Node2D

enum Mode {
	NONE,
	COFFEE,
	TEA,
	COOKIE,
	MONEY
}

const CAT = preload("res://scenes/cat.tscn")

@onready var player: Player = $CharacterBody2D
@onready var ui: UI = $UI
@onready var cat_timer: Timer = $CatTimer

@export var cat_spots: Array[Vector2]

var mode: Mode = Mode.NONE
var cats: Array[Cat] = []
var orders_done: Array[int] = []
var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.action_pressed.connect(run_action)
	player.items_updated.connect(ui.update_items)
	cats.resize(cat_spots.size())
	_spawn_cat()
	cat_timer.timeout.connect(_spawn_cat)
	


func run_action():
	if(player.is_in_action_mode()):
		return
	player.start_action_mode()
	ui.progress_done.connect(player.end_action_mode, CONNECT_ONE_SHOT)
	match mode:
		Mode.COFFEE:
			ui.progress_done.connect(player.add_coffee, CONNECT_ONE_SHOT)
		Mode.TEA:
			ui.progress_done.connect(player.add_tea, CONNECT_ONE_SHOT)
		Mode.COOKIE:
			ui.progress_done.connect(player.add_cookie, CONNECT_ONE_SHOT)
		Mode.MONEY:
			ui.progress_done.connect(_clear_paid_cats, CONNECT_ONE_SHOT)
		_:
			print("unimplemented")
	ui.start_progress()

#func _process(delta: float) -> void:
	#print("score is " + str(score))

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

func _spawn_cat():
	var empty: Array[int] = []
	for i in range(cats.size()):
		if cats[i] == null:
			empty.append(i)
	if(empty.size() == 0):
		cat_timer.start(cat_timer.wait_time)
		return
	cat_timer.start(cat_timer.wait_time*0.9)
	var spawn_spot: int = empty[randi_range(0, empty.size()-1)]
	var cat := CAT.instantiate();
	cat.global_position = cat_spots[spawn_spot]
	cats[spawn_spot] = cat
	cat.order_incorrect.connect(clear_cat.bind(spawn_spot), CONNECT_ONE_SHOT)
	cat.order_filled.connect(order_success.bind(spawn_spot), CONNECT_ONE_SHOT)
	add_child(cat)

func clear_cat(index: int):
	if(cats[index]):
		cats[index].queue_free()
		cats[index] = null

func order_success(index: int):
	orders_done.append(index)

func _clear_paid_cats():
	for i in orders_done:
		score += 1
		clear_cat(i)
	orders_done.clear()
	ui.update_score(score)
