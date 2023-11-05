extends CheckBox


var task_id : int
var room_id : int
var is_completed : bool
var description : String


func _init(task_id:int, room_id:int, is_completed:bool, description:String):
	disabled = true
	self.task_id = task_id 
	self.room_id = room_id
	self.is_completed = is_completed
	self.description = description
	self.text = create_hud_field()
	self.button_pressed = is_completed
	self.name = "task_"+str(task_id)


func create_hud_field() -> String :
	var hud_str = "Taak #"+ str(task_id) + ": " + description
	return hud_str

