#### 06/09/2023

Curso de Elixir: Recursão, Enums e formas de execução

@1-Mais sobre funções 

@@01
Apresentação

[00:00] Sejam muito bem-vindos à Alura. Eu sou o Vinicius Dias e vou guiar vocês nesse treinamento onde vamos criar uma aplicação com Elixir.
[00:08] Já adquirimos certo conhecimento com Elixir, já sabemos um pouco da sintaxe básica, já aprendemos sobre pattern matching, bastante sobre recursão e até formas de execução do código Elixir.

[00:18] Mas nesse treinamento vamos criar uma aplicação real. Inclusive eu tenho um gerenciador de tarefas da Erlang, rodando e mostrando os processos que vamos criar.

[00:28] Teremos um agendador de tarefas que de minuto em minuto vai enviar uma mensagem para um outro processo, que é um servidor que criamos. Essa mensagem será recebida e um número aleatório será escrito no arquivo. Ou seja, de minuto em minuto o número vai mudar.

[00:43] Claro que essa aplicação parece simples, mas para isso teremos que aprender bastante coisa interessante.

[00:48] Começaremos falando do ecossistema do Elixir, como funciona se um processo morrer, como buscar dependências externas e como unir isso tudo.

[00:56] Depois daremos um passo atrás e entenderemos o que é esse conceito de processos, que é diferente no sistema operacional e na Erlang, e, por consequência, no Elixir. Então falaremos bastante sobre processos, comunicação entre eles e abstrações.

[01:09] Depois disso estaremos prontos para criar uma tarefa utilizando o Mix, que é uma ferramenta bastante interessante. A partir disso poderemos criar uma aplicação real. E essa aplicação vai gerenciar esses dois processos diferentes se comunicando.

[01:22] No final de tudo conseguiremos executar testes. Então não só nós vamos executar os testes que já vêm por padrão, mas vamos entender o que é o tal do doctest, criar testes nossos até utilizando Mox e recursos da própria Erlang.

[01:39] Então vale muito a pena acompanhar esse treinamento, e se em algum momento você tiver alguma dúvida, não hesite. Existe um fórum para alunos e você pode abrir sua dúvida lá.

[01:48] Eu tento responder pessoalmente sempre que possível, mas quando eu não consigo, temos uma comunidade de alunos, de moderadores e instrutores muito solícita, e com certeza alguém vai conseguir te ajudar.

[01:58] Agora chega de falar sobre o que veremos e vamos começar a ver. No próximo vídeo já começamos a entender um pouco sobre o ecossistema do Elixir.

@@02
Guard clauses

[00:00] Pessoal, bem-vindos de volta. Vamos falar um pouco mais sobre funções, rever alguns conceitos, ver novos conceitos e, claro, praticar. Aqui no nosso módulo de matemática, aquele arquivo "math.exs", eu quero adicionar uma nova função além do soma que já temos aqui. Eu vou adicionar uma função que verifica se o número que foi passado por parâmetro é 0 ou não.
[00:21] Eu vou ter aqui uma função chamada zero?. Podemos utilizar esses caracteres em definições de funções, ponto de interrogação, ponto de exclamação. Não podemos usar qualquer carácter, mas esses dois pontos podemos. E aqui vou receber algum parâmetro, que vai ser o número, e dependendo do número que é passado ou retorno verdadeiro ou falso. def zero?(numero), do: true.

[00:44] Vamos lá. Deixa eu apagar esse end porque eu não vou precisar, vou precisar de uma linha só. E se eu receber aqui o zero, ou seja, estou utilizando pattern matching para garantir que quando um parâmetro, cujo valor é 0, for recebido aqui, essa função que vai ser executada. Agora se eu receber qualquer outra coisa, ou seja, um parâmetro que eu nem preciso utilizar, então vou utilizar o underline, o underscore, vou retornar false. def zero?(0), do: true def zero? (_), do: false.

[01:11] Temos aqui a função zero? definida. Se eu receber 0, eu vou retornar verdadeiro, caso contrário, eu vou retornar falso. Vamos ver lá no nosso iex, carregando esse módulo de matemática, o que temos de retorno. Quando eu executo MeuModulo.Math.zero?(0) é verdadeiro, com algum valor diferente de 0 é falso. Perfeito. Até aqui nada novo. Praticamos o pattern matching, praticamos também o uso de caracteres diferentes na definição de funções.

[01:44] Só que tem um outro detalhe: se eu passar alguma coisa que nem é um inteiro aqui, eu não quero receber falso, eu quero um erro, quero que essa função só funcione para quando eu receber um inteiro. O que vou adicionar aqui? Antes do meu do:, ou seja, antes da implementação dessa minha função, antes do corpo dela, eu vou adicionar uma cláusula de guarda, ou seja, eu vou informar alguma coisa que vai ser uma verificação a mais para quando só o pattern matching não é o suficiente.

[02:13] Aqui eu utilizei o pattern matching para pegar quando isso aqui é 0, mas e se eu quiser executar essa outra função aqui somente quando for um inteiro? Eu posso adicionar when. Esse when faz o quê? Ele realiza uma verificação para garantir que essa função vai ser executada ou não. Eu posso executar a função ou não dependendo de algumas condições.

[02:35] Aqui eu vou precisar nomear essa variável porque eu vou verificar quando essa variável é inteira, ou seja, quando nosso X for um valor inteiro. Caso o nosso X não seja um valor inteiro, não seja 0, nem qualquer outro valor inteiro, nenhuma das funções zero? vai ser encontrada, então vamos ter um erro, a função não vai executar com sucesso. def zero?(0), do: true def zero?(x) whe(is)integer(x)), do: false.

[02:59] Deixa eu recarregar o MeuModulo.Math, garantir que eu não escrevi nada errado e vamos lá. Quando eu chamo a função para 0, continua retornando true, quando eu chamo para algum diferente que seja diferente de 0, ele retorna false, e quando eu chamo para alguma coisa que não é um inteiro, temos um erro. Não encontramos essa função. Nenhuma função candidata foi encontrada.

[03:22] Nenhuma cláusula de função está casando com os parâmetros que você passou e o parâmetro, no caso, foi uma lista. Quando você olha as nossas definições, temos uma cláusula, e é interessante conhecermos esse nome também, uma definição de função pode ser conhecida, pode ser chamada de cláusula e a mesma função pode ter várias cláusulas. Aqui eu tenho uma onde o parâmetro é 0 necessariamente, aqui eu tenho outra onde o parâmetro é qualquer coisa diferente de 0, porque se for 0 é essa aqui que vai ser executada.

[03:52] Só que, além disso, além de ser qualquer coisa diferente de 0, precisa ser um inteiro, o seja, essa função aqui precisa retornar verdadeiro. Quando eu passo essa lista para função is_integer o que acontece? Ela vai me retornar falso, então essa função deixa de ser uma candidata viável para executar com esse parâmetro.

[04:13] Podemos utilizar muita coisa aqui dentro das nossas cláusulas de guarda. Não podemos utilizar qualquer função, uma função que criarmos, por exemplo, só que podemos criar, podemos utilizar as funções que começam is_ porque isso aqui já são funções do próprio Elixir que são permitidas de utilizar aqui, podemos utilizar os operadores + e -, etc., enfim, bastante coisa pode ser utilizada e conforme a nossa necessidade vai aumentando, vamos experimentando novas funções, às vezes até operadores.

[04:46] Essa é a ideia por trás de cláusulas de guarda, adicionamos verificações para saber se a função vai ser chamada ou não e, dessa forma, nós podemos ter definições diferentes para a mesma função baseado no parâmetro que foi passado além do que o pattern matching já fornece para nós.

[05:05] Temos aqui uma nova funcionalidade de cláusula de guarda. Agora eu quero fazer uma coisa diferente. Ao invés de tratar com números, eu quero lidar um pouco mais com string. Eu quero criar uma função que junte duas strings e coloque um separador no meu. Por exemplo, se eu passar um espaço, vai ficar uma string espaço a outra. Só que eu quero ter um valor padrão para esse parâmetro de separador. Vamos falar de funções com valores padrão no próximo vídeo.

@@03
Guards

Vimos neste vídeo que uma definição de função pode ser chamada de "cláusula" em Elixir (clause em inglês). Estas cláusulas podem ter guardas.
Quando usar estes guardas de cláusula em Elixir?

Não há motivos para usar guards. Pattern matching é o suficiente.
 
Alternativa correta
Quando pattern matching não for suficiente para decidir se uma função deve ser executada ou não.
 
Alternativa correta! Às vezes queremos filtrar quando nossa função pode ou não ser executada, mas apenas pattern matching não é suficiente já que precisamos realizar alguma operação ou chamar outra função. Nestes cenários, usamos guards.
Alternativa correta
Quando quisermos melhorar a legibilidade e não usar pattern matching para decidir se uma função deve ser executada.

@@04
Parâmetros padrão

[00:00] Pessoal, bem-vindos de volta. Como eu comentei, quero criar uma função que una duas strings. Eu recebo uma string A e uma string B e algum separador, eu vou utilizar esse separador para ficar entre essas duas strings. Vamos criar aqui um arquivo que eu vou chamar de "concat.exs".
[00:25] Eu vou criar aqui um módulo, então vou definir um módulo que vai ser "MeuModulo.Concat", de concatenação, que eu vou concatenar strings. Eu vou definir uma função chamada join, de unir. Eu vou receber uma string A, string B e um separador. def join(string_a, string_b, separador). O que eu quero fazer? Eu quero retornar a string A, unida com o separador, unida com a string B. string_a <> separador <> string_b.

[00:52] É bastante simples. Vamos abrir o nosso iex e garantir que tudo continue funcionando, que essa função funcione. MeuModulo.Concat.join("Olá", "Mundo", " "), eu vou separar isso aqui com um espaço. Tenho lá "Olá Mundo" unidos com esse espaço. Agora o que eu quero fazer é exatamente fazer com que o separador tenha um valor padrão, que seja o espaço.

[01:21] Eu não preciso informar esse último parâmetro aqui. Vamos fazer exatamente isso. Deixa eu fechar aqui o nosso terminal. Para eu adicionar um valor padrão, para eu informar: se nenhum valor for passado para separador, o valor padrão dessa variável vai ser espaço. Eu posso fazer isso através de \\ e coloco o valor padrão que eu quero, no meu caso o espaço. def join(string_a, string_b, separador \\ " ").

[01:45] Deixa eu recompilar o MeuModulo.Concat, nenhum erro. Agora quando eu executar esse mesmo código sem o último parâmetro, mesmo que eu esteja passando somente dois parâmetros, ele vai encontrar essa função que tem três parâmetros, por quê? Porque o último é opcional, ele tem um valor padrão, então se eu não informar nada, esse vai ser o valor utilizado.

[02:08] Tudo continua funcionando, mas se eu quiser passar algum outro separador, por exemplo o underline, também funciona. Agora um outro detalhe. Imagina que eu queira, assim como não quero passar esse último parâmetro, eu quero poder passar só o primeiro parâmetro, ou seja, se eu não passar esse segundo parâmetro, eu vou retornar direto somente a string A, a primeira string.

[02:30] Hoje, isso ainda não funciona, então vamos implementar isso. Eu vou criar aqui uma nova função, def join(string_a, string_b, _separador), esse separador nem vou utilizar, então coloquei um underline na frente. Só que eu quero isso quando for nulo a minha string B. def join(string_a, string_b, _separador) when(is_nil(string_b)).

[02:59] O que eu estou utilizando aqui? Estou utilizando uma cláusula de guarda e uma função is_nil, isso retorna se um valor é nulo ou não. "Mas Vinicius, esse valor não é nulo, o valor de string B simplesmente não vai existir, não é que é nulo", então vou transforma-lo também em um valor padrão aqui. def join(string_a, string_b, \\ nil, separador \\ " "). Só que aí entra um questionamento: será que eu preciso repetir essa declaração dos valores padrão nessa outra função também?

[03:23] Vamos ver. Primeiro deixa eu retornar o que eu quero, que é somente a string A, ou seja, vamos recapitular o que eu fiz. Se eu passo os três parâmetros ou somente dois, eu vou executar essa função aqui e o separador pode ser um valor padrão, que vai ser o espaço, ou o que foi passado. Eu vou unir esses três parâmetros aqui, a string A, o separador e a string B.

[03:44] Já se eu não passar o último parâmetro, o meu valor padrão é o espaço, então o separador vai ser o espaço. E se eu passar somente o primeiro parâmetro, eu quero retornar ele direto. Eu estou verificando se o segundo parâmetro for nulo, porque é o valor padrão que estou informando aqui, eu vou ignorar ele e retornar direto o primeiro parâmetro.

[04:06] Vamos recompilar esse módulo e ver o que acontece. Aqui eu tenho um aviso, "a nossa cláusula de join com três parâmetros, não vamos conseguir fazer um match porque a anterior sempre vai casar". O que isso quer dizer? Vamos lá. Não existe nenhum caso onde vamos chegar nessa segunda aqui, só pela definição. Vamos precisar dessa nossa cláusula de guarda. Tudo bem, até aí ok. Vamos ver que tem um outro detalhe aqui.

[04:38] Essa "join/3" tem múltiplas cláusulas de guarda, ou seja, tem muitas cláusulas, tem múltiplas definições dessa função, só que apesar de ter múltiplas definições, estamos definindo os valores padrão em um lugar separado, em lugares que o Elixir está se confundindo. Vamos simplificar aqui.

[04:58] O que precisamos fazer? Eu preciso informar: Elixir, esses são os valores padrão desta função, independente de quantas definições, de quantas cláusulas eu tiver, os valores são esses. Como eu posso fazer isso? Eu posso utilizar algo que a galera de C deve se lembrar, que são os cabeçalhos de função. Eu vou copiar isso daqui e colocar aqui em cima, ou seja, nesse momento eu vou ter somente o cabeçalho, aqui eu não tenho o corpo da minha função.

[05:26] Agora eu posso ter várias definições em si, vários corpos da minha função e eu não preciso informar os valores padrão, porque eles já foram informados aqui em cima. Só que pensa comigo: o Elixir vai avaliando de cima para baixo aquelas funções, então vimos aquele outro aviso, aquele outro warning, por quê? O Elixir nunca vai chegar nessa outra função aqui, porque essa cláusula de guarda nunca nem vai ser avaliada.

[05:52] O que acontece? Se eu passar nulo ou não passar o segundo parâmetro, ainda assim ele vai cair aqui. O que eu preciso fazer nesse caso, para evitar aquele aviso, é trazer essa definição com a cláusula de guarda, como nosso when, vamos trazer ela para cima. Dessa forma, vamos ter a precedência correta.

[06:11] O que isso quer dizer? Se eu passar somente o primeiro parâmetro significa que o segundo parâmetro vai ser nulo e quando esse parâmetro é nulo, eu posso executar essa função aqui. Ele vai parar de avaliar. Certo? Basicamente isso. Um detalhe para simplificarmos um pouco: esses parênteses são opções, eu não preciso adicionar esses parênteses na cláusula de when.

[06:33] Continuando. Teoricamente, agora eu não vou ter mais avisos, então vou recompilar. Perfeito, sem aviso. Agora, vamos lá, MeuModulo.Concat.join, se eu colocar somente um valor, um valor só, isso aqui vai retornar esse próprio valor. Se eu passo um valor com outro, ele vai retornar unido com um espaço. E se eu passo o terceiro parâmetro, ele vai unir com esse separador que eu passei.

[06:58] O que temos aqui de interessante? Nós podemos ter uma definição de função e isso é utilizado quando eu tenho valores padrão em mais de uma cláusula, ou seja, em mais de uma definição de função. Para você não precisar ficar se repetindo os valores padrão em todos os lugares e o Elixir também ter uma facilidade a mais de encontrar as funções, precisamos separar o cabeçalho da função, vamos falar como a galera de C e C++ entende, eu vou separar o cabeçalho da função da sua definição em si, do seu corpo.

[07:32] Aqui nós temos o cabeçalho sendo definido com os valores padrão, só que o corpo de cada uma dessas cláusulas, de cada uma dessas funções, não precisa mais declarar de novo o valor padrão, isso já é implícito aqui. Se você reparar, nos últimos dois vídeos utilizamos algumas convenções interessantes. Eu falei que quando temos algumas funções ou macros que começam com is_alguma coisa, eu posso utilizar nas cláusulas de guarda.

[08:00] Eu também falei que como eu não estou utilizando esse parâmetro aqui, eu posso começá-lo com underline, que o Elixir não vai me avisar que eu não estou utilizando esse parâmetro, nem nada do tipo. Eu também falei que aqui podemos utilizar pontos de interrogação na definição de uma função.

[08:16] Existem vários detalhes de nomeação que, além de serem convenções, ou seja, além de serem boas práticas quando programamos em Elixir, também podem ter algum significado. Vamos entender um pouco dessas convenções de nomes que utilizamos no Elixir no próximo vídeo.

@@05
Cabeçalhos de função

Vimos neste vídeo que em determinados cenários, precisamos criar cabeçalhos de funções, de forma muito semelhante ao que fazemos em C ou C++.
Quando precisamos criar o cabeçalho de uma função?

Quando tivermos mais de uma cláusula e valores padrão para argumentos.
 
Alternativa correta! Se tivermos uma função com valores padrão em seus argumentos com mais de uma cláusula, não devemos repetir os valores padrão. Devemos separar isso em um cabeçalho.
Alternativa correta
Quando queremos deixar em evidência quais os parâmetros de determinada função.
 
Alternativa correta
Quando tivermos mais de uma cláusula de uma função.

@@06
Convenções de nome

[00:00] Pessoal, bem-vindos de volta. Como eu comentei no curso anterior, no primeiro curso que falamos de Elixir, existem dois lugares onde podemos Elixir no site oficial: temos aquele guia, que é como se fosse um tutorial muito interessante, e nós temos a documentação em si, onde é a referência oficial, com todos os parâmetros de todas as funções.
[00:20] E aqui na documentação, nós temos uma seção chamada "Naming Conventions", que são as convenções de nomenclatura que utilizamos no Elixir. Vamos dar uma passada de olho para entendermos mais ou menos quais são as recomendações, mas vou deixar esse link no "Para Saber Mais" para que você possa ler com calma.

[00:37] Começando com o "Casing", ou seja, como utilizar letras maiúsculas ou minúsculas. Sempre que estamos definindo funções e variáveis, claro que isso não é uma obrigação, podemos fazer diferente, mas devemos utilizar o formato sanke_case, ou seja, para separar palavras utilizamos o underline. Já quando estamos falando de módulos, utilizamos o camelCase, onde cada uma das palavras novas são separadas por adicionar a letra da primeira palavra em letra maiúscula.

[01:08] Já estamos utilizando essa convenção aqui. Nos nossos módulos, estamos utilizando o camelCase, ou seja, "Meu" é uma palavra, "Modulo" é a próxima, então começa com letra maiúscula, "MeuModulo". Já nas funções, temos feito todas elas com letra minúscula e se precisa separar utilizamos o underline.

[01:27] Continuando. Os átomos que criamos podem ser tanto snake_case ou camelCase, não vai ter problema, só que é padrão também, é comum utilizarmos o snake_case. É mais usual vermos sendo feito dessa forma. Aqui já vimos um detalhe. Outra coisa sobre arquivos: quando temos um arquivo de "MeuModulo.math", por exemplo, eu vou ter o nome "Meu_Modulo_math".

[01:54] Eu vou ter o nome do arquivo como snake_case e o nome do módulo em camelCase. Só que, como ele diz aqui, isso é uma convenção. No final das contas tanto faz o nome do seu arquivo, isso não importa porque no final ele vai ser compilado e etc., só que é uma boa convenção para nos encontrarmos melhor e manter as coisas organizadas.

[02:14] Uma outra convenção é de utilizar o underline. Se eu não vou utilizar um parâmetro, por exemplo, ou uma variável dentro de um pattern matching, se eu vou ignorar aquilo, eu prefixo ele, eu começo isso com o underline. Dessa forma, o nosso compilador ou interpretador não vai avisar: "olha só, você definiu aqui um parâmetro, mas não está utilizando. Você definiu uma posição aqui nessa tupla para fazer o pattern matching, mas nunca utiliza esse valor depois".

[02:41] Podemos utilizar o underline para ignorar esse valor. Às vezes eu preciso dar um nome para que faça sentido o que eu estou escrevendo, como é o caso aqui, mas o fato de termos um underscore na frente vai fazer o Elixir ignorar isso. Se estivermos funções começando com underscore, com underline, o que acontece? Mesmo que eu importe esse módulo onde a função foi definida, a função não vai ser importada, eu preciso acessá-la diretamente.

[03:07] Aqui nesse caso, eu vou precisar fazer example. _wont_be_imported. Isso é uma conversão que o Elixir usa para já alterar um pouco o comportamento. É interessante de sabermos. Até por isso que existem algumas funções internas que o Elixir define utilizando com o underline na frente para essas coisas não serem importadas.

[03:28] Agora vamos falar sobre as pontuações que podemos utilizar em nome de função. Quando temos uma função que termina com ponto de exclamação, isso significa que ao invés de retornar normalmente, essa função pode lançar um erro, pode lançar uma exceção em caso de erro. Por exemplo, até citamos esse caso de "File.read", vamos falar mais sobre ela mais para frente, mas basicamente se eu tento ler um arquivo, ela vai me retornar uma tupla e o primeiro elemento dessa tupla diz se deu tudo certo com um átomo Ok ou se teve algum erro, com átomo error.

[04:02] Só que se eu não quiser pegar isso, se eu não quiser tratar os cenários diferentes, quando eu espero que o arquivo sempre exista, esteja acessível, por exemplo, eu posso utilizar essa variação com o ponto de exclamação no final, porque se o arquivo não existir ou não estiver acessível, eu não vou ter um retorno, vou ter um erro sendo lançado, vou matar a minha aplicação ali.

[04:22] Esse aqui é o exemplo que ele utiliza. Se um pego um arquivo que não existe utilizando o "File.read", ele retorna uma tupla, ou seja, o meu programa não é interrompido, eu não paro a execução. Agora se eu utilizo "File.read!" e o arquivo não existe, vamos ter um erro, a nossa execução vai ser interrompida, a menos que tenhamos um try cat.

[04:44] A ideia é: você vai utilizar o "File.read" quando você quer tratar um cenário de erro, quer fazer alguma coisa com isso, e você vai utilizar o "File.read!" quando você não se importa, quando você parte do princípio que o arquivo está lá e está acessível. Sempre que temos funções que terminam com ponto de exclamação, essas funções podem lançar um erro, elas podem interromper a execução do nosso script.

[05:08] Aqui tem alguns exemplos dessas funções que possuem uma versão que retorna uma tupla com sucesso ou erro e uma outra versão com ponto de exclamação que lança um erro, que lança uma exceção. O "Base.decode16", o "File.cwd". Essas funções têm duas versões, com e sem o ponto de exclamação.

[05:28] Agora, como fizemos, também podemos utilizar o ponto de interrogação. Isso é basicamente uma função que retorna um booleano, uma função que retorna verdadeiro ou falso. Só que existem duas convenções para funções que retornam booleanos: a com ponto de interrogação no final e a que começa com "is_", e quando temos uma função já da linguagem, do Elixir, da biblioteca padrão que começa com "is_", entendemos que podemos utilizar em uma cláusula de guarda.

[06:00] Já quando nós vamos criar nossa própria função, é convenção utilizar essa nomeação aqui porque não vamos poder utilizar nossa própria função em uma cláusula de guarda. Essa é a diferença na convenção de terminar com ponto de interrogação ou começar com "is_". Claro, eu posso criar uma função minha que começa com "is_" e não pode ser utilizada em uma cláusula de guarda, mas é interessante seguirmos a convenção para que não causemos estranheza para alguma pessoa que for desenvolvedora de Elixir bate o olho no nosso código e pensa: "ué, isso estar começando com "is", mas eu não posso utilizar em uma cláusula de guarda?".

[06:37] Esse tipo de coisa ajuda a tornar nosso código um pouco mais claro. Existem alguns nomes especiais que são interessantes sabermos. Quando precisamos pegar o tamanho de algo, de uma lista, por exemplo, se eu vejo a palavra size quer dizer que essa operação é constante, ela não precisa percorrer todos os itens daquela lista, por exemplo. Ela tem, em algum lugar, o tamanho armazenado.

[07:01] Se temos, por exemplo, o tamanho de um mapa, o "map.size" ou "tuple.size", isso vai ser uma operação constante, não precisamos percorrer o nosso mapa ou nossa tupla. Já quando falamos de uma string e pegamos o ".length", vamos precisar percorrer cada um desses caracteres para ir contando. Isso é uma operação não constante, é uma operação que acontece em um modo linear. Cada item dessa minha coleção de algum tipo de dado vai executar em uma operação a mais.

[07:30] Isso é interessante também para termos a consciência de como o nosso código afeta a performance do que estamos escrevendo. Já falei bastante sobre as convenções que estão aqui. Como eu disse, eu vou deixar esse link para vocês darem uma lida com calma em cada um dos detalhes, mas basicamente esses são os detalhes de convenção sobre nome.

[07:50] Agora, eu quero mais uma vez voltar em um assunto que já convençamos no treinamento anterior, só que com um pouco mais de prática e um pouco mais de detalhes, que é sobre recursão. Só que isso vamos falar no próximo capítulo.

@@07
Para saber mais: Documentação

A documentação sobre as convenções de nome em Elixir pode ser conferida na íntegra aqui:
Naming Conventions

https://hexdocs.pm/elixir/master/naming-conventions.html

@@08
Faça como eu fiz

Chegou a hora de você seguir todos os passos realizados por mim durante esta aula. Caso já tenha feito, excelente. Se ainda não, é importante que você execute o que foi visto nos vídeos para poder continuar com a próxima aula.

Continue com os seus estudos, e se houver dúvidas, não hesite em recorrer ao nosso fórum!

@@09
O que aprendemos?

Nesta aula, aprendemos:
Conhecemos as cláusulas de guarda
Aprendemos a usar valores padrão em funções
Vimos como definir cabeçalhos de funções
Conhecemos convenções de nomenclatura de funções do Elixir