// Recursos de script v2.3.0
// https://help.yoyogames.com/hc/en-us/articles/360005277377

function scr_personagem_movendo() {
    ///----->> Movimentação

    // Função para retornar o sinal de um número
    function sing(n) {
        if (n > 0) return 1;
        if (n < 0) return -1;
        return 0;
    }

    // Checando as teclas
    direita = keyboard_check(ord("D"));
    esquerda = keyboard_check(ord("A"));
    cima = keyboard_check_pressed(ord("W"));

    // Atualizando a velocidade horizontal
    hveloc = (direita - esquerda) * veloc;

    // Controlando o estado de pulo
    if (estado == "pulando") {
        pulo_timer -= 1;
        if (pulo_timer <= 0) {
            estado = "parado";
        }
    }

    // Verificando as ações do personagem
    if (estado != "pulando") {
        if (cima) {
            estado = "pulando";
            pulo_timer = 60; // Duração do pulo (ajuste conforme necessário)
            if (direita) {
                sprite_index = spr_personagem_pulando_direita;
            } else if (esquerda) {
                sprite_index = spr_personagem_pulando_esquerda;
            } else {
                if (direc == 0) {
                    sprite_index = spr_personagem_pulando_direita;
                } else {
                    sprite_index = spr_personagem_pulando_esquerda;
                }
            }
        } else if (direita) {
            direc = 0;
            estado = "andando";
            sprite_index = spr_personagem_andando_direita;
        } else if (esquerda) {
            direc = 1;
            estado = "andando";
            sprite_index = spr_personagem_andando_esquerda;
        } else {
            estado = "parado";
            if (direc == 0) {
                sprite_index = spr_personagem_parado_direita;
            } else {
                sprite_index = spr_personagem_parado_esquerda;
            }
        }
    }

    // Aplicando a gravidade e verificando colisões com o chão
    if (!place_meeting(x, y + 1, obj_parede)) {
        vveloc += gravidade;
    } else {
        vveloc = 0;
        if (cima) {
            vveloc = -2.8;
        }
    }

    // Verificando colisões horizontais
    if (place_meeting(x + hveloc, y, obj_parede)) {
        while (!place_meeting(x + sing(hveloc), y, obj_parede)) {
            x += sing(hveloc);
        }
        hveloc = 0;
    }

    // Atualizando a posição horizontal
    x += hveloc;

    // Verificando colisões verticais
    if (place_meeting(x, y + vveloc, obj_parede)) {
        while (!place_meeting(x, y + sing(vveloc), obj_parede)) {
            y += sing(vveloc);
        }
        vveloc = 0;
    }

    // Atualizando a posição vertical
    y += vveloc;

    // Verificando colisão com o castelo
    if (place_meeting(x, y, obj_castelo)) {
        room_goto(Room2);
    }
	    if (place_meeting(x, y, obj_porta)) {
        room_goto(Room3);
    }
    // Ataque
    if (keyboard_check_pressed(vk_space)) {
        image_index = 0;
        estado_movendo = scr_personagem_atacando;

        // Criar a hitbox baseada na direção (direc)
        if (direc == 0) {
            var hitbox = instance_create_layer(x + 35, y - 40, "Instances", obj_hitbox);
            hitbox.i = 10; // Definir um valor apropriado para alarm[0]
        } else if (direc == 1) {
            var hitbox = instance_create_layer(x - 35, y - 40, "Instances", obj_hitbox);
            hitbox.i = 10; // Definir um valor apropriado para alarm[0]
        }
    }
}

function scr_personagem_atacando() {
    if (direc == 0) {
        sprite_index = spr_personagem_atacando_direita;
    } else if (direc == 1) {
        sprite_index = spr_personagem_atacando_esquerda;
    }

    if (scr_animation_end()) {
        estado_movendo = scr_personagem_movendo;
    }
}


