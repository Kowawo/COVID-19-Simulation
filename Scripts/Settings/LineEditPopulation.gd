extends LineEdit


var regex = RegEx.new()
var oldtext = ""


func _ready():
	regex.compile("^$|^[1-9]{1}[0-9]*$")


func _on_LineEdit_text_changed(new_text):
	if (regex.search(new_text)):
		text = new_text
		oldtext = text
	else:
		text = oldtext
		
	set_cursor_position(text.length())
	
	# Hinweis für die Kantenlänge
	var hoverNote = get_node("/root/Settings/TabContainer/Settings/HoverNote")
	if (oldtext != ""):
		hoverNote.set_text("Attention: Edge length must be at least " + str(ceil(sqrt(int(oldtext) * PI * 0.4))) + " meters")
	else :
		hoverNote.set_text("")
