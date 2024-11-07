![Status](https://img.shields.io/badge/status-em%20desenvolvimento-yellow)

# 🍔 DeliveryAppWL - Aplicação de Delivery Personalizável

DeliveryApp é um projeto white label para mobile desenvolvido em Swift, com o objetivo de criar uma experiência de compra intuitiva e personalizável para os usuários. Este app permite a navegação por categorias de produtos, personalização de combos e escolha de acompanhamentos. O projeto segue uma estrutura modular e utiliza boas práticas de arquitetura e testes.

# Layout
<img src="https://github.com/user-attachments/assets/75600a69-fd24-42a2-a65e-99ad4ec21189" width="150"/>
<img src="https://github.com/user-attachments/assets/0c391cad-638f-47a1-b7c5-898b18cd3bfc" width="150"/>
<img src="https://github.com/user-attachments/assets/7792dccd-81a7-49b0-bb42-7ef339461448" width="150"/>
<img src="https://github.com/user-attachments/assets/d763b620-7b92-47ee-b61b-b9f0597f6d49" width="150"/>
<img src="https://github.com/user-attachments/assets/de2e9d19-ad3a-4b46-94eb-83cfdcf50da1" width="150"/>
<img src="https://github.com/user-attachments/assets/49b85e73-1d7a-40d4-b7b8-7ea5063a95a0" width="150"/>


# 🛠 Tecnologias e Arquitetura
  * Linguagem: Swift
  * Arquitetura: MVVM-C (Model-View-ViewModel-Coordinator)
  * Construção de UI: ViewCode, sem uso de Storyboards
  * Persistência de Dados: Realm e UserDefaults
  * Testes Unitários: XCTest, cobrindo funcionalidades principais
  *  Design Patterns: Aplicação de padrões como Factory e Composite para promover reutilização e manutenção de código

# 🚀 Funcionalidades
  * Autenticação e Autorização: Autenticação segura via JWT, garantindo o controle de acesso.
  * Categorias e Produtos: Navegação entre categorias de produtos, permitindo filtragem e busca.
  * Customização de Produtos: Para produtos do tipo "combo", o usuário pode selecionar itens adicionais e personalizar opções.
  * API Backend: Conectado a uma API RESTful construída com ASP.NET e SQL Server, com Entity Framework para mapeamento de dados.
  * Ambiente Local: Configuração com Docker para simular o backend em ambiente local.

# 📋 Estrutura do Projeto
  * ViewModel: Gerenciamento de dados e regras de negócio
  * Coordinators: Navegação de fluxo de telas
  * Models: Estrutura de dados e integração com o backend
  * Views: Layouts construídos 100% em código (ViewCode)

# 🔍 Testes
O projeto possui uma camada robusta de testes unitários utilizando o XCTest, cobrindo desde validações de entrada de dados até a verificação de respostas da API. Os testes foram implementados para garantir a qualidade da aplicação e facilitar a manutenção a longo prazo.
