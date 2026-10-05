import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aula 05 - Interatividade',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FormularioPage(),
    );
  }
}

// Estrutura de dados para armazenar cada registo
class Registro {
  final String titulo;
  final String observador;

  Registro({required this.titulo, required this.observador});
}

class FormularioPage extends StatefulWidget {
  const FormularioPage({super.key});

  @override
  State<FormularioPage> createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  // Controllers para capturar os campos de texto
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _observadorController = TextEditingController();

  // Lista onde os registos guardados ficam armazenados
  final List<Registro> _listaRegistros = [];

  // EXERCÍCIO 01: Função para limpar/resetar o formulário manualmente
  void _limparFormulario() {
    setState(() {
      _tituloController.clear();
      _observadorController.clear();
    });
  }

  // Função para adicionar um novo registo
  void _cadastrar() {
    final String titulo = _tituloController.text.trim();
    final String observador = _observadorController.text.trim();

    if (titulo.isEmpty || observador.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _listaRegistros.add(
        Registro(
          titulo: titulo,
          observador: observador,
        ),
      );
    });

    // EXERCÍCIO 03: Exibir SnackBar com a contagem total atualizada
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Cadastro efetuado! Total de registos: ${_listaRegistros.length}',
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );

    // Limpa o formulário após o cadastro
    _limparFormulario();
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _observadorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro e Listagem'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de Texto principal
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: 'Título / Item',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // EXERCÍCIO 02: Campo de 'Observador' (Marcelo Barbosa Wenceslau Filho)
            TextField(
              controller: _observadorController,
              decoration: const InputDecoration(
                labelText: 'Observador (Nome de quem registou)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Botões de Ação
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _cadastrar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Cadastrar'),
                  ),
                ),
                const SizedBox(width: 8),

                // EXERCÍCIO 01: Botão de Limpar / Resetar
                OutlinedButton(
                  onPressed: _limparFormulario,
                  child: const Text('Limpar'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Registos Efetuados:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),

            // Exibição da lista
            Expanded(
              child: _listaRegistros.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhum registo efetuado.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _listaRegistros.length,
                      itemBuilder: (context, index) {
                        final item = _listaRegistros[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text('${index + 1}'),
                            ),
                            title: Text(item.titulo),
                            // EXERCÍCIO 02: Nome do observador exibido no subtítulo da lista
                            subtitle: Text('Observador: ${item.observador}'),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
