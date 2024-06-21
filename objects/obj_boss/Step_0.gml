/// @description Evento Step do obj_boss

if (vida > 0) {
    // Estado de ataque
    if (estado == "atacando") {
        // Define o sprite de ataque dependendo da direção
        if (direc == 0) {
            sprite_index = spr_boss_atacando_direita;
        } else if (direc == 1) {
            sprite_index = spr_boss_atacando_esquerda;
        }

        // Lança projétil se ainda não foi lançado
        if (!projeteis_lancados) {
            projeteis_lancados = true;
            var proj;
            if (direc == 0) {
                proj = instance_create_layer(x + 16, y - 90, "Instances", obj_bola_de_fogo);
                proj.direction = 0; // Direção para a direita
            } else {
                proj = instance_create_layer(x - 16, y - 90, "Instances", obj_bola_de_fogo);
                proj.direction = 180; // Direção para a esquerda
            }
            proj.speed = 4; // Velocidade do projétil
        }

        // Verifica se a animação de ataque terminou
        if (image_index >= image_number - 1) {
            estado = "movendo";
            projeteis_lancados = false; // Resetar para lançar projéteis na próxima vez que atacar
        }
    } else if (estado == "movendo") {
        // Movimentação e atualização do sprite
        if (direc == 0) {
            // Verifica colisão com parede à direita
            if (place_meeting(x + veloc, y, obj_parede_inimigo)) {
                x -= veloc; // Ajusta a posição para fora da parede
                direc = 1;
                estado = "atacando";
            } else {
                x += veloc;
                sprite_index = spr_boss_andando_direita;
            }
        } else if (direc == 1) {
            // Verifica colisão com parede à esquerda
            if (place_meeting(x - veloc, y, obj_parede_inimigo)) {
                x += veloc; // Ajusta a posição para fora da parede
                direc = 0;
                estado = "atacando";
            } else {
                x -= veloc;
                sprite_index = spr_boss_andando_esquerda;
            }
        }
    }

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

// Verificar se o inimigo morreu
if (vida <= 0) {
    sprite_index = sprite_morrendo;
    // Verifica se a animação de morte terminou
    if (image_index >= image_number - 1) {
        instance_destroy();
        room_goto(Room4); // Muda para a Room4 quando o boss morre
    }
}
