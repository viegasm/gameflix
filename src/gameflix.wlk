class Juego {

	var nombre
	var precio
	var categoria
	var estilo
	var anioDeLanzamiento
	
	method esViejo() {
		var anioActual = new Date().year()
		return ((anioActual - anioDeLanzamiento) >= 3)
	}

}

class Usuario {

	// Suscripcion puede ser: PREMIUM, BASE, INFANTIL, PRUEBA
	var suscripcion
	var property dinero
	var humor
	var felicidad
	var horasJugadas

	method actualizarSuscripcion(suscripcionNueva) {
		if (suscripcionNueva.puedoActualizar(self)) {
			suscripcion = suscripcionNueva
		}
	}

	method jugar(juego) {
		if (suscripcion.juegosDisponibles(self).contains(juego)) {
			juego.estilo().afectar(self, horasJugadas, juego)
		}
	}

	method descontarDinero(costo) {
		dinero = (dinero - costo).max(0)
	}

}

object gameflix {

	var property juegos = #{}

	method filtrar(categoria) {
		return juegos.filter({ juego => juego.esViejo() })
	}

	method buscar(juego) {
		return juegos.filter(juego)
	}

	method recomendar() {
		return juegos.anyone()
	}

	method juegosViejos() {
		var anioActual = new Date().year()
		return juegos.filter({ juego => anioActual - juego.anioLanzamiento() >= 3 })
	}

	method cobrarServicio(usuario) {
		if (usuario.suscripcion().costo() <= usuario.dinero()) {
			usuario.descontarDinero(usuario.suscripcion().costo())
		} else {
			usuario.suscripcion(prueba)
		}
	}

}

object premium {

	var property costo = 250

	method juegosDisponibles(usuario) {
		return gameflix.juegos()
	}

	method puedoActualizar(usuario) {
		return usuario.dinero() >= costo
	}

}

object base {

	var property costo = 175

	method juegosDisponibles(usuario) {
		return gameflix.juegosViejos()
	}

	method puedoActualizar(usuario) {
		return usuario.dinero() >= costo
	}

}

object infantil {

	var property costo = 100

	method juegosDisponibles(usuario) {
		return gameflix.filtrar("Infantil")
	}

	method puedoActualizar(usuario) {
		return usuario.dinero() >= costo
	}

}

object prueba {

	method juegosDisponibles(usuario) {
		return gameflix.filtrar("Demo")
	}

	method puedoActualizar(usuario) {
		return true
	}

}

object violento {

	method afectar(usuario, horasJugadas, juego) {
		usuario.humor(usuario.humor() - (10 * horasJugadas)).max(0)
	}

}

object multijugador {

	method afectar(usuario, horasJugadas, juego) {
		usuario.descontarDinero(30)
	}

}

object terror {

	method afectar(usuario, horasJugadas, juego) {
		usuario.suscripcion(infantil)
	}

}

object deporte {

	method afectar(usuario, horasJugadas, juego) {
		if (juego.esViejo()) {
			usuario.felicidad(usuario.felicidad() + 10)
		}else {
			usuario.felicidad(usuario.felicidad() + 25)
		}
	}

}

