from tabulate import tabulate # biblioteca que formata as lists/tuples 

tables = [ # juntar todas as tabelas em uma list
    Pessoa := { # cada tabela tem um header (o nome da key) e valores
        "PESSOA": ["idPessoa(PK)", "nome", "cpf", "rg", "sexo", "data_nascimento", "rua", "numero", "bairro", "cidade", "uf"]
    },
    PessoaTelefone := {
        "PESSOA_TELEFONE*": ["idPessoa(PK, FK)", "telefone(PK)"]
    },
    PessoaEmail := {
        "PESSOA_EMAIL*": ["idPessoa(PK, FK)", "email(PK)"]
    },
    Aluno := {
        "ALUNO": ["idPessoa(PK, FK)", "data_ingresso", "situacao_cadastro", "objetivo_principal"]
    },
    Funcionario := {
        "FUNCIONARIO": ["idPessoa(PK, FK)", "data_contratacao", "cargo", "salario"]
    },
    Professor := {
        "PROFESSOR": ["idPessoa(PK, FK)", "cref", "especialidade", "nivel_experiencia"]
    },
    ProfDisp := {
        "PROFESSOR_DISPONIBILIDADE*": ["idPessoa(PK, FK)", "disponibilidade(PK)"]
    },
    Plano := {
        "PLANO": ["idPlano(PK)", "nome", "descricao", "duracao", "valor", "modalidade_acesso"]
    },
    Matricula := {
        "MATRICULA": ["idMatricula(PK)", "idPessoa_Aluno(FK)", "idPlano(FK)", "data_inicio", "data_fim", "status", "valor_contratado"] 
    },
    Pagamento := {
        "PAGAMENTO": ["idPagamento(PK)", "idMatricula(FK)", "data_pagamento", "valor", "status", "metodo_pagamento", "data_vencimento"]
    },
    AvFisica := {
        "AVALIACAO_FISICA": ["idAvaliacao(PK)", "idPessoa_Aluno(FK)", "idPessoa_Funcionario(FK)", "data_avaliacao", "peso", "altura", "percentual_gordura", "observacoes", "resultados", "cintura", "quadril", "bracos", "pernas", "peito"]
    },
    Modalidade := {
        "MODALIDADE": ["idModalidade(PK)", "nome", "duracao_media", "intensidade", "descricao"]
    },
    ProfModalidade := {
        "PROFESSOR_MODALIDADE": ["idPessoa_Professor(PK, FK)", "idModalidade(PK, FK)"]
    },
    Aula := {
        "AULA": ["idAula(PK)", "idModalidade(FK)", "idPessoa_Professor(FK)", "data", "hora_inicio", "hora_fim", "capacidade_maxima", "local"]
    },
    PartAula := {
        "PARTICIPACAO_AULA": ["idPessoa_Aluno(PK, FK)", "idAula(PK, FK)", "presenca", "data_registro"]
    },
    Programa := {
        "PROGRAMA_TREINAMENTO": ["idPrograma(PK)", "idPessoa_Aluno(FK)", "idPessoa_Professor(FK)", "objetivo", "data_criacao", "data_validade", "observacoes"]
    },
    Exercicio := {
        "EXERCICIO": ["idExercicio(PK)", "nome", "descricao", "grupo_muscular", "nivel_dificuldade", "instrucoes"]
    },
    ProgExercicio := {
        "PROGRAMA_EXERCICIO": ["idPrograma(PK, FK)", "idExercicio(PK, FK)", "ordem", "series", "repeticoes", "carga_recomendada", "intervalo_descanso"]
    }
]

for table in tables: # iterar e usar tabulate sob todas as tabelas individualmente, printando o resultado de cada uma
    print(tabulate(table, headers="keys", tablefmt="simple_outline"))
    
# executando isso no terminal e usando firealpaca para editar os resultados
