//
//  ContentView.swift
//  SwiftUIObras
//
//  Created by francielly pazello on 24/05/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var galeriaState: GaleriaState
    
    // grade com colunas adaptativas
    private var columns: [GridItem] {
        [GridItem(.adaptive(minimum: UIScreen.main.bounds.width > 768 ? 200 : 160), spacing: 16)]
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // pesquisa
                    searchField
                    
                    // grid 
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(galeriaState.obrasExibidas) { obra in
                            NavigationLink {
                                DetalhesObraView(obra: obra)
                                    .navigationTitle("Detalhes da Obra")
                                    .navigationBarTitleDisplayMode(.large)
                            } label: {
                                ObraCard(obra: obra)
                                    .transition(.scale.combined(with: .opacity))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                    
                    // mensagem quando não há resultados
                    if galeriaState.obrasExibidas.isEmpty {
                        Text("Nenhuma obra encontrada")
                            .foregroundColor(.secondary)
                            .padding(.top, 32)
                    }
                }
            }
            .navigationTitle("Galeria de Arte")
            .animation(.spring(response: 0.3), value: galeriaState.obrasExibidas)
        }
    }
    
    // pesquisa personalizado
    private var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Buscar por título ou artista", text: $galeriaState.termoPesquisa)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: galeriaState.termoPesquisa) { _ in
                    galeriaState.filtrarObras()
                }
            
            if !galeriaState.termoPesquisa.isEmpty {
                Button(action: {
                    galeriaState.termoPesquisa = ""
                    galeriaState.filtrarObras()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
    }
}

/// Card 
struct ObraCard: View {
    let obra: ObraDeArte
    @State private var isHovered = false
    
    var body: some View {
        VStack(spacing: 12) {
            // Imagem da obra
            Image(obra.imagemNome)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(maxWidth: 160)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(Color.gray.opacity(0.2), lineWidth: 1)
                )
                .shadow(radius: 8, x: 0, y: 4)
                .scaleEffect(isHovered ? 1.05 : 1.0)
            
            // Informações da obra
            VStack(spacing: 6) {
                Text(obra.titulo)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(height: 50)
                    .padding(.horizontal, 8)
                
                Text(obra.artista)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .padding(.horizontal, 8)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .onHover { hovering in
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                isHovered = hovering
            }
        }
    }
}

/// Tela de detalhes 
struct DetalhesObraView: View {
    let obra: ObraDeArte
    @Environment(\.dismiss) private var dismiss
    @State private var showShareSheet = false
    @State private var apareceComAnimacao = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Imagem da obra com animação de entrada
                Image(obra.imagemNome)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxWidth: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                    .shadow(radius: 12, x: 0, y: 6)
                    .scaleEffect(apareceComAnimacao ? 1 : 0.8)
                    .opacity(apareceComAnimacao ? 1 : 0)
                
                // Informações da obra
                VStack(alignment: .leading, spacing: 16) {
                    // Título e Artista
                    VStack(alignment: .leading, spacing: 8) {
                        Text(obra.titulo)
                            .font(.title)
                            .bold()
                        
                        Text(obra.artista)
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                    .offset(x: apareceComAnimacao ? 0 : -50)
                    .opacity(apareceComAnimacao ? 1 : 0)
                    
                    // Detalhes 
                    VStack(alignment: .leading, spacing: 12) {
                        DetalheRow(titulo: "Ano", valor: "\(obra.ano)")
                        DetalheRow(titulo: "Estilo", valor: obra.estilo)
                    }
                    .padding(.vertical)
                    .offset(x: apareceComAnimacao ? 0 : 50)
                    .opacity(apareceComAnimacao ? 1 : 0)
                    
                    // Descrição
                    Text(obra.descricao)
                        .padding(.top)
                        .opacity(apareceComAnimacao ? 1 : 0)
                }
                .padding()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showShareSheet = true }) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
        .sheet(isPresented: $showShareSheet) {
            let textoCompartilhamento = "\(obra.titulo) por \(obra.artista) (\(obra.ano))"
            ShareSheet(activityItems: [textoCompartilhamento])
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                apareceComAnimacao = true
            }
        }
    }
}

/// exibir uma linha de detalhe
struct DetalheRow: View {
    let titulo: String
    let valor: String
    
    var body: some View {
        HStack {
            Text(titulo)
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
            Text(valor)
                .font(.body)
        }
    }
}

/// compartilhar conteúdo
struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    ContentView()
        .environmentObject(GaleriaState())
}
