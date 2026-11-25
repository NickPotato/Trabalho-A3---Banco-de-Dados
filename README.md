# Sistema de Gerenciamento de Academia — Trabalho A3 (Banco de Dados)

Projeto desenvolvido para a Avaliação A3 da Unidade Curricular de **Banco de Dados** da **Universidade do Sul de Santa Catarina (UNISUL)**.

* **Disciplina:** Banco de Dados
* **Professor:** Osmar de Oliveira Braz Júnior
* **Semestre:** 2026/2

---

## Integrantes da Equipe

* **Arthur Kroth Posselt** — RA: `10725115044`
* **Nícolas Gaia Negrão** — RA: `1072517389`

---

## Sobre o Projeto

O sistema tem como objetivo modelar, normalizar e implementar um banco de dados relacional para o gerenciamento completo de uma academia. A solução abrange o controle cadastral de pessoas (alunos, funcionários e professores), contratação de planos, matrículas, controle financeiro de pagamentos, agendamentos de aulas coletivas, controle de frequência, avaliações físicas e prescrição de programas de treinamento com exercícios.

### Etapas Desenvolvidas
1. **Modelagem Conceitual:** Diagrama Entidade-Relacionamento Estendido (EER) e Diagrama ER na notação alternativa UML, contemplando especializações/generalizações, atributos compostos, atributos multivalorados e restrições estruturais.
2. **Modelagem Lógica e Normalização:** Conversão para o Modelo Relacional aplicado até a **3ª Forma Normal (3FN)**, fundamentado por Dependências Funcionais (DFs) e integridade referencial.
3. **Documentação de Dados:** Dicionário de Dados elaborado na notação estruturada de Yourdon/DeMarco.
4. **Modelagem Física (SQL):** Scripts completos em MySQL divididos em **DDL** (criação das estruturas), **DML** (carga de dados fictícios, atualizações e exclusões) e **DQL** (consultas estratégicas com junções `JOIN` para relatórios).

---

## Estrutura do Repositório

```text
├── Diagrama_Entidade_e_Relacionamento_Estendido(EER)/   # Arquivos fonte (.drawio) e imagens dos diagramas EER e UML
├── Modelo_Relacional/                                   # Esquema lógico relacional e diagrama de tabelas (3FN)
├── Dicionario_de_Dados/                                 # Especificação dos atributos e domínios (Notação Yourdon)
├── SQL/                                                 # Scripts DDL, DML e DQL para execução no SGBD (MySQL)
├── Caso_Sistema_de_Gerenciamento_de_Academia.pdf        # Estudo de caso base do sistema
├── Trabalho_Banco_de_Dados_Academia_ABNT.pdf            # Documentação acadêmica completa (normas UNISUL/ABNT)
├── LICENSE                                              # Licença MIT
└── README.md                                            # Apresentação e guia do repositório
```

---

## Como Executar os Scripts SQL

1. Certifique-se de ter MySQL 8.0+ e MySQL Workbench (ou forks como MariaDB)
2. Execute os arquivos da pasta `SQL/` na seguinte ordem:
   1. **DDL** (`Academia_DDL.sql`) — Cria o banco `db_academia`, as tabelas e todas as restrições de chaves primárias e estrangeiras.
   2. **DML** (`Academia_DML.sql`) — Popula as tabelas com dados fictícios para homologação e executa exemplos de `UPDATE` e `DELETE`.
   3. **DQL** (`Academia_DQL.sql`) — Executa as consultas de relatórios estratégicos utilizando junções (`JOIN`) e agregações.

---

## 📄 Licença

Este projeto está sob a licença **MIT**. Consulte o arquivo [LICENSE](./LICENSE) 
