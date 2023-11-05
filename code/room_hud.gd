extends Node


@export var patient_name:String = "naam"
@export var patient_description:String = "beschrijving"
@export var kamer_info:String = "kamer info"
@export var room_id:int = 0 
const Task = preload("res://code/Task.gd")
const DB = preload("res://code/tidz_db.gd")


func _ready():
	var tasks:Array = DB.get_tasks_per_room_id(room_id)
	for task in tasks:
		print(task.name)
		$TaskBox.add_child(task)
	


func _process(delta):
	pass


func task_completed(completed_task_id: int):
	var iterator : int = 0
	while completed_task_id != iterator && iterator < 99:
		iterator = iterator + 1
	if iterator == 99:
		printerr("Task Not Found.")
	var task_node_path : String = "task_" + str(iterator)
	
	var completed_task : Task = $TaskBox.get_node(task_node_path)
	completed_task.is_completed = true
	completed_task.button_pressed = true
	
