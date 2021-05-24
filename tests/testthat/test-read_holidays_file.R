test_that('Contents read from holiday file are correct', {

  contents <- 
    'Confraternização Universal;  01/01/21;  
Carnaval;  15/02/21;  16/02/21
Quarta-feira de Cinzas;  17/02/21;  
Paixão de Cristo;  02/04/21;  
Recesso – Ponto Facultativo;  03/04/21;  
Rio das Ostras;   10/04/21;
Tiradentes;  21/04/21;  
São Jorge;  23/04/21;  
Dia Mundial do Trabalho;  01/05/21;  
Corpus Christi;  03/06/21;  
Recesso – Ponto Facultativo;  06/09/21;  
Independência do Brasil;  07/09/21;  
Recesso – Ponto Facultativo;  11/10/21;  
Nossa Senhora Aparecida;  12/10/21;  
Dia do Professor (Recesso – Ponto Facultativo);  15/10/21;  
Servidor Público (28/10), postergado pela Portaria 430/2020;  01/11/21;  
Finados;  02/11/21;  
Proclamação da República;  15/11/21;  
Dia da Consciência Negra;  20/11/21;  
Véspera de Natal e Natal;  24/12/21;  25/12/21
Véspera de Ano Novo;  31/12/21;  
'

  expect_equal(read_holidays_file(), contents)
  
})
