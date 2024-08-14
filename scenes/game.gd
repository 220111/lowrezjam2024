class_name Game
extends Node2D

enum Mode {
	NONE,
	COFFEE,
	TEA,
	COOKIE,
	MONEY
}

signal game_over

const CAT = preload("res://scenes/cat.tscn")

@onready var player: Player = $CharacterBody2D
@onready var ui: UI = $UI
@onready var cat_timer: Timer = $CatTimer

@export var cat_spots: Array[Vector2]

@onready var register: Tool = $Register
@onready var tea: Tool = $Tea
@onready var coffee: Tool = $Coffee
@onready var cookie_case: Tool = $CookieCase
@onready var health_progress_bar: TextureProgressBar = $UI/HealthProgressBar

var cat_waittime: float = 45.0;
var mode: Mode = Mode.NONE
var cats: Array[Cat] = []
var orders_done: Array[int] = []
var score: int = 0
var lives: int = 3

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
	if(mode == Mode.NONE):
		return
	player.start_action_mode()
	ui.progress_done.connect(player.end_action_mode, CONNECT_ONE_SHOT)
	match mode:
		Mode.COFFEE:
			ui.progress_done.connect(player.add_coffee, CONNECT_ONE_SHOT)
			coffee.play_fx()
		Mode.TEA:
			ui.progress_done.connect(player.add_tea, CONNECT_ONE_SHOT)
			tea.play_fx()
		Mode.COOKIE:
			ui.progress_done.connect(player.add_cookie, CONNECT_ONE_SHOT)
			cookie_case.play_fx()
		Mode.MONEY:
			ui.progress_done.connect(_clear_paid_cats, CONNECT_ONE_SHOT)
			register.play_fx()
		_:
			printerr("unimplemented action")
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
	cat.order_incorrect.connect(failed_cat.bind(spawn_spot), CONNECT_ONE_SHOT)
	cat.order_filled.connect(order_success.bind(spawn_spot), CONNECT_ONE_SHOT)
	add_child(cat)
	print(cat_waittime)
	cat.init_timer(cat_waittime)
	cat_waittime *= 0.98;

func failed_cat(index: int):
	if(cats[index]):
		lives -= 1;
		health_progress_bar.value = lives
		if (lives <= 0):
			game_over.emit(score)
		clear_cat(index)

func clear_cat(index: int):
	if(cats[index]):
		cats[index].free_self()
		cats[index].death_anim_done.connect(cat_gone.bind(index))

func cat_gone(index: int):
	if(cats[index]):
		cats[index].queue_free()
		cats[index] = null
		

func order_success(index: int):
	orders_done.append(index)

func _clear_paid_cats():
	for i in orders_done:
		score += 100
		clear_cat(i)
	orders_done.clear()
	ui.update_score(score)
