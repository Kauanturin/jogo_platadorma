/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
if vida >0{

if place_meeting(x,y, obj_parede_inimigo){
	if direc == 0{
		direc = 1;
	}else if direc ==1{
		direc=0;
	
	}
}
if direc == 0{
	x += veloc;
	sprite_index = spr_inimigo_andando_direita;
}else if direc == 1{
	x-=veloc;
	sprite_index = spr_inimigo_andando_esquerda;
}

// Evento Step
// Aplicar a gravidade
velocidade_vertical += gravidade;

// Atualizar a posição vertical do inimigo
y += velocidade_vertical;

// Verificar colisão com o chão (ou plataforma)
if (place_meeting(x, y, obj_parede)) {
    // Ajustar a posição para que o inimigo não fique "afundado" no chão
    while (place_meeting(x, y, obj_parede)) {
        y -= 1;
    }
    // Resetar a velocidade vertical ao colidir com o chão
    velocidade_vertical = 0;
}
}
if vida <=0{
	sprite_index= sprite_morrendo;
	if scr_animation_end(){
		instance_destroy();
	}
}