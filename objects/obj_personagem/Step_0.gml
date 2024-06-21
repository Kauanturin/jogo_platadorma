

if vida >0{script_execute(estado_movendo);


// ------>> combate

if alarm[0] > 0{
	if image_alpha >=1{
		alfa_hit = -0.05;
	}else if image_alpha <=0{
		alfa_hit = 0.05;
	}
	image_alpha += alfa_hit;
}else{
	image_alpha = 1;
}

}

if (vida <= 0) {
    sprite_index = sprite_morrendo;
    if (scr_animation_end()) {
        room_restart();
    }
}
