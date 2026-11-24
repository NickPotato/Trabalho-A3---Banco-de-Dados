-- Script SQL DQL - Banco de dados Academia 

-- data query/search
USE db_academia;

-- getting reports using SELECT and JOIN

-- student and plan info
SELECT 
    a.idPessoa AS id_aluno,
    p.nome AS nome_aluno,
    pl.nome AS plano_contratado,
    m.data_inicio,
    m.data_fim,
    m.valor_contratado
FROM ALUNO a
JOIN PESSOA p ON a.idPessoa = p.idPessoa
JOIN MATRICULA m ON a.idPessoa = m.idPessoaAluno
JOIN PLANO pl ON m.idPlano = pl.idPlano
WHERE m.status = 'Ativa'
ORDER BY p.nome;

-- financial report with payments
SELECT 
    p.nome AS nome_aluno,
    pg.valor,
    pg.metodo_pagamento,
    pg.data_pagamento,
    pg.status AS status_pagamento
FROM PAGAMENTO pg
JOIN MATRICULA m ON pg.idMatricula = m.idMatricula
JOIN ALUNO a ON m.idPessoaAluno = a.idPessoa
JOIN PESSOA p ON a.idPessoa = p.idPessoa
WHERE pg.status = 'Pago'
ORDER BY pg.data_pagamento DESC;

-- student workout plan
SELECT 
    p_aluno.nome AS aluno,
    p_prof.nome AS professor_responsavel,
    pt.objetivo,
    pe.ordem,
    e.nome AS exercicio,
    e.grupo_muscular,
    pe.series,
    pe.repeticoes,
    pe.carga_recomendada
FROM PROGRAMA_TREINAMENTO pt
JOIN PESSOA p_aluno ON pt.idPessoaAluno = p_aluno.idPessoa
JOIN PESSOA p_prof ON pt.idPessoaProfessor = p_prof.idPessoa
JOIN PROGRAMA_EXERCICIO pe ON pt.idPrograma = pe.idPrograma
JOIN EXERCICIO e ON pe.idExercicio = e.idExercicio;

-- teacher info and their allowed areas
SELECT 
    p.nome AS nome_professor,
    pr.cref,
    pr.especialidade,
    pr.nivel_experiencia,
    m.nome AS modalidade_habilitada
FROM PROFESSOR pr
JOIN PESSOA p ON pr.idPessoa = p.idPessoa
JOIN PROFESSOR_MODALIDADE pm ON pr.idPessoa = pm.idPessoaProfessor
JOIN MODALIDADE m ON pm.idModalidade = m.idModalidade
ORDER BY p.nome;

-- students' physical evaluations (+the evaluator)
SELECT 
    p_aluno.nome AS aluno,
    p_func.nome AS avaliador,
    av.data_avaliacao,
    av.peso,
    av.altura,
    av.percentual_gordura,
    av.resultados
FROM AVALIACAO_FISICA av
JOIN PESSOA p_aluno ON av.idPessoaAluno = p_aluno.idPessoa
JOIN PESSOA p_func ON av.idPessoaFuncionario = p_func.idPessoa
ORDER BY p_aluno.nome, av.data_avaliacao DESC;