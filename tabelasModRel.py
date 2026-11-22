from tabulate import tabulate # library that formats the lists/tables for me

tables = [ # clump everything together into one list 
    Pessoa := { # each table has one header (the key name) and values
        "PESSOA": ["idPessoa(PK)", "nome", "cpf", "rg", "sexo", "data_nascimento", "rua", "numero", "bairro", "cidade", "uf"]
    },
    PessoaTelefone := {
        "PESSOA_TELEFONE*": ["idPessoa(PK, FK)", "telefone(PK)"]
    },
    PessoaEmail := {
        "PESSOA_EMAIL*": ["idPessoa(PK, FK)", "email(PK)"]
    },
    Aluno := {
        "ALUNO": ["idPessoa(PK, FK)", "numero_matricula", "data_ingresso", "situacao_cadastro", "objetivo_principal"]
    },
    Funcionario := {
        "FUNCIONARIO": ["idPessoa(PK, FK)", "numero_funcionario", "data_contratacao", "cargo", "salario", "horario_trabalho"]
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
    Matricula := { # am I even allowed to refer to pessoa subcategories like this? pessoa_aluno...?
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
    AlunoAula := {
        "ALUNO_AULA": ["idPessoa_Aluno(PK, FK)", "idAula(PK, FK)", "presenca", "data_registro"]
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

for table in tables: # go through every table individually and print each of em out with tabulate
    print(tabulate(table, headers="keys", tablefmt="simple_outline"))
    
# im running this in cmd prompt and putting the results in firealpaca so I can edit them together there