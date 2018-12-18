<%--
  Created by IntelliJ IDEA.
  User: caiop
  Date: 05/11/2018
  Time: 21:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Entrar : To-Do</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- Main CSS -->
    <link rel="stylesheet" href="css/main.css">
</head>
<body>

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
                    <a class="nav-link js-scroll-trigger" href="index.jsp">Ínicio</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="cadastrar.jsp">Cadastrar</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="entrar.jsp">Entrar</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<section style="padding-top: 150px;">
    <div class="container">
        <div class="row">
            <div class="col-sm-6 offset-3">
                <div class="card">
                    <div class="card-body">
                        <form action="UsuarioCtr?action=doSignIn" method="post">
                            <div class="form-group text-center">
                                <span class="todo-title">To-Do</span>
                            </div>
                            <div class="form-group">
                                <input class="form-control form-control-lg" type="text" name="usuario" id="usuario" placeholder="Usuário">
                            </div>
                            <div class="form-group">
                                <input class="form-control form-control-lg" type="password" name="senha" id="senha" minlength="6" placeholder="Senha">
                            </div>
                            <% if (request.getAttribute("mensagem") != null) { %>
                            <div class="form-group">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    ${mensagem}
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </div>
                            <% } %>
                            <%--<div class="form-group text-center">
                                <small class="text-danger">
                                    ${mensagem}
                                </small>
                            </div>--%>
                            <div class="form-group">
                                <input class="btn btn-success btn-block" type="submit" value="Entrar">
                            </div>
                            <div class="form-group text-center">
                                <a href="cadastrar.jsp">Não possui conta? Cadastre-se!</a>
                            </div>
                            <div class="form-group text-center">
                                <a href="#">Esqueci Minha Senha!</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Bootstrap core JavaScript -->
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>
</body>
</html>
