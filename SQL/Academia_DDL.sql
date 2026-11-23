-- SCRIPT SQL DDL - BANCO DE DADOS ACADEMIA


CREATE DATABASE IF NOT EXISTS db_academia;

USE db_academia;


-- 1. PESSOA

CREATE TABLE PESSOA (
    idPessoa INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único da pessoa no sistema',
    nome VARCHAR(120) NOT NULL COMMENT 'Nome completo da pessoa',
    cpf CHAR(11) NOT NULL COMMENT 'Cadastro de Pessoa Física (apenas dígitos, único)',
    rg VARCHAR(20) NOT NULL COMMENT 'Registro Geral / documento de identidade',
    sexo CHAR(1) NOT NULL COMMENT 'Sexo biológico ou declarado (M, F ou O)',
    data_nascimento DATE NOT NULL COMMENT 'Data de nascimento da pessoa',
    rua VARCHAR(120) NOT NULL COMMENT 'Logradouro do endereço residencial (decomposição 1FN)',
    numero VARCHAR(15) NOT NULL COMMENT 'Número do imóvel residencial (decomposição 1FN)',
    bairro VARCHAR(80) NOT NULL COMMENT 'Bairro do endereço residencial (decomposição 1FN)',
    cidade VARCHAR(80) NOT NULL COMMENT 'Município do endereço residencial (decomposição 1FN)',
    uf CHAR(2) NOT NULL COMMENT 'Sigla da Unidade Federativa (ex.: SC, SP, RJ) (decomposição 1FN)',
    CONSTRAINT pk_pessoa PRIMARY KEY (idPessoa),
    CONSTRAINT uk_pessoa_cpf UNIQUE (cpf),
    CONSTRAINT uk_pessoa_rg UNIQUE (rg),
    CONSTRAINT chk_pessoa_sexo CHECK (sexo IN ('M', 'F', 'O'))
) COMMENT='Entidade base que reúne os dados comuns e o endereço de PESSOA';


-- 2. PESSOA_EMAIL

CREATE TABLE PESSOA_EMAIL (
    idPessoa INT NOT NULL COMMENT 'Identificador da pessoa proprietária do e-mail',
    email VARCHAR(150) NOT NULL COMMENT 'Endereço de correio eletrônico (multivalorado em 1FN)',
    CONSTRAINT pk_pessoa_email PRIMARY KEY (idPessoa, email),
    CONSTRAINT fk_pessoa_email_pessoa FOREIGN KEY (idPessoa)
        REFERENCES PESSOA (idPessoa)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) COMMENT='Tabela multivalorada para múltiplos e-mails por pessoa (1FN)';


-- 3. PESSOA_TELEFONE

CREATE TABLE PESSOA_TELEFONE (
    idPessoa INT NOT NULL COMMENT 'Identificador da pessoa proprietária do telefone',
    telefone VARCHAR(20) NOT NULL COMMENT 'Número de telefone com DDD (multivalorado em 1FN)',
    CONSTRAINT pk_pessoa_telefone PRIMARY KEY (idPessoa, telefone),
    CONSTRAINT fk_pessoa_telefone_pessoa FOREIGN KEY (idPessoa)
        REFERENCES PESSOA (idPessoa)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) COMMENT='Tabela multivalorada para múltiplos telefones por pessoa (1FN)';


-- 4. ALUNO

CREATE TABLE ALUNO (
    idPessoa INT NOT NULL COMMENT 'Chave primária herdada de PESSOA (especialização sobreposta)',
    data_ingresso DATE NOT NULL COMMENT 'Data de início do vínculo do aluno com a academia',
    objetivo_principal VARCHAR(100) NULL COMMENT 'Objetivo principal de treino (ex.: Hipertrofia, Emagrecimento)',
    situacao_cadastro VARCHAR(20) NOT NULL DEFAULT 'Ativo' COMMENT 'Situação cadastral do aluno (Ativo, Inativo ou Suspenso)',
    CONSTRAINT pk_aluno PRIMARY KEY (idPessoa),
    CONSTRAINT fk_aluno_pessoa FOREIGN KEY (idPessoa)
        REFERENCES PESSOA (idPessoa)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_aluno_situacao CHECK (situacao_cadastro IN ('Ativo', 'Inativo', 'Suspenso'))
) COMMENT='Subclasse de PESSOA para alunos da academia';


-- 5. FUNCIONARIO

CREATE TABLE FUNCIONARIO (
    idPessoa INT NOT NULL COMMENT 'Chave primária herdada de PESSOA (especialização sobreposta)',
    data_contratacao DATE NOT NULL COMMENT 'Data de admissão do funcionário na academia',
    cargo VARCHAR(60) NOT NULL COMMENT 'Cargo ocupado (ex.: Professor, Recepcionista, Avaliador Físico)',
    salario DECIMAL(10, 2) NOT NULL COMMENT 'Remuneração mensal contratual do funcionário em reais',
    CONSTRAINT pk_funcionario PRIMARY KEY (idPessoa),
    CONSTRAINT fk_funcionario_pessoa FOREIGN KEY (idPessoa)
        REFERENCES PESSOA (idPessoa)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_funcionario_salario CHECK (salario > 0)
) COMMENT='Subclasse de PESSOA para funcionários da academia';


-- 6. PROFESSOR

CREATE TABLE PROFESSOR (
    idPessoa INT NOT NULL COMMENT 'Chave primária herdada de FUNCIONARIO (especialização em segundo nível)',
    cref VARCHAR(20) NOT NULL COMMENT 'Registro profissional no Conselho Regional de Educação Física',
    especialidade VARCHAR(80) NOT NULL COMMENT 'Área técnica principal de atuação (ex.: Musculação, Pilates)',
    nivel_experiencia VARCHAR(30) NOT NULL COMMENT 'Classificação de experiência (Júnior, Pleno, Sênior ou Especialista)',
    CONSTRAINT pk_professor PRIMARY KEY (idPessoa),
    CONSTRAINT uk_professor_cref UNIQUE (cref),
    CONSTRAINT fk_professor_funcionario FOREIGN KEY (idPessoa)
        REFERENCES FUNCIONARIO (idPessoa)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_professor_experiencia CHECK (nivel_experiencia IN ('Júnior', 'Pleno', 'Sênior', 'Especialista'))
) COMMENT='Subclasse de FUNCIONARIO para professores e instrutores';


-- 7. PROFESSOR_DISPONIBILIDADE

CREATE TABLE PROFESSOR_DISPONIBILIDADE (
    idPessoa INT NOT NULL COMMENT 'Identificador do professor (referencia PROFESSOR.idPessoa)',
    disponibilidade VARCHAR(50) NOT NULL COMMENT 'Turno ou faixa de dia/horário disponível (multivalorado em 1FN)',
    CONSTRAINT pk_professor_disponibilidade PRIMARY KEY (idPessoa, disponibilidade),
    CONSTRAINT fk_prof_disp_professor FOREIGN KEY (idPessoa)
        REFERENCES PROFESSOR (idPessoa)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) COMMENT='Tabela multivalorada para disponibilidades de horário do professor (1FN)';


-- 8. PLANO

CREATE TABLE PLANO (
    idPlano INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único do plano comercializado',
    nome VARCHAR(80) NOT NULL COMMENT 'Nome comercial do plano (ex.: Mensal Musculação, Anual Completo)',
    modalidade_acesso VARCHAR(60) NOT NULL COMMENT 'Abrangência de acesso (ex.: Musculação, Coletivas, Livre)',
    descricao TEXT NULL COMMENT 'Detalhamento das condições, benefícios e regras do plano',
    duracao INT NOT NULL COMMENT 'Duração padrão do ciclo do plano em dias ou meses',
    valor DECIMAL(10, 2) NOT NULL COMMENT 'Valor base de tabela vigente do plano',
    CONSTRAINT pk_plano PRIMARY KEY (idPlano),
    CONSTRAINT uk_plano_nome UNIQUE (nome),
    CONSTRAINT chk_plano_duracao CHECK (duracao > 0),
    CONSTRAINT chk_plano_valor CHECK (valor >= 0)
) COMMENT='Catálogo de planos ofertados pela academia';


-- 9. MATRICULA

CREATE TABLE MATRICULA (
    idMatricula INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único do contrato de matrícula',
    idPessoaAluno INT NOT NULL COMMENT 'Identificador do aluno matriculado (referencia ALUNO.idPessoa)',
    idPlano INT NOT NULL COMMENT 'Identificador do plano contratado (referencia PLANO.idPlano)',
    data_inicio DATE NOT NULL COMMENT 'Data de início da vigência da matrícula',
    data_fim DATE NOT NULL COMMENT 'Data prevista de término da vigência da matrícula',
    status VARCHAR(20) NOT NULL DEFAULT 'Ativa' COMMENT 'Situação atual da matrícula (Ativa, Vencida, Cancelada ou Trancada)',
    valor_contratado DECIMAL(10, 2) NOT NULL COMMENT 'Valor efetivamente acordado na contratação (preserva histórico)',
    CONSTRAINT pk_matricula PRIMARY KEY (idMatricula),
    CONSTRAINT fk_matricula_aluno FOREIGN KEY (idPessoaAluno)
        REFERENCES ALUNO (idPessoa)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_matricula_plano FOREIGN KEY (idPlano)
        REFERENCES PLANO (idPlano)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_matricula_status CHECK (status IN ('Ativa', 'Vencida', 'Cancelada', 'Trancada')),
    CONSTRAINT chk_matricula_valor CHECK (valor_contratado >= 0),
    CONSTRAINT chk_matricula_datas CHECK (data_fim >= data_inicio)
) COMMENT='Contratos de matrícula dos alunos nos planos da academia';


-- 10. PAGAMENTO

CREATE TABLE PAGAMENTO (
    idPagamento INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único do lançamento financeiro',
    idMatricula INT NOT NULL COMMENT 'Identificador da matrícula vinculada (referencia MATRICULA.idMatricula)',
    data_vencimento DATE NOT NULL COMMENT 'Data limite prevista para quitação da parcela',
    data_pagamento DATE NULL COMMENT 'Data efetiva da liquidação (nulo enquanto pendente)',
    valor DECIMAL(10, 2) NOT NULL COMMENT 'Valor monetário da parcela ou cobrança',
    metodo_pagamento VARCHAR(30) NULL COMMENT 'Forma de pagamento (PIX, Cartão de Crédito, Cartão de Débito, Dinheiro, Boleto)',
    status VARCHAR(20) NOT NULL DEFAULT 'Pendente' COMMENT 'Situação financeira da parcela (Pendente, Pago, Atrasado ou Cancelado)',
    CONSTRAINT pk_pagamento PRIMARY KEY (idPagamento),
    CONSTRAINT fk_pagamento_matricula FOREIGN KEY (idMatricula)
        REFERENCES MATRICULA (idMatricula)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_pagamento_valor CHECK (valor > 0),
    CONSTRAINT chk_pagamento_metodo CHECK (metodo_pagamento IN ('PIX', 'Cartão de Crédito', 'Cartão de Débito', 'Dinheiro', 'Boleto')),
    CONSTRAINT chk_pagamento_status CHECK (status IN ('Pendente', 'Pago', 'Atrasado', 'Cancelado'))
) COMMENT='Lançamentos e pagamentos referentes às matrículas';


-- 11. AVALIACAO_FISICA

CREATE TABLE AVALIACAO_FISICA (
    idAvaliacao INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único da avaliação física',
    idPessoaAluno INT NOT NULL COMMENT 'Aluno avaliado (referencia ALUNO.idPessoa)',
    idPessoaFuncionario INT NOT NULL COMMENT 'Funcionário que realizou a avaliação (referencia FUNCIONARIO.idPessoa)',
    data_avaliacao DATE NOT NULL COMMENT 'Data em que a avaliação física foi realizada',
    peso DECIMAL(5, 2) NOT NULL COMMENT 'Massa corporal do aluno em quilogramas (kg)',
    altura DECIMAL(3, 2) NOT NULL COMMENT 'Estatura do aluno em metros (m)',
    percentual_gordura DECIMAL(5, 2) NULL COMMENT 'Percentual estimado de gordura corporal (%)',
    cintura DECIMAL(5, 2) NULL COMMENT 'Circunferência da cintura em cm (decomposição 1FN de medidas_corporais)',
    bracos DECIMAL(5, 2) NULL COMMENT 'Circunferência dos braços em cm (decomposição 1FN de medidas_corporais)',
    quadril DECIMAL(5, 2) NULL COMMENT 'Circunferência do quadril em cm (decomposição 1FN de medidas_corporais)',
    pernas DECIMAL(5, 2) NULL COMMENT 'Circunferência das pernas/coxas em cm (decomposição 1FN de medidas_corporais)',
    peito DECIMAL(5, 2) NULL COMMENT 'Circunferência torácica/peitoral em cm (decomposição 1FN de medidas_corporais)',
    resultados TEXT NULL COMMENT 'Síntese diagnóstica e índices calculados (IMC, RCQ, etc.)',
    observacoes TEXT NULL COMMENT 'Restrições médicas, anamnese ou recomendações gerais',
    CONSTRAINT pk_avaliacao_fisica PRIMARY KEY (idAvaliacao),
    CONSTRAINT fk_avaliacao_aluno FOREIGN KEY (idPessoaAluno)
        REFERENCES ALUNO (idPessoa)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_avaliacao_funcionario FOREIGN KEY (idPessoaFuncionario)
        REFERENCES FUNCIONARIO (idPessoa)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_avaliacao_peso CHECK (peso > 0),
    CONSTRAINT chk_avaliacao_altura CHECK (altura > 0),
    CONSTRAINT chk_avaliacao_gordura CHECK (percentual_gordura BETWEEN 0 AND 100)
) COMMENT='Histórico de avaliações físicas e medidas corporais dos alunos';


-- 12. PROGRAMA_TREINAMENTO

CREATE TABLE PROGRAMA_TREINAMENTO (
    idPrograma INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único da ficha ou programa de treino',
    idPessoaAluno INT NOT NULL COMMENT 'Aluno destinatário do programa (referencia ALUNO.idPessoa)',
    idPessoaProfessor INT NOT NULL COMMENT 'Professor responsável pela elaboração (referencia PROFESSOR.idPessoa)',
    objetivo VARCHAR(100) NOT NULL COMMENT 'Meta específica do ciclo de treino (ex.: Força, Resistência, Hipertrofia)',
    data_criacao DATE NOT NULL COMMENT 'Data de criação/prescrição do programa',
    data_validade DATE NOT NULL COMMENT 'Data recomendada para reavaliação ou troca do programa',
    observacoes TEXT NULL COMMENT 'Orientações gerais de execução, frequência semanal e cuidados',
    CONSTRAINT pk_programa_treinamento PRIMARY KEY (idPrograma),
    CONSTRAINT fk_programa_aluno FOREIGN KEY (idPessoaAluno)
        REFERENCES ALUNO (idPessoa)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_programa_professor FOREIGN KEY (idPessoaProfessor)
        REFERENCES PROFESSOR (idPessoa)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_programa_datas CHECK (data_validade >= data_criacao)
) COMMENT='Programas e fichas de treinamento prescritos aos alunos';


-- 13. EXERCICIO

CREATE TABLE EXERCICIO (
    idExercicio INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único do exercício no catálogo',
    nome VARCHAR(100) NOT NULL COMMENT 'Nome técnico ou usual do exercício (ex.: Supino Reto, Agachamento)',
    grupo_muscular VARCHAR(50) NOT NULL COMMENT 'Grupamento muscular predominante (ex.: Peitoral, Quadríceps, Costas)',
    nivel_dificuldade VARCHAR(20) NOT NULL COMMENT 'Grau de complexidade motora/técnica (Iniciante, Intermediário ou Avançado)',
    descricao TEXT NULL COMMENT 'Resumo funcional do movimento e equipamentos envolvidos',
    instrucoes TEXT NULL COMMENT 'Passo a passo de postura, execução e respiração',
    CONSTRAINT pk_exercicio PRIMARY KEY (idExercicio),
    CONSTRAINT uk_exercicio_nome UNIQUE (nome),
    CONSTRAINT chk_exercicio_dificuldade CHECK (nivel_dificuldade IN ('Iniciante', 'Intermediário', 'Avançado'))
) COMMENT='Catálogo de exercícios físicos da academia';


-- 14. PROGRAMA_EXERCICIO

CREATE TABLE PROGRAMA_EXERCICIO (
    idPrograma INT NOT NULL COMMENT 'Identificador do programa de treino (referencia PROGRAMA_TREINAMENTO.idPrograma)',
    idExercicio INT NOT NULL COMMENT 'Identificador do exercício prescrito (referencia EXERCICIO.idExercicio)',
    ordem INT NOT NULL COMMENT 'Sequência de execução do exercício dentro do programa',
    series INT NOT NULL COMMENT 'Quantidade de séries prescritas',
    repeticoes VARCHAR(20) NOT NULL COMMENT 'Número ou faixa de repetições (ex.: 12, 10-12, 30s)',
    carga_recomendada DECIMAL(6, 2) NULL COMMENT 'Carga inicial sugerida em quilogramas (kg)',
    intervalo_descanso INT NULL COMMENT 'Tempo de recuperação entre séries em segundos',
    CONSTRAINT pk_programa_exercicio PRIMARY KEY (idPrograma, idExercicio),
    CONSTRAINT fk_prog_exec_programa FOREIGN KEY (idPrograma)
        REFERENCES PROGRAMA_TREINAMENTO (idPrograma)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_prog_exec_exercicio FOREIGN KEY (idExercicio)
        REFERENCES EXERCICIO (idExercicio)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_prog_exec_ordem CHECK (ordem > 0),
    CONSTRAINT chk_prog_exec_series CHECK (series > 0),
    CONSTRAINT chk_prog_exec_carga CHECK (carga_recomendada >= 0),
    CONSTRAINT chk_prog_exec_descanso CHECK (intervalo_descanso >= 0)
) COMMENT='Tabela associativa N:N que define a prescrição dos exercícios em cada programa';


-- 15. MODALIDADE

CREATE TABLE MODALIDADE (
    idModalidade INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único da modalidade',
    nome VARCHAR(80) NOT NULL COMMENT 'Nome da modalidade (ex.: Spinning, Zumba, Yoga, Cross Training)',
    duracao_media INT NOT NULL COMMENT 'Duração padrão das sessões em minutos',
    intensidade VARCHAR(20) NOT NULL COMMENT 'Nível médio de esforço físico (Baixa, Moderada, Alta ou Muito Alta)',
    descricao TEXT NULL COMMENT 'Descrição das características e benefícios da modalidade',
    CONSTRAINT pk_modalidade PRIMARY KEY (idModalidade),
    CONSTRAINT uk_modalidade_nome UNIQUE (nome),
    CONSTRAINT chk_modalidade_duracao CHECK (duracao_media > 0),
    CONSTRAINT chk_modalidade_intensidade CHECK (intensidade IN ('Baixa', 'Moderada', 'Alta', 'Muito Alta'))
) COMMENT='Cadastro das modalidades esportivas e de condicionamento da academia';


-- 16. PROFESSOR_MODALIDADE

CREATE TABLE PROFESSOR_MODALIDADE (
    idPessoaProfessor INT NOT NULL COMMENT 'Professor habilitado (referencia PROFESSOR.idPessoa)',
    idModalidade INT NOT NULL COMMENT 'Modalidade associada (referencia MODALIDADE.idModalidade)',
    CONSTRAINT pk_professor_modalidade PRIMARY KEY (idPessoaProfessor, idModalidade),
    CONSTRAINT fk_prof_mod_professor FOREIGN KEY (idPessoaProfessor)
        REFERENCES PROFESSOR (idPessoa)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_prof_mod_modalidade FOREIGN KEY (idModalidade)
        REFERENCES MODALIDADE (idModalidade)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) COMMENT='Tabela associativa N:N entre professores e modalidades que ministram';


-- 17. AULA

CREATE TABLE AULA (
    idAula INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único da aula agendada',
    idModalidade INT NOT NULL COMMENT 'Modalidade da aula (referencia MODALIDADE.idModalidade)',
    idPessoaProfessor INT NOT NULL COMMENT 'Professor responsável pela aula (referencia PROFESSOR.idPessoa)',
    data DATE NOT NULL COMMENT 'Data de realização da aula',
    hora_inicio TIME NOT NULL COMMENT 'Horário de início da aula',
    hora_fim TIME NOT NULL COMMENT 'Horário previsto de encerramento da aula',
    local VARCHAR(60) NOT NULL COMMENT 'Sala, estúdio ou espaço físico onde ocorre a aula',
    capacidade_maxima INT NOT NULL COMMENT 'Limite máximo de alunos participantes na aula',
    CONSTRAINT pk_aula PRIMARY KEY (idAula),
    CONSTRAINT fk_aula_modalidade FOREIGN KEY (idModalidade)
        REFERENCES MODALIDADE (idModalidade)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_aula_professor FOREIGN KEY (idPessoaProfessor)
        REFERENCES PROFESSOR (idPessoa)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_aula_capacidade CHECK (capacidade_maxima > 0),
    CONSTRAINT chk_aula_horarios CHECK (hora_fim > hora_inicio)
) COMMENT='Agenda e programação das aulas oferecidas pela academia';


-- 18. PARTICIPACAO_AULA

CREATE TABLE PARTICIPACAO_AULA (
    idPessoaAluno INT NOT NULL COMMENT 'Aluno inscrito ou participante (referencia ALUNO.idPessoa)',
    idAula INT NOT NULL COMMENT 'Aula vinculada (referencia AULA.idAula)',
    presenca BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'Indicador de presença (TRUE = Presente, FALSE = Ausente/Agendado)',
    data_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data e hora do agendamento ou registro de presença',
    CONSTRAINT pk_participacao_aula PRIMARY KEY (idPessoaAluno, idAula),
    CONSTRAINT fk_part_aula_aluno FOREIGN KEY (idPessoaAluno)
        REFERENCES ALUNO (idPessoa)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_part_aula_aula FOREIGN KEY (idAula)
        REFERENCES AULA (idAula)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) COMMENT='Tabela associativa N:N de inscrição e controle de presença dos alunos nas aulas';