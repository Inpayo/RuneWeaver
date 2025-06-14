extends HBoxContainer

signal set_vars

var SPs = {0: [null, null, null, null], 1: [null, null, null, null], 2: [null, null, null, null], 3: [null, null, null, null]}
var CSPI = 0
var CSP = 0
var SPCL = 0

var ComPicMap = {"Trap": preload("res://Assets/Sprites/coin.png"), 
"Blast": preload("res://Assets/Sprites/coin.png"), 
"Fire": preload("res://Assets/Sprites/blast_fire.png"), 
"Wind": preload("res://Assets/Sprites/blast_wind.png"), 
"Earth": preload("res://Assets/Sprites/blast_rock.png"), 
"Ice": preload("res://Assets/Sprites/blast_ice.png"), 
"SizeUp": preload("res://Assets/Sprites/coin.png"), 
"Knockback": preload("res://Assets/Sprites/coin.png"), 
"Power": preload("res://Assets/Sprites/coin.png"), 
"Speed": preload("res://Assets/Sprites/coin.png"), 
null: null}

var ComBilMap = {0: "TextureRect/Control/In1", 1: "TextureRect/Control/In2", 2: "TextureRect/Control/In3", 3: "TextureRect/Control/In4"}

func Show_list(index: int) -> void:
	$TextureRect2/Control/Elem.visible = index == 0
	$TextureRect2/Control/MOrN.visible = index == 1
	$TextureRect2/Control/Augs.visible = index >= 2
	
func _process(delta):
	pass

func _on_in_1_pressed() -> void:
	SPs[CSP][0] = null
	where_to_add()
	Update_the_damn_image()
	Show_list(CSPI)


func _on_in_2_pressed() -> void:
	SPs[CSP][1] = null
	where_to_add()
	Update_the_damn_image()
	Show_list(CSPI)


func _on_in_3_pressed() -> void:
	SPs[CSP][2] = null
	where_to_add()
	Update_the_damn_image()
	Show_list(CSPI)


func _on_in_4_pressed() -> void:
	SPs[CSP][3] = null
	where_to_add()
	Update_the_damn_image()
	Show_list(CSPI)

func where_to_add():
	var temp = SPs[CSP]
	CSPI = -1
	for i in range(temp.size()):
		if temp[i] == null:
			CSPI = i
			break

func Change_component(Nuts):
	if CSPI != -1:
		SPs[CSP][CSPI] = Nuts


func _on_trap_pressed() -> void:
	Change_component("Trap")
	reset_UI()


func _on_blast_pressed() -> void:
	Change_component("Blast")
	reset_UI()


func _on_fire_pressed() -> void:
	Change_component("Fire")
	reset_UI()


func _on_wind_pressed() -> void:
	Change_component("Wind")
	reset_UI()


func _on_earth_pressed() -> void:
	Change_component("Earth")
	reset_UI()


func _on_ice_pressed() -> void:
	Change_component("Ice")
	reset_UI()


func _on_size_up_pressed() -> void:
	Change_component("SizeUp")
	reset_UI()


func _on_knockback_pressed() -> void:
	Change_component("Knockback")
	reset_UI()


func _on_power_pressed() -> void:
	Change_component("Power")
	reset_UI()


func _on_speed_pressed() -> void:
	Change_component("Speed")
	reset_UI()



func Update_the_damn_image():
	var Current_look = SPs[CSP]
	for i in range(4):
		var current_In = get_node(ComBilMap[i])
		current_In.icon = ComPicMap[SPs[CSP][i]]


func _on_md_pressed() -> void:
	CSP = max(CSP-1, 0)
	reset_UI()

func _on_mu_pressed() -> void:
	CSP = min(CSP+1, 3)
	reset_UI()

func reset_UI():
	where_to_add()
	Update_the_damn_image()
	Show_list(CSPI)
	print(SPs)


func _on_button_pressed() -> void:
	var i = get_parent().get_parent()
	if i.visible == false:
		if SPs[0][0] == null or SPs[0][1] == null:
			SPs[0] = [null,null,null,null]
		if SPs[1][0] == null or SPs[1][1] == null:
			SPs[1] = [null,null,null,null]
		if SPs[2][0] == null or SPs[2][1] == null:
			SPs[2] = [null,null,null,null]
		if SPs[3][0] == null or SPs[3][1] == null:
			SPs[3] = [null,null,null,null]
	emit_signal("set_vars")
