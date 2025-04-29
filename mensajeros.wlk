//PRIMERA PARTE
object paquete {
  var estaPago = false
  var destino = laMatrix
  method estaPago() = estaPago
  method destino() = destino
  method destino(unLugar){destino = unLugar} 
  method pagarPaquete() {estaPago = true}
  method puedeEntregarse(unMensajero) {
    return
    destino.dejaPasar(unMensajero) &&
    self.estaPago()
  }
  method precio() = 50
}

object puenteDeBrooklyn {
  method dejaPasar(unMensajero){
    return
    unMensajero.peso() < 1000
  }
}

object laMatrix {
  method dejaPasar(unMensajero){
    return
    unMensajero.puedeLlamar()
  }
}

object roberto {
  var transporte = bicicleta
  
  method transporte() = transporte
  method cambiarTransporte(nuevoTransporte){
    transporte = nuevoTransporte
  }
  method peso() = 90 + transporte.peso()
  method puedeLlamar() = false
}

object chuckNorris {
  method peso() = 80
  method puedeLlamar() = true
}

object neo {
  var tieneCredito = true
  method cargarCredito(){tieneCredito = true}
  method agotarCredito(){tieneCredito = false}
  method peso() = 0
  method puedeLlamar() = tieneCredito
}

object bicicleta {
  method peso()= 5
}
object camion {
  var acoplados = 1
  method acoplados()= acoplados
  method cantAcoplados(unaCantidad){acoplados = unaCantidad}
  method peso() = acoplados * 500
}
//SEGUNDA PARTE
object empresaMensajeria {
  const mensajeros = []
  const paquetesPendientes = []
  const paquetesEnviados = []
  method paquetesPendientes() = paquetesPendientes
  method paquetesEnviados() = paquetesEnviados
  method mensajeros() = mensajeros
  method contratar(unMensajero){mensajeros.add(unMensajero)}
  method despedir(unMensajero){mensajeros.remove(unMensajero)}
  method despedirATodos(){mensajeros.removeAll()}
  method esGrande()= mensajeros.size() < 2
  method puedeEntregarsePorPrimerMensajero(){
    return
    paquete.puedeEntregarse(mensajeros.first())
  }
  method pesoDelUltimoMensajero() = mensajeros.last().peso()
  method puedeEntregarse(unPaquete){
    return
    mensajeros.any({m => unPaquete.puedeEntregarse(m)})
  }
  method losQuePuedenEntregar(unPaquete){
    return
    mensajeros.filter({m=>unPaquete.puedeEntregarse(m)})
  }
  method tieneSobrepeso(){
    return
    (self.pesoDeLosMensajeros() / mensajeros.size()) > 500
  }
  method pesoDeLosMensajeros() = mensajeros.sum({m=>m.peso()})
  method enviar(unPaquete){
    if(self.puedeEntregarse(unPaquete)){
      paquetesEnviados.add(unPaquete)
    }else{paquetesPendientes.add(unPaquete)}
  }
  method facturacion() = paquetesEnviados.sum({p=>p.precio()})
  method enviarPaquetes(listaDePaquetes){
    listaDePaquetes.forEach({p=> self.enviar(p)})
  }
  method enviarElPaqueteMasCaro(){
    self.enviar(self.paquetePendienteMasCaro())
  }
  method paquetePendienteMasCaro() = paquetesPendientes.max({p=>p.precio()})

}

//TERCERA PARTE

object paquetito {
  method estaPago() = true
  method puedeEntregarse(unMensajero) = true
  method precio() = 0
}

object paqueton {
  const destinos = []
  var importe = 0
  method agregarDestino(unDestino){destinos.add(unDestino)}
  method precio() = 100 * destinos.size()
  method pagarImporte(unValor){importe += unValor}
  method estaPago(){
    return
    importe >= self.precio()
  }
  method puedeEntregarse(unMensajero){
    return
    self.estaPago()&& self.puedePasarPorDestino(unMensajero)
  }
  method puedePasarPorDestino(unMensajero){
    return
    destinos.all({d => d.dejaPasar(unMensajero)})
  }
}
