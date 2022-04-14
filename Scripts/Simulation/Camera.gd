extends Camera

var sens_for_mouse_input = 0.1
var sens_for_key_input = 0.3


func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == 2:
		var movement = event.relative
		self.rotation.x += - deg2rad(movement.y * sens_for_mouse_input)
		self.rotation.x = clamp(self.rotation.x, deg2rad( - 90), deg2rad(90))
		self.rotation.y += - deg2rad(movement.x * sens_for_mouse_input)

func _process(_delta):
	if Input.is_action_just_pressed("change_mode"):
		if Input.get_mouse_mode() == 0:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else :
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.get_mouse_mode() == 2:
		if Input.is_action_pressed("change_sens_for_key_input"):
			sens_for_key_input = 1
		else :
			sens_for_key_input = 0.3
		
		
		if Input.is_action_pressed("ui_down"):
			self.translation += self.global_transform.basis.z * sens_for_key_input
		if Input.is_action_pressed("ui_up"):
			self.translation -= self.global_transform.basis.z * sens_for_key_input
		if Input.is_action_pressed("ui_right"):
			self.translation += self.global_transform.basis.x * sens_for_key_input
		if Input.is_action_pressed("ui_left"):
			self.translation -= self.global_transform.basis.x * sens_for_key_input
		if Input.is_action_pressed("ui_fly"):
			self.translation.y += 0.5 * sens_for_key_input
		if Input.is_action_pressed("ui_fall"):
			self.translation.y -= 0.5 * sens_for_key_input
