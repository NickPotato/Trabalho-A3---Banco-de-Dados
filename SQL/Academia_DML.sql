-- Script SQL DML - Banco de dados Academia 

-- data manipulationnnnn
USE db_academia;

-- filling up the database with placeholder data using INSERT INTO

-- pessoa 
-- teacher taught us to do one line at a time but doing it like this looks a little cleaner, so
INSERT INTO PESSOA(idPessoa, nome, cpf, rg, sexo, data_nascimento, rua, numero, bairro, cidade, uf) VALUES
(1, "João Felipe Cardoso", 11122233344, 1234567, "M", "1998-02-02", "Rua Pedra Lisa", 100, "Centro", "Florianópolis", "SC"),
(2, "Monica Costa da Silva", 11122233345, 1234568, "F", "2000-03-03", "Rua Grama Seca", 22, "Centro", "Florianópolis", "SC"),
(3, "Ricardo Costa da Silva", 11122233346, 1234569, "M", "2000-03-03", "Rua Grama Seca", 22, "Centro", "Florianópolis", "SC"),
(4, "Caio Lopez Monteiro", 11122233347, 1234560, "M", "2003-07-24", "Rua Morcego", 203, "Trindade", "Florianópolis", "SC"),
(5, "Marina Onça Castro", 11122233348, 1234561, "F", "2002-12-12", "Rua Rapadura", 40, "Estreito", "Florianópolis", "SC"),
(6, "Sarah Ferreira Lima", 11122233349, 1234562, "F", "2005-04-03", "Rua Castelo Branco", 109, "Coqueiros", "Florianópolis", "SC");

-- pessoa email
-- exists cause one person can have multiple emails, though that's not the case here
INSERT INTO PESSOA_EMAIL(idPessoa, email) VALUES
(1, "jaofelps@gmail.com"),
(2, "monicacosta@gmail.com"),
(3, "ricardo1019@gmail.com"),
(4, "caioLM10@gmail.com"),
(5, "marinacas@gmail.com"),
(6, "sarahfeli102@gmail.com");

-- pessoa telefone
INSERT INTO PESSOA_TELEFONE(idPessoa, telefone) VALUES
(1, 01234567890),
(2, 01234567891),
(3, 01234567892),
(4, 01234567893),
(5, 01234567894),
(6, 01234567895),
(6, 01234567896);

-- aluno
INSERT INTO ALUNO(idPessoa, data_ingresso, objetivo_principal, situacao_cadastro) VALUES
(1, "2026-02-10", "Ganho de massa muscular", "Ativo"), -- default is "ativo" but I gotta set it anyway
(2, "2026-05-03", "Emagrecimento", "Ativo"),
(3, "2026-07-12", "Condicionamento Físico", "Ativo");

-- funcionario
INSERT INTO FUNCIONARIO(idPessoa, data_contratacao, cargo, salario) VALUES
(4, "2024-05-05", "Professor", 4500.00),
(5, "2023-10-09", "Professora", 4700.00),
(6, "2025-02-03", "Avaliadora", 2900.00);

-- professor
INSERT INTO PROFESSOR(idPessoa, cref, especialidade, nivel_experiencia) VALUES
(4, "123456-G/SC", "Musculação", "Sênior"),
(5, "123457-G/SC", "Pilates", "Sênior");

-- disponibilidade do prof
INSERT INTO PROFESSOR_DISPONIBILIDADE(idPessoa, disponibilidade) VALUES
(4, "Segunda a Quinta - Manhã/Tarde"),
(4, "Sexta - Noite"),
(5, "Segunda a Sexta - Manhã"),
(5, "Sábado - Manhã/Tarde");

-- plano
INSERT INTO PLANO(idPlano, nome, modalidade_acesso, descricao, duracao, valor) VALUES
(1, "Mensal Musculação", "Musculação", "Acesso a musculação por 30 dias", 30, 130.00),
(2, "Trimestral Plus", "Musculação/Coletivas", "Acesso a musculação e aulas coletivas por 90 dias", 90, 350.00),
(3, "Anual VIP", "Livre", "Acesso completo + direito de avaliação física bimestral", 365, 1200.00);

-- matricula
INSERT INTO MATRICULA(idMatricula, idPessoaAluno, idPlano, data_inicio, data_fim, status, valor_contratado) VALUES
(1, 1, 1, "2026-02-10", "2026-03-10", "Ativa", 130.00),
(2, 2, 3, "2026-05-03", "2027-05-03", "Ativa", 1200.00),
(3, 3, 2, "2026-07-12", "2026-10-12", "Ativa", 350.00);

-- pagamento
INSERT INTO PAGAMENTO(idPagamento, idMatricula, data_vencimento, data_pagamento, valor, metodo_pagamento, status) VALUES
(1, 1, "2026-03-10", "2026-03-10", 130.00, "Cartão de Crédito", "Pago"),
(2, 2, "2026-05-03", "2026-05-03", 1200.00, "PIX", "Pago"),
(3, 3, "2026-10-12", "2026-10-12", 350.00, "PIX", "Pago");

-- ava física
INSERT INTO AVALIACAO_FISICA(idAvaliacao, idPessoaAluno, idPessoaFuncionario, data_avaliacao, peso, altura, percentual_gordura, cintura, bracos, quadril, pernas, peito, resultados, observacoes) VALUES
(1, 1, 6, "2026-03-15", 78, 1.80, 16.60, 82.00, 98.00, 35.50, 58.00, 102.00, "Bom condicionamento inicial, focar em ganhar massa magra", "Nenhuma restrição muscular"),
(2, 2, 6, "2026-05-05", 65, 1.68, 26.60, 76.00, 104.00, 29.50, 56.00, 90.00, "Indicado o fortalecimento do core + treino aeróbico", "Leve desconforto lombar");

-- programa treino
INSERT INTO PROGRAMA_TREINAMENTO(idPrograma, idPessoaAluno, idPessoaProfessor, objetivo, data_criacao, data_validade, observacoes) VALUES
(1, 1, 4, "Ganho de massa magra", "2026-03-18", "2026-04-18", "Aumentar carga progressivamente"),
(2, 2, 5, "Fortalecimento do core e emagrecimento", "2026-05-07", "2027-05-07", "Evitar sobrecarga axial na coluna lombar");

-- exercicio
INSERT INTO EXERCICIO(idExercicio, nome, grupo_muscular, nivel_dificuldade, descricao, instrucoes) VALUES
(1, 'Supino Reto com Barra', 'Peitoral', 'Intermediário', 'Exercício multiarticular para peitoral.', 'Manter escápulas retraídas e descer a barra até a linha do peito.'),
(2, 'Agachamento Livre', 'Quadríceps', 'Avançado', 'Agachamento com barra apoiada no trapézio.', 'Manter coluna neutra e descer até quebrar a paralela.'),
(3, 'Prancha Abdominal Isométrica', 'Abdômen', 'Iniciante', 'Sustentação corporal apoiado nos antebraços.', 'Contrair glúteos e abdômen mantendo o quadril alinhado.');

-- programa exercicio
INSERT INTO PROGRAMA_EXERCICIO(idPrograma, idExercicio, ordem, series, repeticoes, carga_recomendada, intervalo_descanso) VALUES
(1, 1, 1, 4, "10 a 12", 40.00, 90),
(1, 2, 2, 4, "8 a 10", 60.00, 120),
(2, 3, 1, 3, "45 segundos", NULL, 45);

-- modalidade
INSERT INTO MODALIDADE(idModalidade, nome, duracao_media, intensidade, descricao) VALUES
(1, "Musculação", 50, "Alta", "Treinamento resistido com pesos livres e máquinas"),
(2, "Pilates", 50, "Baixa", "Exercícios de controle postural, respiração e flexibilidade"),
(3, "Spinning", 45, "Moderada", "Ciclismo indoor para cardio com música");

-- prof modalidade
INSERT INTO PROFESSOR_MODALIDADE(idPessoaProfessor, idModalidade) VALUES 
(4, 1),
(4, 3), 
(5, 2); -- id 5 is pilates girl
-- this one was easy, nice

-- aula
INSERT INTO AULA(idAula, idModalidade, idPessoaProfessor, data, hora_inicio, hora_fim, local, capacidade_maxima) VALUES
(1, 3, 4, "2026-05-10", "08:00:00", "08:50:00", "Sala Bike", 15),
(2, 2, 5, "2026-05-10", "08:00:00", "08:50:00", "Sala Zen 01", 20);

-- presença/participação
INSERT INTO PARTICIPACAO_AULA(idPessoaAluno, idAula, presenca, data_registro) VALUES
(1, 1, TRUE, "2026-05-10"),
(2, 2, TRUE, "2026-05-10");
-- that's all 18 done

-- we're required to use UPDATE/DELETE as well so here's the last section with those: 
-- updating data 
UPDATE FUNCIONARIO 
SET salario = salario * 1.05 -- readjusting teacher salary by 5%
WHERE cargo LIKE "Professor%";

-- deleting data
DELETE FROM PESSOA_TELEFONE
WHERE idPessoa = 6 AND telefone = 01234567896; -- getting rid of the extra phone number for the last employee
-- i accidentally checked for a string instead of an int the first time i was doing this lmao