import Foundation

struct ObraDeArte: Identifiable, Equatable {
    let id = UUID()
    let titulo: String
    let artista: String
    let ano: Int
    let estilo: String
    let imagemNome: String
    let descricao: String
    
    // Implementação 
    static func == (lhs: ObraDeArte, rhs: ObraDeArte) -> Bool {
        lhs.id == rhs.id
    }
}

// Dados de obras de arte de artistas de Curitiba
let obrasDeArte = [
    ObraDeArte(
        titulo: "Natureza Morta com Pinhão",
        artista: "Leonor Botteri",
        ano: 1964,
        estilo: "Surrealismo",
        imagemNome: "1",
        descricao: "Uma composição que explora atmosferas oníricas e silenciosas, remetendo ao estilo de Giorgio de Chirico."
    ),
    ObraDeArte(
        titulo: "O vento da Noite",
        artista: "Leonor Botteri",
        ano: 1960,
        estilo: "Surrealismo",
        imagemNome: "2",
        descricao: "Obra que reflete a influência de atmosferas oníricas e o silêncio característico do surrealismo."
    ),
    ObraDeArte(
        titulo: "Araucária",
        artista: "Theodoro de Bona",
        ano: 1944,
        estilo: "Regionalista",
        imagemNome: "5",
        descricao: "Uma celebração da árvore símbolo do Paraná."
    ),
    ObraDeArte(
        titulo: "Paisagem Paranaense",
        artista: "Theodoro de Bona",
        ano: 1940,
        estilo: "Regionalista",
        imagemNome: "6",
        descricao: "Paisagem que destaca as belezas naturais do Paraná."
    ),
    ObraDeArte(
        titulo: "Composição em gris",
        artista: "Domicio Pedroso",
        ano: 1995,
        estilo: "Abstrato",
        imagemNome: "7",
        descricao: "Exploração de formas e tons monocromáticos em uma composição abstrata."
    ),
    ObraDeArte(
        titulo: "Rua de Nápoles",
        artista: "Domicio Pedroso",
        ano: 1961,
        estilo: "Abstrato",
        imagemNome: "8",
        descricao: "Uma interpretação artística de uma rua em Nápoles, com traços abstratos."
    ),
    ObraDeArte(
        titulo: "Casario",
        artista: "Domicio Pedroso",
        ano: 1986,
        estilo: "Abstrato",
        imagemNome: "9",
        descricao: "Representação de casarios urbanos com influência cubista e abstrata."
    )
]
