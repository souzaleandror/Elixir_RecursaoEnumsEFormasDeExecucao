#### 06/09/2023

Curso de Elixir: Recursão, Enums e formas de execução

```
iex(1)> lista = [1, 2, 3]
[1, 2, 3]
iex(2)> Enum.map(lista, fn(x) -> x * 2 end)
[2, 4, 6]
iex(3)> Enum.map(lista, &(&1 *2))          
[2, 4, 6]
iex(4)> Enum.sum(lista)
6
iex(5)> require Integer
Integer
iex(6)> Enum.filter(lista, &(Integer.is_even(&1)))
[2]
iex(7)> 
```

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

####

02-Tail recursion

@@01
Projeto da aula anterior

Caso queira, você pode baixar aqui o projeto do curso no ponto em que paramos na aula anterior.

https://github.com/alura-cursos/2310-elixir/archive/refs/tags/curso-2-aula-1.zip

@@02
Desafio tabuada

[00:00] Pessoal, bem-vindo de volta a mais um capítulo desse treinamento onde nós estamos continuando nossos aprendizados com o Elixir depois de já ter visto um pouco da sintaxe básica e os principais detalhes.
[00:11] Agora nós vamos falar de um tema que foi abordado no treinamento anterior, mas eu quero praticar um pouco e entrar em alguns detalhes. Nós falamos sobre recursão e eu deixei um desafio para implementarmos a tabuada, só que ao invés de exibir cada um dos itens da tabuada, cada um dos números das multiplicações, eu quero retornar uma lista.

[00:30] Vamos tentar fazer isso, vamos implementar. Eu vou criar aqui um arquivo chamado "tabuada.exs", vou definir o módulo, defmodule MeuModulo.Tabuada do, e eu vou ter uma função pública que calcula a tabuada de algum número, de algum multiplicador, def calcula(multiplicador) do.

[00:50] O que eu vou fazer com isso? Essa minha função calcula, precisa chamar a função que realiza realmente o cálculo da tabuada, porque eu não vou adicionar tudo aqui, certo? Essa função é somente o ponto de entrada para o meu módulo. O que eu posso criar? Eu vou criar uma função privada chamada tabuada, que recebe o produto um e o produto dois, ou seja, ela vai multiplicar um pelo outro, só isso. def tabuada(produto1, produto2).

[01:14] Só que se eu retornar o produto1, multiplicado pelo produto2, eu não estou fazendo nada, então vamos lá com calma. Eu vou chamar a minha tabuada, com multiplicador sendo multiplicado, a princípio, por 1. Só que o que eu vou querer fazer? Essa minha tabuada, essa função tabuada vai se chamar de novo, só que com o produto2 sendo ele mais 1, ou seja, primeiro eu recebi a tabuada com o valor 1, então depois eu vou chamar a tabuada de novo, ela vai se chamar só que com o valor 2. Vamos adicionando as coisas.

[01:48] Como que eu posso fazer? Eu vou transformar isso aqui em uma lista e eu vou adicionar a essa lista, então no final da lista eu vou chamar o resultado de tabuada passando o produto1 e o produto2 mais 1. defp tabuada(produto1, produto2) do [produto1 * produto2] ++ tabuada(produto1, produto2). Vamos recapitular o que vai acontecer aqui. Eu estou chamando a tabuada, a função tabuada, passando o multiplicador e 1, então o produto1 vai ser o multiplicador e produto2 vai ser 2.

[02:13] Imagine que eu chamei a função calcula passando o 5, então vai chamar tabuada com o primeiro parâmetro 5 e o segundo parâmetro 1. Ele vai fazer 5 vezes 1, vai criar essa lista, e no final da lista ele vai adicionar o que essa tabuada retornar. Ela vai chamar de novo, só que primeiro parâmetro vai ser 5 e o segundo parâmetro 2, então ele vai criar essa outra lista e vai retornar juntando com essa daqui.

[02:41] Só que no final isso vai ficar infinitamente acontecendo, eu nunca vou sair dessa minha execução. Eu preciso criar o nosso ponto de saída. Eu vou criar aqui a nossa função tabuada que recebe alguma coisa, o nosso produto1, só que eu não vou utilizar esse valor, já te mostro o porquê, e o produto2, 11. defp tabuada(produto1, 11).

[02:59] O que isso quer dizer? Quando chamamos a própria função aqui, várias vezes, até chegar no número 11, nós vamos interromper a execução, ou seja, eu não vou mais continuar a recursão e vou retornar direto com uma lista vazia. O que eu estou fazendo? Estou chamando aqui a tabuada, eu chamo com 1, mais 1, até que o produto2 é 10, então vou fazer aquele meu 5 vezes 10 e adicionar no final dessa lista o resultado da chamada da função tabuada.

[03:29] Só que aqui o 10 mais 1 vai ser 11, então nós vamos cair nessa função que simplesmente retorna uma lista vazia. Isso vai começar a sair da nossa recursão e no final nós vamos poder finalmente unir a lista no final. Dessa forma, eu tenho aqui a tabuada implementada, utilizando recursão e eu vou ter uma lista no final, se eu não escrevi nada errado, claro.

[03:51] Vamos lá, abri o meu terminal interativo com essa tabuada e vamos lá. "Produto1 não é utilizado", aquele detalhe que provavelmente você viu antes de mim. Deixa eu fechar isso daqui. Como eu não estou utilizando isso, underscore, para o compilador não reclamar. Vamos de novo, agora sem aviso, posso executar MeuMódulo.Tabuada.calcula(5).

defmodule MeuModulo.Tabuada do
    def calcula(multiplicador) do
        tabuada(multiplicador, 1)
    end

    defp tabuadall | 11h), do: []

    defp tabuada(produtol, produto2) do
    [produtol * produto2] ++ tabuada(produtol, produto2 + 1)
    end
endCOPIAR CÓDIGO
[04:16] Tem lá a minha lista com os multiplicadores, com a tabuada de 5. 5, 10, 15, 20. Se eu passar aqui um 3 vai funcionar, se eu passar 9 vai funcionar perfeitamente. Dois detalhes: primeiro, uma coisa que eu não vou implementar, mas fica de desafio, de adicionar uma cláusula de guarda, para só fazer essas funções funcionarem com números inteiros acima de 0.

[04:39] Se eu passar aqui um -3, por exemplo, nós até vamos ter a multiplicação, só que isso não faz sentido quando falamos de tabuada. Isso precisa ser um número inteiro acima de 0, até porque se eu passar um string aqui, eu nem sei o que acontece, eu nem testei isso. Nós vamos ter erro, perfeito, menos mal. Fica a dica do desafio de adicionar uma cláusula de guarda.

[05:01] Agora, um outro detalhe que eu tinha comentado no treinamento anterior era sobre algo conhecido como Tail Recursion, que é quando a última operação de uma recursão é a própria recursão, ou seja, é a chamada para a função em si. Já aqui no nosso caso, não é isso que está acontecendo, nós estamos avaliando essa expressão.

[05:21] Para avaliar essa expressão, o que acontece? Nós criamos essa lista, depois criamos essa lista e, no final, adicionamos essas duas. A última operação que está acontecendo aqui é isso, é a concatenação de duas listas. Nesse caso, eu não tenho Tail Recursion.

[05:40] No próximo vídeo, eu volto para praticarmos como utilizar Tail Recursion, principalmente em um cenário como esse, onde estou acumulando valores, o que eu estou fazendo aqui é acumular essa lista, certo? Estou fazendo várias execuções para no final retornar um valor só, que é uma única lista. Vamos entender como que nós podemos implementar isso utilizando Tail Recursion no próximo vídeo.

@@03
Body recursion

Nesse vídeo nós implementamos o desafio deixado no treinamento anterior de gerar uma lista com os valores da tabuada do número passado por parâmetro. Nós utilizamos uma técnica chamada body recursion.
Qual o problema de se usar body recursion ao invés de tail recursion?

A erlang vai precisar otimizar essa chamada para não ter uma stack se acumulando.
 
Alternativa errada! Infelizmente essa otimização não vai ser possível.
Alternativa correta
A erlang não vai conseguir otimizar essa chamada e vamos ter uma stack se acumulando.
 
Alternativa correta! Usando body recursion, temos a recursão que já conhecemos em linguagens imperativas. Assim, cada nova chamada da função adiciona um stack frame em nossa stack. Isso pode gerar um stack overflow caso tenhamos um nível alto de recursão.
Alternativa correta
Não há problemas em utilizar body recursion nesse caso.

@@04
Usando tail recursion

[00:00] Pessoal, bem-vindos de volta. Vamos modificar essa implementação aqui para utilizar tail recursion. Quando nós não usamos tail recursion, o nome da técnica que é conhecido, como que nós fizemos aqui, é body recursion. Vamos falar mais sobre isso. Eu vou criar aqui um novo arquivo chamado "tabuada-tail.exs".
[00:24] Eu vou chamar também de MeuModulo.Tabuada. Vou ter a mesma função calcula por um multiplicador e aqui eu vou chamar de novo a tabuada passando esse multiplicador e passando o número 1 para inicializar a recursão. defmodulo MeuModulo.Tabuada do def calcula(multiplicador) do tabuada(multiplicador, 1). "Vinicius, mas eu não poderia ter, por exemplo, adicionado esse 1 como o valor padrão e não ter esse método aqui calcula?" Posso.

[00:56] Poderia, por exemplo, aqui já ter o valor do produto1 o valor padrão como 1, transformar isso aqui em público e isso aqui que vai ser executado direto. Posso fazer isso sem problema nenhum. Só preferi ter essa função separada para me organizar melhor, mas isso não faz diferença. Vou manter dessa forma. Vamos lá. Vou ter aqui a minha tabuada que recebe o produto1 e o produto2 e aqui nós vamos fazer algo parecido. defp tabuada(produto1, produto2).

[01:23] Só que no final, eu sei que eu preciso chamar essa função, produto1 e produto2 mais 1. defp tabuada(produto1, produto2) do tabuada(produto1, produto2 + 1). Isso precisa ser minha última chamada. Já vou até criar aqui a definição de tabuada que ignora o primeiro parâmetro, recebe 11 como segundo e retorna uma lista vazia. Deixa eu simplificar isso aqui, adicionando tudo na mesma linha. Até aqui nada muito novo. Só que aí que vai entrar o detalhe: quando eu vou utilizar tail recursion para acumular algo, eu preciso de alguma forma ter esse valor sendo acumulado.

[01:57] Vou precisar passar isso por parâmetro. Além de passar o multiplicador e o valor inicial da minha multiplicação, que é 1, que vai ser incrementada até chegar no 10, eu também vou passar os valores iniciais, que no caso é uma lista vazia, é nada. Quando eu chegar no final, eu vou pegar esses valores e retorná-los, ou seja, não vou adicionar mais nada porque eu já vou ter acumulado todos os valores.

[02:21] Aqui eu vou receber esses valores e se eu receber esses valores eu preciso utilizá-los de alguma forma, então eu posso fazer aquilo, produto1 vezes o produto2, porque ainda não tinha feito essa multiplicação, e aqui eu vou unir com o quê? Com os meus valores. tabuada(produto1, produto2 + 1, [produto1 * produto2] ++ valores. Se eu não tenho nada, que é o caso aqui, no caso inicial, ele vai unir a multiplicação que eu tenho com nada, então vai começar com minha multiplicação.

[02:48] Só que ele vai para a próxima interação antes disso. Esse valor da primeira interação vai ser adicionado no início de toda a lista. Isso é tail recursion. No caso, eu poderia ter várias operações aqui, poderia ter novos valores e separar isso em uma variável. Eu posso ter quantas operações eu quiser e utilizar aqui os novos valores, desde que a última coisa que eu faça é a recursão, é a chamada para a própria função.

[03:17] Deixa eu voltar para não utilizar essa variável temporária, não preciso dela. O que eu tenho aqui é a última coisa que essa função faz é se chamar, é se executar, é chamar a si própria, e esse é o conceito de tail recursion. Se eu vier aqui e chamar o meu tabuada-tail, eu espero ter o mesmo resultado, então MeuModulo.Tabuada.calcula(5), eu vou ter a mesma lista, só que agora eu tenho ela ao contrário

[03:46] Aqui entra um detalhe bastante interessante: o que acontece? Muitas vezes, quando eu trabalho com listas e tail recursion, eu vou entrar nesse cenário aqui. Eu posso tentar modificar a implementação, por exemplo, posso adicionar os valores e depois adicionar a multiplicação, vamos ver se isso aqui funciona.

[04:04] Primeiro os valores e depois a multiplicação, e vamos recompilar o MeuModulo.Tabuada e quando eu faço o cálculo funciona. Só que existem alguns casos, e eu vou deixar um Pra Saber Mais aqui com um exemplo, onde eu precisaria ter uma outra função para reverter essa minha lista. Isso seria um problema, eu acabaria perdendo performance dessa forma. Em alguns cenários utilizar a tail recursion pode trazer algumas dificuldades a mais para nós.

[04:30] Só que talvez você não se lembra o motivo de nós utilizarmos tail recursion, porque, cá entre nós, aquela nossa primeira implementação é um pouco mais legível para mim. Vamos dar uma olhada aqui. Eu entendo melhor isso daqui do que eu entendo isso daqui, precisar acumular valores, obviamente eu podia adicionar os valores padrão aqui para facilitar um pouco a chamada.

[04:51] Ainda assim esse tipo de leitura não é tão natural para mim. Para pessoas que estão mais habituados com linguagens funcionais isso é mais natural sim, isso é mais legível, mas como eu sou uma pessoa que trabalha mais com linguagens hiperativas, utilizando a orientação objeto, etc., isso aqui não é tão natural para mim. Só que para nós escrevermos isso precisa ter uma vantagem. No próximo vídeo, eu volto recapitulando a vantagem que nós temos a utilizar tail recursion.

@@05
Tail call optimization

[00:00] Pessoal, bem-vindos de volta. Vamos entender rápido o motivo de utilizarmos tail recursion, sendo que em alguns casos pode até dificultar a leitura. O que acontece? Algumas linguagens, como é o caso da máquina virtual de Erlang, então por consequência a linguagem Elixir, possuem algo que é chamado de tail call optimization ou otimização de chamada de calda, a tradução não é tão interessante assim.
[00:25] Mas o que isso quer dizer? Sempre que eu executo uma função. Deixa eu tentar desenhar aqui. Imagina que eu tenho a função principal, vamos chamar de main, essa função chama uma outra, uma funcao1, e essa funcao1 chama a funcao2. O que acontece na computação é que essas chamadas vão criando um bloco de memória, que é conhecido como stack frame, um bloco na minha stack e isso tudo aqui é a nossa pilha de execução, é a nossa stake.

[00:55] Sempre que eu tenho uma função nova sendo chamada dentro de uma execução, eu tenho um novo bloco sendo separado e adicionado aqui nessa nossa stake. A stake tem o tamanho limitado, tanto é que se eu tiver muitas chamadas de função, isso acontece quando eu tenho recursão infinita, temos aquele famoso erro de stack overflow, ou seja, a sobrecarga da nossa *stake, da nossa pilha de execução.

[01:18] Para evitar esse cenário em linguagens que precisam muito de recursão, como é o caso de Elixir, existe o conceito de tail call optimization. O que acontece? Quando eu tenho uma recursão, como é o caso aqui da nossa tabuada, de cauda, uma tail recursion, o que o Elixir consegue fazer?

[01:37] No caso da máquina virtual, o Erlang. Ele analisa essa execução, essa função e ver a última coisa que essa função faz é chamar ela mesma, então ele consegue por baixo dos panos substituir essa chamada de função pelo bloco dela com o valor já alterado. O que ele vai fazer? Imagina que aqui o produto2 está sendo o número 3, ao invés de chamar a função de novo, ele vai avaliar todos esses detalhes, vai pegar esse valor aqui, 4, e adicionar esse bloco de código aqui embaixo.

[02:11] O que ele vai fazer? Ele vai transformar a nossa recursão em algo muito parecido com o for, com um loop qualquer, e dessa forma nós vamos na nossa callstack somente uma chamada e no final, claro, nós vamos ter duas chamadas, porque nós temos essa outra definição aqui que não pode ser simplesmente inserida. No nosso caso vai ser uma chamada bem simples.

[02:34] A nossa stake ao invés de ser isso aqui, várias chamadas para a função tabuada, vai ser somente isso daqui, ou seja, isso vai ser bastante rápido, vai ser bastante performático e vai ter a legibilidade de uma linguagem funcional sem utilizar instruções imperativas, como um loop. Dessa forma, nós mantemos a performance de uma linguagem imperativa com a declaratividade de uma linguagem funcional, de uma linguagem declarativa.

[03:00] Essa é a ideia por trás da tail call optimization. Só que existe um mito de que isso é sempre melhor, de que a tail recursion sempre é o melhor caso, e, na verdade, isso não é. Eu vou deixar um link com um Para Saber Mais dando alguns exemplos, inclusive mostrando benchmark, de quando a body recursion, ou seja, esse cenário que nós fizemos, pode ser melhor. Quando nós estamos acumulando algum valor, a tail recursion vai ser mais interessante.

[03:29] Só que se eu não preciso acumular nada e todo o meu processamento acontece realmente no meio da operação, então posso utilizar body recursion sem problema nenhum. De novo, eu vou deixar um Para Saber Mais com esse link explicando os detalhes e mostrando um benchmark, dessa forma você pode replicar o exemplo, testar na sua máquina para você entender melhor, mas a ideia é essa.

[03:49] Se você precisa acumular valores, você pode e deve utilizar tail recursion. Só que em alguns cenários, principalmente com coisas pequenas, se eu não preciso acumular valores, utilizar a body recursion pode até trazer uma performance melhor, além de em alguns casos tornar a legibilidade um pouco mais fácil também. Essa é a ideia por trás da tail recursion. Entenda: se você for trabalhar com alguma linguagem funcional é importante conhecer esse tipo de técnica para que nosso código seja o mais otimizado possível.

[04:20] Tendo entendido isso, tendo falado bastante sobre funções, tail recursion e recursão, vamos voltar a falar sobre tipos de dados, só que agora nós não vamos falar sobre nenhum tipo novo e sim sobre como manipular esses tipos que nós já conhecemos. Nós vamos falar um pouco de valores enumeráveis e como manipulá-los, só que isso tudo no próximo capítulo.

@@06
Para saber mais: Detalhes

Vimos neste vídeo que ao acumular valores, tail recursion vai ser uma alternativa mais interessante, mas caso contrário, body recursion pode ser mais performático.
Para entender melhor com detalhes esse tipo de problema, você pode conferir este artigo bastante interessante:

Iteration, Recursion, and Tail-call Optimization in Elixir

https://blog.appsignal.com/2019/03/19/elixir-alchemy-recursion.html

@@07
Faça como eu fiz

Chegou a hora de você seguir todos os passos realizados por mim durante esta aula. Caso já tenha feito, excelente. Se ainda não, é importante que você execute o que foi visto nos vídeos para poder continuar com a próxima aula.

Continue com os seus estudos, e se houver dúvidas, não hesite em recorrer ao nosso fórum!

@@08
O que aprendemos?

Nesta aula, aprendemos:
Implementamos o desafio da tabuada do treinamento anterior
Mudamos a implementação de body recursion para tail recursion
Entendemos o conceito de tail-call optimization

#### 07/09/2023

@03-Valores enumeráveis

@@01
Projeto da aula anterior

Caso queira, você pode baixar aqui o projeto do curso no ponto em que paramos na aula anterior.

https://github.com/alura-cursos/2310-elixir/archive/refs/tags/curso-2-aula-2.zip

@@02
Módulo Enum

[00:00] Bem-vindos de volta a mais um capítulo desse treinamento onde estamos conhecendo um pouco mais sobre Elixir e agora já trabalhamos muitas coisas interessantes, vamos conhecer o que o Elixir chama de tipos enumeráveis.
[00:14] Um tipo enumerável é uma espécie de conjunto de dados onde eu posso percorrer e aplicar alguma operação em cada um deles ou até reduzir esse conjunto de dados a um valor só.

[00:27] Alguns tipos enumeráveis que já conhecemos são as listas e os mapas. Conseguimos pegar todos os valores de uma lista e aplicar alguma operação em cima deles, por exemplo.

[00:37] Vamos fazer exatamente isso. Vou abrir o meu terminal interativo e criar uma lista, essa lista vai ter 1, 2 e 3. iex(2)> lista = (1, 2, 3). Eu posso fazer operações em cada um desses números, por exemplo, imagina que eu queira percorrer essa lista e para cada um desses números eu quero multiplicar por dois.

[00:55] Eu posso utilizar o módulo Enum que fornece várias funções para trabalharmos com enumeráveis. Aqui em Enum eu tenho uma função map que espera algum enumerável e uma função. Essa função recebe por parâmetro um elemento que vai ser cada um deles, ele vai percorrer essa lista e vai passar por parâmetro para essa função.

[01:18] Primeiro número 1, depois número 2 e assim em diante. E o que eu retornar aqui vai ser um novo item dessa nova lista que vai ser criada. Por exemplo: eu posso multiplicar isso por dois e com isso eu tenho uma nova lista com dois 2, 4, 6. iex(3)> Enum.map(lista, fn (x) -> x+ 2 end) [2, 4. 6]. Ou seja, cada um dos itens multiplicados por 2.

[01:35] Claro que eu posso utilizar aquela sintaxe de captura de funções que aqui vamos ter o nosso primeiro parâmetro multiplicado por dois e isso continua funcionando. iex($)> Enum.map(lista, &(&1 * 2) [2, 4, 6]

[01:46] Eu posso também, como eu disse, realizar operações que pegam um conjunto de dados e reduzem a um único valor. Eu posso fazer um Enum.reduce só que essa é uma função que vai demorar um pouquinho mais para explicar, para dar um exemplo mais simples é uma função sum de soma.

[02:02] Se eu passar uma lista aqui eu simplesmente vou ter a soma de todos esses itens retornados. 1 + 2 = 3, 3 + 3 = 6, ele vai somar tudo o que estiver lá para nós. iex(5)> Enum.sum(lista).

[02:14] Aquela função reduce pegaria cada um dos valores e iria acumulando, levaríamos um tempo a mais para implementá-la, para explicar para quem ainda não conhece. Como um pré requisito desses treinamentos de Elixir é você já conhece alguma outra linguagem de programação, recomendo demais que você pesquise sobre map, filter e reduce na sua linguagem.

[02:36] Eu já falei de map, já falei de reduce e o filter como funciona? Eu posso pegar essa lista e ter somente os números que são pares, por exemplo, vou filtro nessa lista e vou retornar somente os valores que forem pares. iex(6)> Enum.filter(Lista, &(Integer.is_even(&)))

[03:00] Não é essa definição eu preciso fazer o require Interger, vamos lá. iex(6)> require Interger; Fiz o require e agora quando eu executo eu tenho somente o meu número dois.

[03:09] "Vinicius, por que você precisou do require?" Porque o nosso is even é uma macro, já falamos sobre isso no capítulo de módulo do treinamento anterior. Em alguns casos eu preciso fazer, preciso de forma explícita requerer o módulo que estou utilizando.

[03:24] Essa é a ideia por trás dos enumeráveis, é um conjunto de dados que eu posso percorrer e aplicar operações. Se dermos uma olhada na documentação eu tenho muitas funções que eu posso aplicar, tanto em listas quanto em mapas

[03:38] Por exemplo, aqui estou fazendo mapeamento de um mapa em si, ele trabalha tanto com a chave quanto com o valor, podemos fazer isso também.

[03:46] Vamos dar uma olhada bem rápida só em quantas funções temos, são muitas funções. Eu consigo verificar se todos os elementos são alguma coisa, são, por exemplo, conseguem ser lidados como verdadeiro, não são falso e nem nulo.

[04:04] Eu consigo fazer alguma verificação em todos esses elementos através do all, consigo verificar se algum desses elementos bate com alguma verificação, consigo pegar um elemento na posição tal, consigo pegar pedaços desses enumeráveis, consigo unir enumeráveis, contar. Consigo fazer muita coisa.

[04:22] Repare que existem várias funções nesse nosso módulo de Enum, vale a pena dar uma olhada na documentação com calma e entender tudo o que isso aqui faz.

[04:30] Agora eu vou voltar lá para o início para vermos que existem alguns dados, podemos ter vários tipos que sejam enumeráveis. Só que por padrão já temos três que são os mais comuns: listas, mapas e intervalos.

[04:48] No próximo vídeo vamos ver bem rápido o que são esses tal de intervalos, como eu crio um intervalo e vamos praticar o uso de intervalos junto com as funções de Enum.

@@03
Enumeráveis

Vimos neste vídeo algumas funções do módulo Enum.
O que Elixir chama de valores enumeráveis (Enumerables)?

Conjuntos de dados que podem ser percorridos e manipulados em conjunto.
 
Alternativa correta! Mapas e listas são exemplos de enumeráveis. Embora tuplas também pareçam ser, são estruturas de tamanho fixo e acesso direto, então as funções do módulo Enum não funcionam em tuplas.
Alternativa correta
Apenas mapas e listas.
 
Alternativa correta
Qualquer tipo de dados que possamos contar o número de elementos dentro dele.

@@04
Ranges

[00:00] Bem-vindos de volta. Vamos entender o que é um Range ou intervalo. É bem simples na verdade, é um conjunto, é um intervalo propriamente dito de inteiros. Eu preciso ter um início, um fim e um passo, ou seja, o valor que vai ser incrementado ou decrementado.
[00:19] Eu sei que falando assim pode ficar confuso, mas vamos lá. Imagine que eu queira pegar o intervalo de 1 até 10, eu posso fazer através da anotação: iex(2)> 1..10, isso aqui vai me dar o intervalo do número 1 até o número 10. Inclusive, ou seja, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10. Não vai ser de 2 a 9, por exemplo, de 1 a 9, de 2 a 10, vai ser inclusive, com os dois itens.

[00:45] Se eu quiser pegar a lista que esse intervalo gera para nós posso chamar o: Enum.to.list(1..10) e esse intervalo, isso vai nos retornar a lista. Eu consigo ter intervalos também com passos personalizados, vamos dizer assim, eu posso utilizar anotação barra barra, por exemplo, 2, para ir pulando de 2 em 2. iex(4)> Enum.to_list(1..10//2). Eu tenho lá de 1 a 10 só que pulando de 2 em 2 e isso acaba tirando o 10. [1, 3, 5, 7, 9]

[01:12] Dessa forma eu consigo criar intervalos, transformá-los em listas, consigo mapear intervalos e etc. Inclusive, isso deixa aqui uma forma mais simples de implementarmos a tabuada sem precisar nós mesmos criar aquela recursão, saber sobre tail recursion e etc.

[01:32] Vamos tentar criar aqui uma tabuada. Eu vou fazer o mapeamento de 1 até 10 porque eu vou fazer a tabuada de 1 a 10, executando essa função aqui, eu vou multiplicar esse meu parâmetro pelo multiplicador que eu quero. Por exemplo, se eu quero a tabuada de 5 eu vou fazer isso aqui multiplicado por 5. iex(5)> Enum.map(1..10, &(&1 * 5)) e tenho lá a tabuada de 5. [5, 10, 15, 20, 25, 30, 35, 40, 45, 50].

[01:54] Se eu quero a tabuada de 3, tenho aqui a tabuada de 3. iex(6)> Enum.map(1..10, &(&1 * 3)) [3, 6, 9, 12, 15, 18, 21, 24, 27, 30]. Repare que conhecendo um pouquinho a biblioteca do próprio Elixir, eu deixo de precisar escrever algumas coisas, mas como estava escrito lá naquele artigo que eu deixei no Para Saber Mais no final do módulo de recursão, em alguns cenários é preferível que escrevemos as nossas próprias funções do que utilizar o que temos no Enum para ganharmos um pouco de performance.

[02:18] Não é esse o caso aqui da tabuada, aqui temos realmente um intervalo sendo criado e desse intervalo estamos mapeando uma vez só, é uma operação bastante performática, não precisaríamos da nossa própria recursão.

[02:30] Eu consigo realizar várias operações que eu realizaria em cima de um mapa ou em cima de uma lista em intervalos. Sendo assim, eu posso criar um intervalo gigante sem precisar ter esses valores. De 1 até esse número aqui que eu nem sei qual é, eu consigo criar esse intervalo e se eu tenho que pegar a lista disso eu vou ter esse valor enorme.

[02:52] Repara que aqui o nosso terminal interativo nem mostra tudo porque íamos ocupar muito espaço. Isso é muito interessante para sabermos como gerar valores sem precisar ter todos esses valores à mão.

[03:04] Uma coisa que não tem a ver com o enumeráveis, só que como estou olhando esse número aqui eu acho válido citar, tem um sintaxe interessante para representarmos números que eu posso utilizar underline em qualquer lugar de um número, assim eu consigo saber, eu consigo visualmente saber melhor que número é esse.

[03:20] Só com aquele monte de zeros eu nem sabia que número era, agora eu sei que isso é 1 milhão. Eu tenho aqui a casa de centenas, a casa de milhares e a casa de 1 milhão. Isso é só um detalhe de sintaxe sobre inteiros.

[03:32] Imagine um cenário onde eu precise aplicar várias operações em cima de um enumerável, de uma lista, de um mapa ou de um intervalo. Se eu tiver várias operações acontecendo eu vou precisar chamar uma função, dentro dessa chamar outra e etc. Isso torna a legibilidade um pouco ruim.

[03:49] Vamos conhecer um novo operador para lidar principalmente com enumeráveis, mas que na verdade pode ser utilizado em qualquer caso. Só que isso vamos ver no próximo vídeo.

@@05
Pipe operator

[00:00] Bem-vindos de volta. Como eu comentei, existem cenários onde eu vou precisar aplicar várias funções, várias transformações talvez para no final pegar um resultado. Vamos ver um exemplo desse cenário para depois vermos como podemos melhorar o código.
[00:15] Imagine que eu queira pegar na nossa tabuada, vou mapear de 1 a 10 com essa função e multiplica por 5, por exemplo, peguei a tabuada de 5. iex(22)> Enum.map(1..10, &(&1 * 5)) [5, 10, 15, 20, 25, 30, 35, 40, 45, 50]

[00:24] Eu quero pegar essa tabuada, filtrar para pegar somente os números pares e somar esse resultado filtrado. Vamos lá, eu vou pegar essa tabuada, eu vou precisar filtrar isso, Enum.filter, esse resultado aqui Enum.map(1..10, &(&1 * 5) eu vou filtrar para garantir que é par, &Integer.is_even(&1).

[00:47] Terminei, eu acho que está no lugar certo e vamos ver se o resultado é o esperado por enquanto, só peguei os números pares. Agora eu quero eu quero fazer a soma disso aqui tudo, já vou adicionar parênteses aqui, lá no início eu vou adicionar o Enum.sum e ok, tenho o meu resultado. iex(24)> Enum.sum(Enum.filter(Enum.map(1..10, &(&1 * 5)), &Integer.is_even(&1))) 150

[01:04] Repare que consigo atingir o resultado esperado, mas eu tenho três chamadas de funções encadeadas aqui, eu não sei onde começa, é difícil de ler. Vamos tentar escrever isso de uma forma um pouco mais natural.

[01:18] O início de tudo é esse valor aqui, esse valor inicia toda a minha execução. Eu quero pegar esse valor e passá-lo para a função Enum.map que vai mapear usando essa função. Depois desse resultado aqui eu quero passar para a minha função Enum.filter que vai utilizar essa outra função aqui para filtrar os números pares.

[01:39] Esse resultado todo eu quero passar para a minha função de Enum.sum. Para fazer isso vamos pegar de dentro para fora e ir escrevendo, eu vou pegar o meu intervalo e esse intervalo eu vou passar para a próxima função aqui, eu vou passá-lo como primeiro parâmetro da próxima função, vou utilizar esse operador aqui o, o pipe e o sinal de maior. iex(25)> 1...10 |>

[02:05] Agora eu posso passar esse valor para o Enum.map, o primeiro parâmetro vai ser o que temos antes desse operador, eu posso passar aqui o nosso segundo parâmetro que é a função. Enum.map(&(&1 * 5) e o resultado desse mapeamento eu quero também passar por parâmetro para a próxima função que vai ser o filtro.

[02:27] Dessa nossa tabuada eu vou filtrar somente o que é um número par, ...(25)> Enum.filter(&Integer.is_even(&1). Vamos recapitular o que fizemos até aqui, peguei esse intervalo, eu passo esse intervalo como primeiro parâmetro da próxima função depois desse operador, a função depois operador é o Enum.map e repare que ela já tem um parâmetro aqui, o valor antes desse operador vai ser passado aqui, antes desse outro valor que estou passando.

[02:56] A mesma coisa para a próxima função, ou seja, o resultado desse map vai ser passado como primeiro parâmetro de filter e o resultado desse filter vai ser passado como primeiro parâmetro da minha função sum. Como eu não preciso de um segundo ou terceiro parâmetro eu não preciso informar mais nada, quando eu executo eu tenho o mesmo resultado.

[03:16] Só que a leitura é um pouco melhor, eu pego o meu intervalo, mapeio ele multiplicando tudo por 5, filtro somente os números pares e somo tudo. Isso é lido de uma forma mais natural.

[03:28] Aqui utilizamos o mesmo conceito que os comandos UNIX utilizam, o conceito de pipe onde o resultado de um comando pode ser passado para a entrada de outro comando. É exatamente esse o nome desse operador aqui, é o operador de pipe ou pipe operator.

[03:45] Pegamos algum valor e passa como primeiro parâmetro da próxima função e eu posso ir encadeando essas chamadas de pipe operators. Aqui quando eu utilizo o pipe operator, de novo, sem o valor antes do operador vai ser passado como primeiro parâmetro da função depois do operador.

[04:06] Temos alguns detalhes com os quais preocupar-se. Primeiro: eu não preciso na hora de chamar funções em Elixir utilizar parênteses, será que aqui os parênteses também são opcionais? E se eu precisar passar esse valor que estou recebendo de antes do operador, como segundo ou terceiro parâmetro de uma função?

[04:24] Ao invés de ficarmos brincando um pouco mais aqui, vamos dar uma olhada na documentação para aprendermos também a consultar a documentação, além do guia que já estávamos olhando.

[04:34] Vou abrir aqui a documentação e eu já abri no pipe operator na sessão de Pitfalls, ou seja, detalhes para nos atentarmos. Tem dois detalhes que temos que prestar atenção, um é a precedência dos operadores. Se eu tentar executar isso daqui, esperamos que eu vá chamar a função graphemes que conta o número de grafemas de uma string. Vou executá-la para vocês verem o que vai acontecer aqui.

[05:01] Ele vai pegar os grafemas, ou seja, vai transformar isso em uma lista com os grafemas. Eu quero pegar essa lista e reverter, eu quero fazer o reverse disso. Só que quando eu escrever dessa forma isso vai ser interpretado assim, vou acabar passando esse string para a função reverse de Enum. Só que uma string não é um Enum, por isso vamos ter um erro.

[05:21] Repare que se eu executar isso daqui temos um erro. É interessante, é importante e é recomendado que sempre utilizemos os parênteses. No nosso caso seria algo assim: iex(27)> String.graphemes("Hello") |> Enum.reverse() Agora sim, eu reverti esse meu dado.

[05:41] Como a documentação diz, é mais interessante ainda já começar pelo dado e depois passarmos para as funções que precisamos. iex(28)> "Hello" |> String.graphemes() |> Enum.reverse(). Assim temos uma leitura ainda mais natural.

[06:03] A partir da string Hello chama essa função que me retorna os grafemas e desses grafemas reverte. É isso que a documentação sugere. Além de sempre utilizar os parênteses, comece pelo dado que você quer manipular.

[06:18] Um segundo detalhe é: se eu precisar utilizar uma função anônima e passar por parâmetro, não no primeiro parâmetro passar o valor que estou fazendo o pipe não pelo primeiro parâmetro, mas sim para algum próximo parâmetro. Eu posso criar uma função anônima, utilizando aquela sintaxe de capture function, ou seja, se capturar a função, eu posso criar uma nova função que chama essa função já existente passando para o segundo parâmetro o primeiro parâmetro que ela recebe.

[06:49] Isso daqui, vou lá no nosso terminal de novo, isso daqui é a mesma coisa que fazer isso daqui: iex(32)> sume_fun = fun (x) -> Regex.replace(~r/l/, "L") end. São exatamente a mesma coisa.

[07:18] Repare que eu estou criando uma nova função que recebe somente um parâmetro e esse parâmetro ela passa como segundo parâmetro da função que queremos utilizar.

[07:28] Para facilitar um pouco a escrita, principalmente em pipe operator, temos a função then. Essa função recebe o valor que você quer ter a função sendo executada como primeiro parâmetro e a função que você efetivamente quer utilizar esse parâmetro.

[07:44] Basicamente a função then vai pegar essa some_fun e vai entregar-te a chamada de uma função passando algum parâmetro aqui.

[07:58] Utilizando o then, antes eu preciso importá-lo. O primeiro parâmetro é o valor que vai ser passado lá por padrão, esse Teste vai ser passado por padrão para a nossa some_fun. No nosso caso essa iex não bate, não vai substituir nada, mas basicamente eu tenho uma função que pega o primeiro parâmetro e passa como primeiro parâmetro de alguma outra função.

[08:32] Se eu utilizo ela nesse cenário não faz sentido nenhum, mas se eu utilizo ela em um pipe operator, como ele diz aqui, isso faz todo sentido para eu ter uma legibilidade um pouco maior.

[08:42] Ao invés de ter isso daqui tudo adicionado direto na função, eu posso passar isso para um then e ter a função como um todo sendo definido ali.

[08:53] Espero não ter complicado mais do que simplificado, mas deixa eu tentar resumir: se eu preciso pegar o valor que veio do nosso pipe operator e passar como segundo ou terceiro parâmetro de alguma função, eu posso criar uma função anônima e utilizar essa função anônima aqui.

[09:11] Só que o pipe operator precisa sempre de uma chamada, de uma execução de função. Quando eu tenho uma função anônima eu preciso ter os pontos e os parênteses, lembra desse detalhe? Para eu não precisar fazer isso, para eu não precisar criar uma variável e dessa variável chamar esse operador eu posso colocar toda essa definição da função dentro do nosso then.

[09:36] Porque ele vai pegar o primeiro parâmetro e direto passar para essa função aqui, isso já é uma execução da função.

[09:42] O pipe operator, recapitulando sem toda essa complicação dos detalhes da documentação, podemos pegar um valor e passar como primeiro parâmetro para uma função logo depois desse operador. O resultado podemos passar como primeiro parâmetro da próxima função e assim em diante.

[09:58] Vamos encadeando chamadas do nosso pipe operator e dessa forma vamos realmente encadeando chamadas em cima de um dado. A recomendação é que esse dado seja sempre a primeira coisa que vamos utilizar.

[10:10] Com isso temos a definição pipe operator, mas eu quero chamar atenção para aquele cenário que eu exemplifiquei há um tempo de um número muito grande, imagine o número de um a um milhão, esse intervalo na verdade. Imagine que eu precise mapear, filtrar, somar, fazer o que eu quiser nesse intervalo grande aqui.

[10:30] Se eu tenho várias operações sendo executadas em vários momentos, em vários lugares diferentes vou percorrer um milhão de números. Isso, obviamente, é custoso, isso vai levar tempo, isso vai degradar a nossa performance. Como podemos otimizar esse cenário? Talvez esperar um pouco mais, deixar para executar tudo de uma vez só. Vamos entender um pouco melhor no próximo vídeo.

@@06
Possibilidades

Vimos neste vídeo que o Pipe Operator pega o valor à sua esquerda e passa como primeiro parâmetro da chamada de função à sua direita.
Que técnica podemos usar se quisermos passar o valor para um parâmetro que não seja o primeiro na chamada de função?

Funções anônimas.
 
Alternativa correta! Podemos criar uma função anônima que recebe o valor em questão e o passa para outra na ordem correta. Podemos até usar a função then para tornar essa escrita um pouco mais natural.
Alternativa correta
Guardas de cláusulas.
 
Alternativa correta
Pattern matching.

@@07
Para saber mais: Documentação

Se você quiser acessar a documentação oficial do Pipe Operator, pode conferir aqui: Elixir Kernel.

https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2

@@08
Streams

[00:00] Bem-vindos de volta. Vamos falar no cenário onde eu tenho todas as operações que eu fiz com a nossa tabuada, eu vou fazer mapeamento para multiplicar e gerar a tabuada em si, vou fazer um filtro e depois eu somo. Só que imagina isso para um intervalo muito grande, por exemplo, aquele de 1 a 1 milhão.
[00:23] Nesse cenário eu faria o mapeamento, aquela multiplicação por cada número, percorreria toda a lista, percorreria todo o intervalo. Depois eu percorreria todo o intervalo de novo para filtrar, para verificar quais desses números são inteiros. Depois eu percorreria todo esse intervalo de novo para somar cada um dos elementos.

[00:43] Eu precisaria percorrer três vezes esse intervalo gigante, isso não é interessante, isso não é performático. Só que podemos meio que "adiar" a execução disso tudo para o final. Para fazer isso, ao invés de utilizar as funções do módulo Enum, podemos utilizar as funções do módulo Stream.

[01:04] Esse módulo nos traz um novo tipo de dados, que é um string. Vamos ver o que eu quero dizer com isso, imagine esse cenário que eu utilizei aqui em cima e esse cenário eu vou passar ao invés de para Enum.map eu vou passar para Stream.map e aqui eu vou ter aquela nossa multiplicação, o primeiro número multiplicado por 5. Stream.map(%(&1 * 5)).

[01:24] Repare que isso aqui não nos retorna um intervalo, não retorna uma lista e nem nada do tipo, isso retorna um stream. Esse stream tem o conjunto de operações que serão executadas dentro do nosso enumerável, que nesse caso é um intervalo.

[01:40] Podemos compor esses streams, ou seja, eu posso passar esse stream para um outro stream e no final quando eu passar para alguma função do módulo Enum, aí sim todas as operações serão realmente executadas.

[01:56] Vamos continuar aqui, eu tenho esse intervalo passado para o nosso map, aqui vamos passar para um stream.filter que vai filtrar somente os pares, is_even e aqui no final podemos passar para o nosso Enum.sum e sim, vai executar todas as operações. Stream.filter(&Integer.is_even(&1)) |> Enum.sum().

[02:18] Ele leva um tempo mais porque estou executando em cima de 1 milhão e eu até pensei que dei um número errado, mas eu lembrei que eu não estou mais fazendo somente de 1 a 10 e sim de 1 a 1 milhão.

[02:30] Vamos tentar realizar todas as operações novamente só que utilizando Enum ao invés de stream. Se eu utilizo aqui Enum.map nesse momento essa operação vai ser executada, depois quando eu faço filter novamente todo esse número vai ser percorrido, todo esse intervalo. E no final com Enum.sum ele percorre uma última vez. Essa operação vai executada três vezes, mas temos o mesmo resultado.

[02:55] Assim economizamos memória e tempo de processamento ao utilizar o stream, só deixamos para executar tudo no final, não executamos uma parte e mandamos, executamos novamente e mandamos. Podemos percorrer uma vez só todo esse conjunto de dados aqui.

[03:11] Os streams são muito uteis quando temos conjuntos grandes ou até possivelmente infinitos. Porque se olharmos a documentação temos a possibilidade de criar enumeráveis infinitos, por exemplo, com ciclos. Vou criar esse stream aqui e nós temos ciclos, se eu tentar fazer um Enum.map desse ciclo aqui, desse stream e fazer algo como multiplicar esse dado por dois vamos ver o que acontece, vamos ficar executando infinitamente, eu vou ter que interromper aqui senão até gravação vai parar.

[03:46] Esse ciclo é infinito, eu posso ir pegando intervalos, eu posso a partir de um Enum pegar 10 desses itens desse ciclo, eu não lembro qual é a ordem dos parâmetros aqui, primeiro o ciclo e depois quantos itens desse ciclo eu quero pegar. Repare que ele vai se repetindo, podemos ter um conjunto infinito de dados, é perfeitamente possível.

[04:09] Se utilizarmos streams, garantimos que não vai ficar percorrendo um número infinito de dados, conseguimos adiar esse processamento e depois quando chamamos alguma função do módulo Enum aí sim todas as operações serão executadas.

[04:24] Isso é o que eu queria trazer para nós sobre os Enuns, sobre os streams, sobre pipe operator, sobre tudo isso que gira em torno de operações em cima de intervalo, enfim. Falamos bastante sobre enumeráveis, agora vamos sair um pouco desses novos tipos de dados e novas operações e vamos recapitular algo que já vimos um pouco só que não vimos de forma isolada, só vimos para dar alguns outros exemplos, que é como manipular arquivos.

[04:49] Vamos aprender a escrever, a ler em arquivos e até a lidar com caminhos. Como sabemos se precisa ou não adicionar uma barra ou um contra barra quando estamos separando diretórios. Vamos bater esse papo bem rápido no próximo capítulo.

@@09
Lazy Evaluation

Vimos neste vídeo que através do módulo Stream nós conseguimos ter múltiplas manipulações de algum enumerável sendo feitas de uma única vez, no final do conjunto de operações.
Como o módulo Stream faz isso?

Criando um simples array de funções a ser executado no final.
 
Alternativa errada! Assim esse array de funções seria executado no final, mas os conjuntos de dados seriam percorridos várias vezes ainda assim.
Alternativa correta
O módulo Stream não aplica efetivamente nenhuma das operações.
 
Alternativa correta! O módulo Stream apenas armazena as operações necessárias para serem executadas. No final, quando o módulo Enum receber um stream em alguma de suas funções, vai ser como unir essas operações e executar de uma vez só.
Alternativa correta
Na verdade o módulo Stream não tem esse propósito.

@@10
Faça como eu fiz

Chegou a hora de você seguir todos os passos realizados por mim durante esta aula. Caso já tenha feito, excelente. Se ainda não, é importante que você execute o que foi visto nos vídeos para poder continuar com a próxima aula.

Continue com os seus estudos, e se houver dúvidas, não hesite em recorrer ao nosso fórum!

@@11
O que aprendemos?

Nesta aula, aprendemos:
Entendemos o que são valores enumeráveis
Conhecemos o módulo Enum
Aprendemos sobre intervalos
Usamos o Pipe Operator
Conhecemos os streams para Lazy Evaluation de enumeráveis

####

@04-Lidando com arquivos

@@01
File.read

[00:00] Pessoal, bem-vindos de volta a mais um capítulo desse treinamento, onde estamos conhecendo um pouco mais sobre Elixir. Agora vamos aprender a lidar com arquivos. Para isso, eu vou criar uma nova pasta aqui só para não termos arquivos soltos e as coisas ficarem confusas. Só vou criar uma pasta chamada "arquivos".
[00:18] Vou criar aqui um novo módulo que vai lidar com arquivos. Vou chamar de "arquivos.exs", sem grilo, sem me preocupar muito em como nomear isso apropriadamente. Vou criar um novo módulo defmodule MeuModulo.Arquivos do. O que eu vou fazer? Primeiro, eu quero ler arquivos, então vou criar uma função que ler arquivos, def ler(arquivo) do, que vai receber aqui o caminho desse arquivo.

[00:42] Vamos lá. Primeiro, já vimos um pouco de como funciona a leitura, então sabemos que quando eu utilizo File.read(), eu vou ter aqui um retorno uma tupla, onde o primeiro elemento é ok em caso de sucesso ou error em caso de erro.

[01:00] Vamos conhecer alguns dos erros possíveis. Eu vou pegar aqui somente em caso de erro, o nosso erro em questão. Só isso que vou fazer. {:error, erro} = File.read(), e essa variável erro é o que eu vou retornar. {:error, erro} = File.read() erro. Eu só quero ver o nosso erro, só isso. Só que, claro, aqui eu preciso ler do arquivo em questão. {:error, erro} = File.read(arquivo) erro.

[01:18] Eu só criei um módulo para trabalharmos com ele. Certo? Vamos lá. Vou executar aqui dentro de "arquivos", então vou entrar na pasta "arquivos" e executar o meu módulo arquivos. Aqui eu posso chamar MeuModulo.Arquivos.ler("não_existe"), um arquivo que não existe. O que vamos ter aqui? Vamos ter um retorno :enoent, de "no entry".

[01:41] Aqui é um arquivo que simplesmente não existe. Agora deixa eu sair daqui e criar um arquivo. Esse comando touch arquivo simplesmente cria um arquivo, só que o que eu vou fazer? Deixa eu limpar o meu terminal e executar esse comando. Aqui no meu arquivo, através do meu usuário "vinicius.dias", eu posso ler e posso escrever.

[02:03] O que eu vou fazer? Eu vou remover a permissão de leitura, chmod-r, de leitura. Eu vou remover a permissão de leitura do meu arquivo. Eu preciso digitar a minha senha, e vamos ver se isso funcionou. Eu não posso mais ler. Esse arquivo não é mais possível de ser lido.

[02:24] Vamos de novo executar lá o nosso módulo e tentar executar MeuModulo.Arquivos.ler("arquivo"), meu arquivo que existe, então não vamos ter aquele mesmo erro, só que eu não tenho permissão. Repara que agora eu tenho um erro de acesso.

[02:39] Eu posso tratar os cenários de erro de várias formas diferentes, como eu preferir. Só que agora eu vou pegar o meu cenário de sucesso, eu vou realmente criar um arquivo e eu vou permitir a leitura dele. Deixa eu fechar aqui. Eu vou permitir a leitura daquele meu arquivo, chmod +r, ou seja, vou permitir a leitura em arquivo, e vou adicionar algum conteúdo aqui nele. "Adicionando conteúdo em mais de uma linha do meu arquivo". Simples assim.

[03:10] Agora se eu tentar executar esse meu código, o que você espera que aconteça? Vou executar aqui, tentar executar MeuModulo.Arquivos.ler("arquivo"). Quando eu tentar executar, erro de match, por quê? Eu só estou pegando o cenário de erro e isso entra naquele nosso caso onde falamos de poder ler cenários com erro ou não ou só tratar os cenários possuem erro ou não, ou só partir do princípio que vai dar certo, porque eu sei que o arquivo existe ou não.

[03:44] Eu vou utilizar essa variante aqui da função, essa nova função, essa função diferente, que permite que eu só consiga ler se o arquivo existir, se ele for acessível, se eu estiver espaço em memória suficiente. Em caso de erro, se esse arquivo não existir ou não for acessível, ele vai lançar logo uma exceção para nós.

[04:04] Eu posso pegar direto aqui o nosso conteúdo ou, ao invés de pegar o conteúdo, eu já vou retorná-lo. De novo, eu acabei gaguejando um pouco, se eu não coloco esse ponto de exclamação, como já vimos, o retorno é uma tupla, onde o primeiro elemento indica se foi com sucesso ou com erro.

[04:21] Já se eu adiciono o ponto de exclamação, o retorno é sempre uma string. E caso o arquivo não exista ou caso eu não tenha memória, caso o arquivo não tenha permissão para leitura, ele vai retornar um erro, ele vai lançar um erro, então não vamos ter um retorno aqui.

[04:36] Deixa eu recompilar esse meu módulo, MeuModulo.Arquivos, recompilado. Se eu tento ler esse arquivo, "adicionando conteúdo em mais de uma linha no meu arquivo". De novo, já falamos sobre isso, mas eu recapitular. Aqui, ele está mostrando o retorno, então por isso que ele tem essas quebras de linha sem serem quebras de linha. Se eu exibir isso ou tentar lidar com essa string de alguma forma, por exemplo, se eu tentar exibir esse dado com o IO.puts, aí ele vai adicionar as quebras de linha corretamente.

[05:11] Por quê? O IO.puts sabe lidar com string, sabe quando precisa quebrar linha e quando não precisa. Já o simples retorno não precisa quebrar linha para nós, ele mostra aqui: "existe esse carácter", se você vai utilizar ele como quebra de linha ou não é por seu critério. Aqui, já começamos a lidar com arquivos para conseguirmos ler e ler de formas distintas.

[05:33] Para esse vídeo não ficar muito grande, no próximo vídeo vamos mostrar uma mensagem de erro um pouco mais amigável em caso de erro. Se não conseguirmos ler por não existir o arquivo, por não ter acesso a ele, por não ter memória e etc. No próximo vídeo, eu volto mostrando todos os erros possíveis e como podemos tratá-los.

@@02
Diferenças

Vimos neste vídeo na prática a diferença entre a função File.read e File.read!.
Qual a diferença entre essas 2 funções?

@@A função File.read retorna uma tupla. A função File.read! retorna o conteúdo do arquivo.
 
Alternativa correta! Em caso de sucesso, a função File.read! retorna diretamente o conteúdo do arquivo e não uma tupla.
Alternativa correta
A função File.read! retorna uma tupla. A função File.read retorna o conteúdo do arquivo.
 
Alternativa correta
A função File.read! lança um erro em caso de falha ao ler o arquivo.
 
Alternativa correta! A função File.read apenas retornaria o erro em questão como segundo elemento da tupla retornada.

@@03
Lendo com erro

[00:00] Pessoal, bem-vindos de volta. Vamos ver como poderíamos lidar com esses cenários de erro só para praticarmos um pouco. Vamos lá. Eu posso pegar o retorno ao invés de lançar uma exceção para exibir uma mensagem mais amigável. Caso o retorno dessa leitura aqui seja "ok", então eu posso utilizar o pattern matching aqui, como já praticamos. Eu vou ter a variável conteúdo. case File.read(arquivo) do {:ok, conteúdo}.
[00:23] Eu posso ou exibir essa variável ou simplesmente retornar ela diretamente aqui, retornar esse conteúdo. case File.read(arquivo) do {:ok, conteúdo} -> IO.puts(conteúdo). Eu vou colocar para exibi-la ao invés de retornar e retornar um "ok", porque vamos ter as quebras de linhas bonitas. Caso tenhamos um erro, eu posso ter aqui qual é o erro que aconteceu e exibir, `{:error, erro} -> "Aconteceu algum erro". Aqui podemos lidar com esse erro de alguma forma.

[00:54] Vamos abrir o nosso terminal, deixa eu recompilar o MeuModulo.Arquivos e, claro, ele vai mostrar um aviso de que a variável erro não está sendo utilizada, então deixa eu por enquanto trocar ela por um underline, vamos utiliza-la daqui a pouco, mas por enquanto não. `{:error, _} -> "Aconteceu algum erro".

[01:13] Agora, eu posso limpar aqui e tentar exibir. MeuModulo.Arquivos.ler("teste"), esse arquivo "teste" não existe. Aconteceu algum erro. Se eu tentar ler "arquivo", vamos ter sucesso.

[01:28] É importante citar que eu executei o meu terminal interativo aqui dentro da pasta "arquivos. Se eu executasse esse terminal interativo em algum outro lugar, eu precisaria informar o caminho desse arquivo. Como eu estou na mesma pasta eu não preciso informar o caminho porque ele vai tentar ler o arquivo na mesma pasta, na pasta atual da execução.

[01:49] Se eu quisesse colocar mensagens específicas para erros diferentes? Primeiro precisamos conhecer quais são os erros. Dando uma olhada na documentação da função read(), temos aqui todos os erros possíveis. O de :enoent, que é o "no entry", o arquivo não existe, :eacces, que é que já tivemos também com permissão, :eisdir, ou seja, é um diretório, não é um arquivo.

[02:13] Se isso não é um diretório, ou seja, passamos vários componentes, um caminho completo, vamos dizer assim, se em algum desses caminhos, o que colocamos não é um diretório válido podemos ter esse retorno aqui. Em algumas plataformas, ele já retorna esse mesmo erro, de que o arquivo não existe. É um erro de que não existe memória o suficiente para lermos o conteúdo desse arquivo.

[02:35] Como é fácil simularmos esses erros aqui, vamos criar mensagens para eles. Na verdade, só esses dois para não perdermos muito tempo criando várias mensagens. Vamos lá. Eu vou ter o nosso erro e eu tenho duas saídas aqui: eu posso ou fazer um outro case e aqui no meu eu verificar se esse meu erro vai ser {:error, erro} -> case erro do :enoent -> "Arquivo inexistente" :eaces -> "Arquivo sem permissão de leitura”.

[03:20] Se der algum outro erro vamos exibir -> "Erro desconhecido". Vamos nessa. O que vou fazer? Vou primeiro gerar o erro de arquivo inexistente. Deixa eu recompilar meu módulo, deixa eu limpar aqui e tentar ler um arquivo que não existe, MeuModulo.Arquivos.ler("arquivoa"), esse arquivo não existe. Perfeito. Agora deixa eu abrir um outro terminal aqui, tirar a minha permissão, sudo chmod –r arquivos.arquivo. Deixa eu digitar minha senha.

[03:56] E agora eu vou tentar ler esse arquivo, MeuModulo.Arquivos.ler("arquivo"), eu vou ter arquivo sem permissão de leitura. Consegui fazer essa verificação. Agora, como eu disse, posso fazer dessa forma ou posso fazer o tratamento de outra forma. Eu vou verificar se é um erro, {:error, :enoent}, então já retorno direto "Arquivo inexistente".

[04:23] Deixa eu apagar isso daqui. Se for um erro e for um erro de acesso, eu exibo aqui "Arquivo sem permissão de leitura". Agora qualquer outra coisa que vier, eu coloco que é um erro desconhecido. {:error, :enoent} -> "Arquivo inexistente" {:error, :eacces} -> "Arquivo sem permissão de leitura. De novo estamos utilizando pattern matching para não precisar ter cases aninhados e etc.

[04:40] De novo, mais uma vez, outra vez, temos aqui o poder do pattern matching sendo exibido. Vamos lá. Deixa eu recompilar o meu módulo. Vamos de novo tentar ler esse arquivo, sem permissão de leitura. Se eu tento ler um arquivo inexistente, "Arquivo inexistente". Deixa eu me dar a permissão de leitura de novo. Vou adicionar o mais aqui, sudo chmod +r arquivos/arquivo. Se eu tentar ler esse arquivo agora, estará lá o nosso conteúdo sendo exibido.

[05:11] Entendemos os retornos, conhecemos aqui os cenários de erro que podem acontecer, vimos como tratar na prática utilizando case. Claro que você utilizar if, cond ou qualquer outra estrutura de decisão que vimos no treinamento anterior, mas essas são as formas de tratarmos os erros.

[05:31] Agora, ao invés de ler um arquivo, e se eu quiser escrever nele, quais são as abordagens que podemos tomar, como fazemos para escrever em arquivos? Vamos bater esse papo no próximo vídeo.

@@05
File vs IO

Neste vídeo nós vimos que tanto o módulo File quanto o módulo IO possuem métodos write.
Qual a diferença de File.write para IO.write?

File.write cria um novo processo do elixir para escrever no caminho informado.
 
Alternativa correta! O File.write espera por parâmetro um caminho de um arquivo e cria um novo processo do Elixir para escrever neste arquivo. Se tivermos essa operação sendo executada várias vezes, vários processos vão ser criados. Já o IO.write espera o identificador de um arquivo já aberto, logo, não precisa criar um novo processo a cada escrita.
Alternativa correta
File.write escreve sem uma quebra de linha no final do arquivo. IO.write adiciona a quebra de linha.
 
Alternativa errada! Essa é na verdade a diferença entre IO.write e IO.puts.
Alternativa correta
IO.write cria um novo processo do elixir para escrever no caminho informado.
 
Alternativa errada! É o contrário.

@@06
Módulo Path

[00:00] Pessoal, bem-vindos de volta. Nesse vídeo, vamos falar bem rápido sobre um módulo que pode nos ajudar um pouco a realizar alguns trabalhos. O que acontece? As funções para lidar com arquivos precisam de um caminho. O File.open() precisa do caminho correto desse arquivo para conseguir abrir e, a partir disso, manipularmos.
[00:19] O File.read() mesma coisa, File.write() também. Todas elas trabalham com um caminho de um arquivo. Só que às vezes para eu achar esse arquivo, eu preciso de algumas manipulações no caminho. Por exemplo, imagina que eu queira encontrar um arquivo que esteja no diretório do usuário, só que eu não sei qual é o diretório do usuário, mas sabemos que em qualquer sistema UNIX o til representa o diretório do usuário.

[00:46] Eu posso utilizar, por exemplo, Path.expand("~") como diretório do usuário e eu vou ter aqui o nome do arquivo, por exemplo, Path.expand("~/nome_arquivo.txt"). Estou expandindo esse caminho relativo para um caminho real, que eu posso utilizar e isso o nosso módulo Path já faz para nós. Se eu tentar fazer um Path.absname, ele vai fazer algo bastante parecido com o expand, só que ele não vai tentar fazer o parse de til, não vai tentar fazer o parse de ponto, não vai tentar fazer o parse de nada disso, de ponto ponto.

[01:21] O que ele vai fazer? Ele vai pegar do diretório atual e te dar um nome completo desse caminho aqui. Vamos lá. Deixa eu pegar esse caminho teste e ele vai entregar do diretório atual, que é onde eu estou trabalhando, ele vai unir com esses detalhes aqui que eu adicionei, ele não vai tentar resolver. Falando em pegar diretório, unir diretórios, podemos fazer o Path.join de várias pastas que eu tenho.

[01:45] Por exemplo, eu quero pegar a minha pasta raiz e eu quero de "usuários" e eu quero unir com "vinicius.dias". Path.join("/Users", "vinicius.dias"). Isso vai retornar esses diretórios já unidos. Se eu tirar essa barra aqui, ele vai pegar sem a barra no início, claro, e eu posso fazer aquilo de utilizar o pipe operator, por exemplo, e isso aqui eu posso passar para o Path.expand(), e vou pegar o caminho completo desse caminho que eu especifiquei, que eu fiz a junção, só que se eu pegar aqui da barra, ele me entrega a partir da raiz.

[02:20] Basicamente, esse módulo Path traz para nós várias funções para lidarmos com caminhos e não arquivos. Tanto é que dando uma olhada aqui, a maioria dessas funções não interagem com o sistema de arquivos em si, ele não ver se algo existe. A exceção são algumas funções, como por exemplo expand que já utilizamos porque ela precisa saber qual é o usuário que está logado para saber qual é o diretório do usuário. Ela vai precisar acessar o sistema de arquivos em si.

[02:49] Fora isso, essas funções nem acessam o sistema de arquivos. Elas são muito rápidas, só que elas não precisam que um diretório exista, não precisam que um arquivo exista e nem nada do tipo. Elas vão criar esse caminho para você. Aqui temos várias dessas funções. Para pegar o nome de uma extensão, unir caminhos, separar esses caminhos, tentar parsear o wildcard, ou seja, aqueles asteriscos e etc.

[03:14] Podemos fazer muita coisa com esse módulo e ele nos ajuda a trabalhar com um sistema de arquivos. Quando falamos de sistema de arquivos, é interessante saber também que quando lidamos com esses arquivos utilizando o módulo File que já vimos, como eu já falei, ele cria um novo processo para cada operação. Se temos uma operação acontecendo dentro de uma recursão, dentro de um loop, precisamos nos preocupar com a quantidade de processos que vão ser criados.

[03:41] Como eu falei, podemos deixar para o futuro bater esse papo legal sobre processos, como criar, a diferença entre um processo do sistema operacional e um processo da Erlang, do Elixir. Eu vou encerrar por aqui esse módulo de falar sobre arquivos, lidar com caminhos e etc., para podemos ver formas diferentes de executarmos os nossos códigos em Elixir.

[04:02] Temos visto, executamos até aqui somente utilizando o terminal interativo. Como funciona o processo de compilação se eu quiser? Como que eu posso executar um arquivo de script sem o terminal interativo? E também como que fazemos de forma profissional? Não vamos criar um projeto profissional ainda, mas vamos bater o olho em como faríamos, que no futuro, quando realmente formos aplicar, você já ouviu falar desses termos, você já sabe o que significa e vamos poder avançar um pouco mais rápido.

[04:30] Vamos falar exatamente sobre isso tudo, de como executar os nossos códigos, no próximo capítulo.

@@07
Faça como eu fiz

Chegou a hora de você seguir todos os passos realizados por mim durante esta aula. Caso já tenha feito, excelente. Se ainda não, é importante que você execute o que foi visto nos vídeos para poder continuar com a próxima aula.

Continue com os seus estudos, e se houver dúvidas, não hesite em recorrer ao nosso fórum!

@@08
O que aprendemos?

Nesta aula, aprendemos:
Aprendemos a ler um arquivo com Elixir
Conhecemos os possíveis erros ao se ler um arquivo
Aprendemos a escrever em um arquivo
Conhecemos um pouco melhor o módulo IO
Fomos apresentados ao módulo Path

#### 08/09/2023

@05-Formas de execução

@@01
Projeto da aula anterior

Caso queira, você pode baixar aqui o projeto do curso no ponto em que paramos na aula anterior.

https://github.com/alura-cursos/2310-elixir/archive/refs/tags/curso-2-aula-4.zip

@@02
Compilando um módulo

[00:00] Bem-vindos de volta a mais um capítulo desse treinamento onde estamos conhecendo um pouco mais sobre o Elixir. E agora falando sobre conhecer, sobre o Elixir vamos conhecer sobre como podemos executar código em Elixir porque até agora só utilizamos o nosso terminal interativo.
[00:17] Só que não queremos sempre precisar do terminal interativo. Existem algumas outras formas de começarmos a utilizar o nosso código.

[00:25] Vou interromper o terminal interativo e vamos pegar o nosso módulo de arquivos, por exemplo. Eu quero transformar esse módulo de arquivos em um módulo compilado, em um módulo pronto para ser importando por algum código que vai ser executado.

[00:44] Para isso eu vou entrar na pasta Arquivos e eu vou rodar o comando Elixir.c de compiler, eu vou rodar o comando de compilação do Elixir passando esses arquivos ponto exs para esse compilador. elixirc arquivos.exs.

[01:00] Antes de fazer isso eu não vou passar esses arquivos exs, eu vou renomeá-lo de arquivos.exs para arquivos.ex. Porque esse s no final é de script, é um Elixir script, isso quer dizer que é um código para ser executado diretamente. Só que o nosso caso não é um código para ser executado diretamente, ele é um módulo que vai ser compilado e algum outro arquivo que vai executar esse módulo.

[01:27] Eu tenho aqui o meu código arquivos.ex e ele sim vai ser compilado pelo Elixir. Um detalhe importante é que extensões em um sistema operacional são meras convenções. Se eu quiser chamar esse arquivo de arquivos.calopsita vai continuar compilando sem problema.

[01:45] Só que é interessante seguirmos essas convenções para sabermos o que cada arquivo está fazendo. Assim como aqui nesse meu arquivo de texto, seria interessante eu ter um ponto txt. Só que, de novo, extensões são só cortesias do sistema operacional, não precisamos delas. Só que é interessante para nós humanos conseguirmos saber o que cada arquivo está fazendo.

[02:04] Continuando, eu vou chamar o compilador do Elixir para esse meu arquivo chamado arquivos. Ele leva um tempinho e gera um novo arquivo, um arquivo que o Visual Studio Code não abre, por quê? Se eu tentar exibir esse arquivo ele tem um monte de caractere estranho porque ele é um arquivo binário, é um arquivo para ser executado.

[02:24] Só que não diretamente pelo sistema operacional e sim por algum código Elixir. Aqui já vimos como transformar o nosso código, o nosso arquivo, o nosso módulo e um arquivo binário, em algo que vai ser executado pela máquina virtual do Elixir, pela Erlang.

[02:43] Só que aí que está o detalhe, como vamos executar esse código? Por enquanto voltamos para o famigerado do terminal interativo. Se estou dentro de uma pasta que possui um “arquivo.beam”, que é um arquivo compilado da Erlang eu consigo acessar, eu consigo executar código e sem importar, sem fazer nada, sem definir o nome do arquivo eu consigo utilizar o módulo.

[03:12] O MeuModulo.Arquivos.ler("arquivo") está disponível para nós, eu consigo acessar esse código mesmo que eu não tenha mais esse arquivo nesse local. Porque estou executando o meu terminal interativo ou executando o Elixir em um local que eu tenho o módulo definido, o meu “arquivo.beam”.

[03:32] Essa é a primeira etapa para termos um código realmente executável pelo Elixir. Agora, como eu falei, nós temos os arquivos de Elixir e os arquivos Elixir script, ou seja, um arquivo que vai ser diretamente rodado pela nossa máquina virtual.

[03:47] Vamos fazer isso, vamos criar um arquivo de script para executar esse módulo no próximo vídeo.

@@03
ElixirC

Nesse vídeo nós usamos o "compilador" do elixir, o elixirc. Nós podemos passar um arquivo contendo um módulo para esse "compilador" e ele nos gera um novo arquivo.
O que é gerado pelo elixirc?

Um arquivo com o bytecode que será lido pela Erlang VM.
 
Alternativa correta! O "compilador" elixirc está entre aspas justamente por não compilar realmente o código para um executável do sistema operacional. Ele transforma nosso código em um conjunto de instruções que a Erlang VM saiba executar.
Alternativa correta
Um arquivo com o código escrito em Erlang.
 
Alternativa correta
Um arquivo binário do sistema operacional.

@@04
Arquivos de script

[00:00] Bem-vindos de volta. No último vídeo aprendemos a compilar um módulo do Elixir para um arquivo que vai ser meio que um arquivo "binário". Aquele binário que vimos é um bytecode que a máquina virtual do Erlang consegue parsear e executar.
[00:17] Como podemos executar efetivamente aquilo? Conforme podemos ver na documentação, que no guia, na parte de módulos e funções ele explica sobre essa complicação.

[00:27] Aqui se eu executar algum script, por exemplo, através de um terminal interativo dentro da pasta onde aquele nosso bytecode está eu tenho acesso aquele módulo.

[00:37] Repare que eu posso executar um script dentro da pasta onde o bytecode está e isso pode ser através de um terminal interativo ou do modo de script, que podemos executar simplesmente tendo um arquivo de script.

[00:49] Vamos fazer exatamente isso. Vamos no nosso projeto e além do arquivo de módulo, eu vou ter aqui um arquivo de script. E esse arquivo de script como ele está na mesma pasta que esse binário aqui, que o nosso módulo arquivo está, eu posso utilizar diretamente o MeuModulo.Arquivos.ler("arquivo"), e isso vai exibir aquela mensagem para nós, vai exibir o conteúdo do arquivo.

[01:19] E se eu tentar ler um arquivo não existente ele vai nos retornar, posso até fazer um IO.puts, eu vou exibir a mensagem de erro. Eu não vou executar isso através do terminal interativo, eu vou executar através do Elixir.

[01:40] Com o comando Elixir eu posso executar um arquivo de script. Ele vai pegar isso, carregar a máquina virtual, rodar cada uma das linhas e encerrar a nossa máquina virtual.

[01:51] Isso é principalmente útil para um ponto de entrada de aplicação, para testes ou no nosso caso, para brincar um pouquinho executando os nossos módulos.

[02:00] Quando eu executo isso daqui, ele levanta a máquina virtual, roda a primeira linha, roda a segunda linha, roda a segunda linha e encerra a máquina virtual.

[02:07] Claro que normalmente em um cenário real, em uma aplicação real, não vamos ficar levantando e derrubando uma máquina virtual, vamos ter algum processo que mantém essa máquina virtual de pé e gerenciando, inclusive vários outros processos, caso algum processo morra, caso algum processo tenha um crash, tenha algum problema, um outro processo vai ser criado.

[02:28] Isso tudo podemos alcançar utilizando uma ferramenta que torna os nossos projetos mais profissionais. Não vamos entrar nesses detalhes nesse treinamento, mas no próximo vídeo eu quero só te mostrar do que estou falando, qual o nome da ferramenta e mais ou menos como se parece um projeto profissional.

[02:45] Te espero no próximo vídeo só para darmos uma espiada nessa parte que ainda não vamos tratar nesse treinamento, mas quem sabe em um futuro treinamento.

@@05
Scripts

Neste vídeo nós executamos diretamente um código Elixir.
O que o comando elixir faz por baixo dos panos?

Sobe uma Erlang VM, roda nosso código e encerra a Erlang.
 
Alternativa correta! A cada execução, um novo processo contendo a Erlang vai ser executado.
Alternativa correta
Anexa nosso código à Erlang VM já rodando em nosso sistema.
 
Alternativa correta
Compila nosso código e anexa o bytecode à Erlang VM já rodando em nosso sistema.

@@06
Bônus: Mix

[00:00] Bem-vindos de volta. Dando uma olhada ainda no guia onde temos a parte de módulos e funções que foi onde vimos sobre compilação, ele cita uma outra ferramenta que pode nos ajudar a trabalhar com projeto profissional.
[00:17] Ele fala que normalmente os projetos de Elixir tem uma pasta build que vai ter os artefatos compilados, aqueles nossos “arquivos.beam”, vai ter uma pasta lib que vai ter o nosso código fonte e vai ter uma pasta de testes que vão ter nossos testes automatizados.

[00:32] Só que quando estamos trabalhando com projetos reais, normalmente é utilizado uma ferramenta chamada Mix. E essa ferramenta já vem para nós instalada quando instalamos o Elixir. Se eu abrir aqui o meu terminal e digitar mix help eu vou ter essa saída com vários comandos que podemos utilizar.

[00:49] Para eu criar um projeto utilizando o Mix, ao invés de criar uma nova pasta e sair criando meus arquivos eu utilizo mix new e o nome do projeto que eu quero criar, isso já vai criar uma pasta, um módulo principal e já vai definir todas aquelas pastas, já vai definir as configurações e ele vai começar a nos ajudar.

[01:08] Se dermos uma olhada aqui na documentação do Mix, ele é basicamente uma ferramenta de build, só que é uma ferramenta de build muito poderosa que nos deixa fazer o build do projeto, definir dependências e buscá-las, definir as configurações do projeto, definir aplicações que vamos utilizar dentro do nosso projeto. Enfim, muita coisa, é uma ferramenta muito poderosa.

[01:30] Ela depende de um arquivo de script, ou seja, um arquivo que ele vai ser executado e gerar nosso artefato, vai gerar a aplicação em si que a Erlang vai rodar. Aqui temos as definições do nosso projeto que vão ser chamadas pelo projeto do Mix, o Mix tem o código dele, tem a classe dele que vai ser executado, vai chamar as definições do nosso projeto e aí podemos ter aqui dependências, configurações, aplicações extra, tarefas, enfim, muita coisa.

[01:58] Vários ambientes diferentes para executar. Por exemplo, em um ambiente de produção eu posso não ter debug, não ter logs demais e etc. Já no meu ambiente de desenvolvimento eu quero ter o máximo de logs e o máximo de debug possível, no ambiente de testes eu posso me conectar a um serviço externo. Enfim, eu posso ter ambientes diferentes e o Mix vai cuidar de tudo isso para nós.

[02:20] É através de um projeto utilizando o Mix que eu posso, por exemplo, anexar aplicações que ficam verificando meus processos, eu posso ter um supervisor de meus processos. Se algum processo do Elixir morre ele já cria outro, ele garante que sempre existe um número x processos de path. Isso tudo é feito através dessa ferramenta chamada Mix.

[02:44] De novo, ela já vem instalada quando eu instalo o Erlang e o Elixir, na verdade. Eu já tenho tudo aqui pronto para começar projetos profissionais com Elixir. Aqui no guia, assim como vimos vários detalhes da linguagem em si, temos todo um guia específico para o Mix.

[03:03] Aqui vemos a introdução, depois começamos a falar sobre a Agente, servidores, os supervisor, como eu falei, e muitas outras coisas que podemos talvez, quem sabe tratar em um treinamento futuro. Podemos trazer esse detalhe criando uma aplicação real utilizando o Mix.

[03:18] Como esse treinamento já está longo e o foco era a linguagem e não o ecossistema Elixir, vamos encerrar por aqui com aquele famoso tchau, tchau. No próximo vídeo, recapitulamos tudo o que vimos no próximo treinamento.

@@07
Faça como eu fiz

Chegou a hora de você seguir todos os passos realizados por mim durante esta aula. Caso já tenha feito, excelente. Se ainda não, é importante que você execute o que foi visto nos vídeos para poder continuar com os próximos cursos que tenham este como pré-requisito.

Continue com os seus estudos, e se houver dúvidas, não hesite em recorrer ao nosso fórum!

@@08
Projeto final do curso

Caso queira, você pode baixar aqui o projeto completo implementado neste curso.

https://github.com/alura-cursos/2310-elixir/archive/refs/tags/curso-2-aula-5.zip

@@09
O que aprendemos?

Nesta aula, aprendemos:
Aprendemos a usar o elixirc para "compilar" um módulo
Vimos como usar um módulo compilado pelo interpretador "elixir"
Falamos um pouco sobre o Mix

@@10
Conclusão

[00:00] Parabéns por terem chegado ao final de mais um treinamento de Elixir e nesse treinamento nos aprofundamos um pouco mais e alguns detalhes da sintaxe. Saímos um pouco do básico, de coisas que toda linguagem tem e entrou em algumas especificidades, coisas do próprio Elixir.
[00:17] Inicialmente aprendemos sobre as guard clauses, as cláusulas de guarda. Entendemos que cada definição de uma função com o mesmo nome é uma cláusula e podemos ter guardas para essa cláusula, para saber quando ela vai ser executada ou não.

[00:34] A partir dessas cláusulas fomos avançando, vimos sobre parâmetros padrão, como definir parâmetros padrão e como ter uma definição de cabeçalho de função. Batemos um papo sobre as convenções de nome, por exemplo, aqui utilizamos um ponto de interrogação no nome de uma função e isso é relativamente comum em Elixir e entendemos o motivo disso.

[00:56] Entramos no assunto de recursão, praticamos um pouco, cumprimos o desafio que eu deixei no treinamento anterior criando a tabuada que retorna uma lista ao invés de exibir todos os dados. Falamos bastante sobre tail recursion.

[01:11] Aqui falando sobre tail recursion, falamos sobre o que é isso, como implementar, a dificuldade que isso traz e as vantagens falando sobre tail call optimization.

[01:23] Em cima disso entramos falando sobre enumeráveis, sobre valores que são enumeráveis como, por exemplo, listas, mapas e trabalhamos também com intervalos, trabalhamos com funções do módulo Enum.

[01:35] E falando sobre funções do módulo Enum, quando precisamos juntar várias dessas funções é muito comum utilizarmos o operador de pipe, o pipe operator.

[01:44] Falamos um pouco de performance de novo falando sobre o módulo de streams, para termos a avaliação preguiçosa, a lazy evaluation das operações através dos streams.

[01:55] Terminando isso entramos na parte de arquivos, brincamos um pouco lendo arquivos, escrevendo arquivos e terminamos com o nosso módulo bem simples que ler o arquivo ou exibe uma mensagem de erro.

[02:06] Nós também falamos de escrita, falamos, claro, sobre performance na hora de trabalhar com arquivos. E no final, como você ter percebido, temos um arquivo com uma extensão diferente.

[02:16] Compilamos esse módulo e o executamos através de um arquivo de script. No final, até batemos um papo sobre o Mix, assunto que podemos tratar em um treinamento futuro.

[02:27] Se durante esse treinamento e o assunto desse treinamento ficou alguma dúvida não hesite, você pode abrir uma questão lá no fórum, eu tenho que responder pessoalmente sempre que possível, mas quando eu não consigo temos uma vasta comunidade cheia de pessoas que com certeza conseguirão te ajudar.

[02:41] Alunos, moderadores, instrutores, com certeza alguém vai conseguir responder sua dúvida. Não deixe a dúvida em aberto. Inclusive, fica aqui o convite para você também responder às dúvidas de outras pessoas que postam lá. Porque assim a comunidade cresce, você conhece novas pessoas e faz o network bem interessante.

[02:59] Mais uma vez parabéns por ter chegado ao final de mais um treinamento, espero que você esteja gostando dessa sua jornada com o Elixir e espero te ver em futuros treinamentos aqui da Alura. Forte abraço e tchau, tchau.