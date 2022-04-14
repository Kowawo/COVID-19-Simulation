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
