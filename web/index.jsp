<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">

<% //HttpSession sess = request.getSession(); %>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>To-Do</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/scrolling-nav.css" rel="stylesheet">

</head>

<body id="page-top">

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
    <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="index.jsp">To-Do</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="#about">Sobre</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="#contact">Contato</a>
                </li>
                <% if (session.getAttribute("usuario") == null) { %>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="cadastrar.jsp">Cadastrar</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="entrar.jsp">Entrar</a>
                </li>
                <% } else { %>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="/TarefaCtr?action=listTasks">Dashboard</a>
                </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<header class="bg-primary text-white">
    <div class="container text-center">
        <h1>To-Do</h1>
        <p class="lead">Gerencie suas tarefas!</p>
    </div>
</header>

<section id="about">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 mx-auto">
                <h2>Sobre</h2>
                <p class="lead">To-Do é uma ferramenta para gerenciar suas tarefas de forma fácil.</p>
                <ul>
                    <li>Crie, Edite e Exclua tarefas.</li>
                    <li>Organize suas tarefas por Estado.</li>
                    <li>Crie Estados personalizados.</li>
                    <li>Todas as tarefas excluídas são armazenadas na Lixeira.</li>
                    <li>Exclua Permanentemente ou Restaure suas tarefas da Lixeira.</li>
                </ul>
            </div>
        </div>
    </div>
</section>

<section id="contact">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 mx-auto">
                <h2>Contato</h2>
                <p class="lead">Para contato, dúvidas, sugestões e correções; Crie uma Issue no repositório do projeto no
                    <a href="https://github.com/caiopiassali" target="_blank">GitHub</a>.
                </p>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="py-5 bg-dark">
    <div class="container">
        <p class="m-0 text-center text-white">Copyright &copy; 2018 - <a href="https://github.com/caiopiassali" target="_blank">Caio Piassali</a>.</p>
    </div>
    <!-- /.container -->
</footer>

<!-- Bootstrap core JavaScript -->
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>

<!-- Plugin JavaScript -->
<script src="js/jquery.easing.min.js"></script>

<!-- Custom JavaScript for this theme -->
<script src="js/scrolling-nav.js"></script>

</body>

</html>
