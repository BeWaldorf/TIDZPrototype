extends Node



const VERBOSITY : int = SQLite.VERBOSE


#var packaged_db_name :=

static func commit_to_db_tester():
	var db : SQLite = null
	var db_name := "res://data/test"
	db = SQLite.new()
	db.path = db_name
	db.open_db()
	var table_name = "tester"
	var dict : Dictionary = Dictionary()
	dict["Name"] = "This is testuser" + str(randi_range(0,1000))
	dict["Score"] = randi_range(0,50)
	db.insert_row(table_name, dict)


static func read_name_of_highest_field_tester(field:String) -> String:
	var db :SQLite = null
	var db_name :String = "res://data/test"
	db = SQLite.new()
	db.path = db_name
	db.open_db()
	var table_name = "tester"
	var dict : Dictionary = Dictionary()
	db.query("SELECT * FROM "+ table_name + " ORDER BY " + field + " DESC LIMIT 1;")
	return db.query_result[0]["Name"]

static func get_tasks_per_room_id(id:int) -> Array:
	const Task = preload("res://code/Task.gd")
	var db 		: SQLite 		= null
	var db_name	: String 		= "res://data/TIDZ"
	var table 	: String 		= "Tasks"
	var dict	: Dictionary 	= Dictionary() 
	var tasks	: Array			= Array()
	
	db = SQLite.new()
	db.path = db_name
	db.open_db()
	db.query("SELECT * FROM Tasks WHERE room_id = " + str(id) + ";")
	
	if db.query_result.size() == 0:
		printerr("NO QUERY RESULT")
		return tasks
	
	for i in range (0, db.query_result.size()):
		var task = Task.new(db.query_result[i]["ID"], db.query_result[i]["room_id"],
				bool(db.query_result[i]["Is_completed"]), db.query_result[i]["Description"])
		tasks.append(task)
	return tasks



