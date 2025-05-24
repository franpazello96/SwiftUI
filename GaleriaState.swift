
import SwiftUI

class GaleriaState: ObservableObject {
    @Published var obras: [ObraDeArte]
    @Published var termoPesquisa = ""
    @Published var obrasExibidas: [ObraDeArte] = []
    @Published var obraSelecionada: ObraDeArte?
    @Published var mostrandoDetalhes = false
    
    init() {
        self.obras = obrasDeArte
        self.obrasExibidas = obras
    }
    
    func filtrarObras() {
        if termoPesquisa.isEmpty {
            obrasExibidas = obras
        } else {
            obrasExibidas = obras.filter { obra in
                obra.titulo.localizedCaseInsensitiveContains(termoPesquisa) ||
                obra.artista.localizedCaseInsensitiveContains(termoPesquisa)
            }
        }
    }
    
    func selecionarObra(_ obra: ObraDeArte) {
        obraSelecionada = obra
        mostrandoDetalhes = true
    }
}
